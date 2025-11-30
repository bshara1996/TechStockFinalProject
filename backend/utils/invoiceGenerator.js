const PDFDocument = require("pdfkit");
const fs = require("fs");
const path = require("path");
const dbSingleton = require("../dbSingleton.js");
const { convertFromILS } = require("./exchangeRate");

function formatCurrencyWithCommas(value) {
  return Number(value).toLocaleString(undefined, {
    minimumFractionDigits: 2,
    maximumFractionDigits: 2,
  });
}

class InvoiceGenerator {
  constructor() {
    this.doc = new PDFDocument({ margin: 50 });
    this.db = dbSingleton.getConnection();
  }

  async getVatRate() {
    try {
      const [settings] = await this.db.query(
        "SELECT taxRate FROM settings LIMIT 1"
      );
      if (settings.length > 0 && settings[0].taxRate !== null) {
        return parseFloat(settings[0].taxRate) || 0;
      }
    } catch (err) {
      console.error("Error fetching VAT rate:", err);
    }
    return 0; // Default to 0 if no settings found
  }

  async getCurrencySymbol() {
    try {
      const [rows] = await this.db.query(
        "SELECT currency FROM settings LIMIT 1"
      );
      if (rows.length > 0 && rows[0].currency) {
        const currency = rows[0].currency;
        // For ILS, use "ILS" or "Shekels" text instead of symbol for better PDF compatibility
        if (currency === "ILS") {
          return "ILS"; // Use "ILS" text instead of symbol for better PDF font support
        }
        const currencySymbols = {
          USD: "$",
          EUR: "€",
          GBP: "£",
        };
        return currencySymbols[currency] || currency;
      }
    } catch (err) {
      console.error("Error fetching currency:", err);
    }
    return "ILS"; // Default to ILS text if no settings found
  }

  async generateInvoice(orderData, userData) {
    const {
      order_id,
      order_date,
      total_amount, // not used in PDF calc but kept for consistency
      shipping_address,
      payment_method,
      items,
      promotion,
      discount_amount,
    } = orderData;
    const { name, email } = userData;

    const currencySymbol = await this.getCurrencySymbol();
    const vatRate = await this.getVatRate();

    // Get currency code from settings
    let currencyCode = "ILS";
    try {
      const [rows] = await this.db.query(
        "SELECT currency FROM settings LIMIT 1"
      );
      if (rows.length > 0 && rows[0].currency) currencyCode = rows[0].currency;
    } catch (err) {
      console.error("Error fetching currency code:", err);
    }

    // Prepare file
    const fileName = `invoice_${order_id}_${Date.now()}.pdf`;
    const filePath = path.join(__dirname, "../uploads/invoices", fileName);

    const invoicesDir = path.dirname(filePath);
    if (!fs.existsSync(invoicesDir)) {
      fs.mkdirSync(invoicesDir, { recursive: true });
    }

    const stream = fs.createWriteStream(filePath);
    this.doc.pipe(stream);

    // Get page width to avoid white strip on the right
    const pageWidth = this.doc.page.width;

    /* -----------------------------------------------------
     TOP DARK HEADER (full width)
  ------------------------------------------------------*/
    const headerHeight = 110;
    this.doc.rect(0, 0, pageWidth, headerHeight).fill("#0f172a");

    // Logo / title
    this.doc.fillColor("#ffffff").fontSize(28).text("TechStock", 40, 30);

    this.doc
      .fontSize(12)
      .fillColor("#cbd5e1")
      .text("Your Trusted Tech Partner", 40, 65);

    // Blue INVOICE box, right-aligned
    const invoiceBoxWidth = 150;
    const invoiceBoxHeight = 55;
    const invoiceBoxX = pageWidth - invoiceBoxWidth - 40; // 40px right margin
    const invoiceBoxY = 25;

    this.doc
      .fillColor("#2563eb")
      .roundedRect(
        invoiceBoxX,
        invoiceBoxY,
        invoiceBoxWidth,
        invoiceBoxHeight,
        8
      )
      .fill();

    this.doc
      .fillColor("#ffffff")
      .fontSize(10)
      .text("INVOICE", invoiceBoxX, invoiceBoxY + 8, {
        width: invoiceBoxWidth,
        align: "center",
      });

    this.doc
      .fontSize(18)
      .text(
        `#${String(order_id).padStart(6, "0")}`,
        invoiceBoxX,
        invoiceBoxY + 28,
        {
          width: invoiceBoxWidth,
          align: "center",
        }
      );

    /* -----------------------------------------------------
     INVOICE DETAILS / BILL TO
  ------------------------------------------------------*/
    this.doc.moveDown(4.2);

    const leftX = 40;
    const rightX = 310;

    this.doc.fontSize(12).fillColor("#475569").text("INVOICE DETAILS", leftX);

    this.doc
      .fontSize(10)
      .fillColor("#1e293b")
      .text(
        `Invoice Date: ${new Date(order_date).toLocaleDateString("en-US", {
          year: "numeric",
          month: "long",
          day: "numeric",
        })}`,
        leftX,
        this.doc.y + 2
      )
      .text(`Payment Method: ${payment_method}`, leftX);

    this.doc.fontSize(12).fillColor("#475569").text("BILL TO", rightX, 160);

    this.doc
      .fontSize(10)
      .fillColor("#1e293b")
      .text(`Name: ${name}`, rightX)
      .text(`Email: ${email}`, rightX)
      .text(`Shipping Address: ${shipping_address}`, rightX);

    /* -----------------------------------------------------
     ORDER ITEMS TABLE
  ------------------------------------------------------*/
    this.doc.moveDown(2);

    this.doc.fontSize(15).fillColor("#1e293b").text("Order Items", leftX);

    this.doc
      .fontSize(9)
      .fillColor("#64748b")
      .text(`Currency: ${currencyCode}`, pageWidth - 140, this.doc.y - 15);

    const tableY = this.doc.y + 10;

    this.doc
      .roundedRect(leftX, tableY, pageWidth - leftX * 2, 30, 15)
      .fill("#0f172a");

    this.doc
      .fontSize(12)
      .fillColor("#ffffff")
      .text("Product", leftX + 20, tableY + 9)
      .text("Qty", leftX + 230, tableY + 9)
      .text("Unit Price", leftX + 320, tableY + 9)
      .text("Total", leftX + 430, tableY + 9);

    let y = tableY + 32;

    const convertedItems = await Promise.all(
      items.map(async (item) => {
        const p = parseFloat(item.price) || 0;
        const q = parseInt(item.quantity) || 0;
        const c = await convertFromILS(p, currencyCode);
        return {
          ...item,
          price: c,
          total: c * q,
        };
      })
    );

    const rowWidth = pageWidth - leftX * 2;

    convertedItems.forEach((item, index) => {
      const rowBg = index % 2 === 0 ? "#f8fafc" : "#ffffff";

      this.doc
        .rect(leftX, y, rowWidth, 28)
        .fill(rowBg)
        .strokeColor("#e2e8f0")
        .stroke();

      // item.price and item.total are already WITH tax from database
      const priceWithTax = item.price;
      const totalWithTax = item.total;

      this.doc
        .fontSize(11)
        .fillColor("#1e293b")
        .text(item.product_name, leftX + 20, y + 8)
        .text(item.quantity, leftX + 240, y + 8)
        .text(
          `${currencySymbol}${formatCurrencyWithCommas(priceWithTax)}`,
          leftX + 315,
          y + 8
        )
        .text(
          `${currencySymbol}${formatCurrencyWithCommas(totalWithTax)}`,
          leftX + 430,
          y + 8
        );

      y += 28;
    });

    /* -----------------------------------------------------
     SUMMARY BOX (with border + padding)
  ------------------------------------------------------*/
    const summaryTop = y + 30;
    const summaryBoxX = pageWidth - 260; // 230 width + 30 margin
    const summaryBoxWidth = 230;
    const summaryBoxHeight = 180;

    this.doc
      .lineWidth(1.5)
      .strokeColor("#d1d5db")
      .fillColor("#ffffff")
      .roundedRect(
        summaryBoxX,
        summaryTop,
        summaryBoxWidth,
        summaryBoxHeight,
        12
      )
      .fillAndStroke();

    const innerLeft = summaryBoxX + 20;
    const innerRight = summaryBoxX + summaryBoxWidth - 20;
    const innerWidth = innerRight - innerLeft;

    let sy = summaryTop + 15;

    this.doc.fontSize(13).fillColor("#334155").text("Summary", innerLeft, sy);

    sy += 25;

    let convertedDiscount = await convertFromILS(
      discount_amount || 0,
      currencyCode
    );

    if (promotion && convertedDiscount > 0) {
      // Discount tag
      this.doc.roundedRect(innerRight - 90, sy - 8, 90, 22, 10).fill("#fecaca");

      this.doc
        .fillColor("#dc2626")
        .fontSize(10)
        .text(promotion.code || promotion.name, innerRight - 90, sy - 6, {
          width: 90,
          align: "center",
        });

      this.doc
        .fillColor("#dc2626")
        .fontSize(12)
        .text(
          `-${currencySymbol}${formatCurrencyWithCommas(convertedDiscount)}`,
          innerLeft,
          sy,
          { width: innerWidth, align: "left" }
        );

      sy += 25;
    }

    // Calculate net amount (excluding VAT) by dividing total by (1 + vatRate/100)
    const subtotalWithTax = convertedItems.reduce((s, i) => s + i.total, 0);
    const netBeforeTax = subtotalWithTax / (1 + vatRate / 100);
    const netAfterDiscount = netBeforeTax - convertedDiscount;
    const vatAmount = netAfterDiscount * (vatRate / 100);
    const finalTotal = netAfterDiscount + vatAmount;

    this.doc
      .fillColor("#475569")
      .fontSize(11)
      .text("Net (excl. VAT)", innerLeft, sy, {
        width: innerWidth,
        align: "left",
      });

    this.doc
      .fillColor("#1e293b")
      .text(
        `${currencySymbol}${formatCurrencyWithCommas(netAfterDiscount)}`,
        innerLeft,
        sy,
        {
          width: innerWidth,
          align: "right",
        }
      );

    sy += 22;

    this.doc.fillColor("#475569").text(`VAT ${vatRate}%`, innerLeft, sy, {
      width: innerWidth,
      align: "left",
    });

    this.doc
      .fillColor("#1e293b")
      .text(
        `${currencySymbol}${formatCurrencyWithCommas(vatAmount)}`,
        innerLeft,
        sy,
        {
          width: innerWidth,
          align: "right",
        }
      );

    sy += 22;

    this.doc
      .strokeColor("#e2e8f0")
      .lineWidth(1)
      .moveTo(innerLeft, sy)
      .lineTo(innerRight, sy)
      .stroke();

    sy += 10;

    this.doc.fontSize(15).fillColor("#334155").text("Total", innerLeft, sy, {
      width: innerWidth,
      align: "left",
    });

    this.doc
      .fontSize(17)
      .fillColor("#059669")
      .text(
        `${currencySymbol}${formatCurrencyWithCommas(finalTotal)}`,
        innerLeft,
        sy,
        {
          width: innerWidth,
          align: "right",
        }
      );

    /* -----------------------------------------------------
     FOOTER (centered, right after calculation box)
  ------------------------------------------------------*/
    const footerY = summaryTop + summaryBoxHeight + 70;

    this.doc
      .fontSize(12)
      .fillColor("#2563eb")
      .text("Thank you for your purchase!", 0, footerY, { align: "center" });

    this.doc
      .fontSize(10)
      .fillColor("#64748b")
      .text("Questions? Contact us at techstock2025@gmail.com", {
        align: "center",
      })
      .text("TechStock • Your Trusted Tech Partner", { align: "center" });

    this.doc.end();

    return new Promise((resolve, reject) => {
      stream.on("finish", () => resolve(filePath));
      stream.on("error", reject);
    });
  }
}

module.exports = InvoiceGenerator;
