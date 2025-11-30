import React, { useEffect, useState, useCallback } from "react";
import { useSettings } from "../../../context/SettingsContext";
import { useNavigate } from "react-router-dom";
import { Line, Bar, Pie } from "react-chartjs-2";
import { formatDate, formatDateShort } from "../../../utils/dateFormat";
import "./Dashboard.css";
import { MdSpaceDashboard } from "react-icons/md";
import axios from "axios";

import {
  Chart as ChartJS,
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  BarElement,
  ArcElement,
  Tooltip,
  Legend,
  Title,
} from "chart.js";

import {
  formatPrice,
  formatPriceConverted,
  formatPriceWithTax,
} from "../../../utils/currency";
import { convertFromILSSync, convertToILS } from "../../../utils/exchangeRate";

ChartJS.register(
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  BarElement,
  ArcElement,
  Tooltip,
  Legend,
  Title
);

export default function Dashboard() {
  // Dashboard component for admin users.
  // Responsibilities:
  // - Fetch aggregated statistics (revenue, orders, products, customers, suppliers, categories)
  // - Prepare chart data for sales, orders status and top products
  // - Render metric cards, low-stock alerts and visualizations
  const { isUserAdmin, loadingSettings, currency, vat_rate } = useSettings();
  const navigate = useNavigate();
  const [stats, setStats] = useState({
    total_revenue: 0,
    total_orders: 0,
    total_products: 0,
  });
  // Entity-level summary stats used for the cards below
  const [customerStats, setCustomerStats] = useState({
    totalCustomers: 0,
    activeCustomers: 0,
    inactiveCustomers: 0,
  });
  const [supplierStats, setSupplierStats] = useState({
    totalSuppliers: 0,
    activeSuppliers: 0,
    inactiveSuppliers: 0,
  });
  const [categoryStats, setCategoryStats] = useState({
    totalCategories: 0,
    activeCategories: 0,
    inactiveCategories: 0,
  });
  const [productStats, setProductStats] = useState({
    totalProducts: 0,
    activeProducts: 0,
    inactiveProducts: 0,
  });
  const [salesData, setSalesData] = useState([]);
  const [topProducts, setTopProducts] = useState([]);
  const [orderStatus, setOrderStatus] = useState([]);
  const [lowStockProducts, setLowStockProducts] = useState([]);
  const [lowStockDisplayCount, setLowStockDisplayCount] = useState(4);
  const [editingStock, setEditingStock] = useState(null);
  const [newStockValue, setNewStockValue] = useState("");
  const [stockUpdateMessage, setStockUpdateMessage] = useState("");

  // Helper function to get last 30 days date range
  const getLast30DaysRange = () => {
    const today = new Date();
    const thirtyDaysAgo = new Date(today.getTime() - 30 * 24 * 60 * 60 * 1000);
    return {
      startDate: thirtyDaysAgo.toISOString().split("T")[0],
      endDate: today.toISOString().split("T")[0],
    };
  };

  // Date range state - start with last 30 days by default
  const [dateRange, setDateRange] = useState(getLast30DaysRange());

  // Function to fetch dashboard data with date range
  const fetchDashboardData = useCallback(async () => {
    // Fetch many endpoints in parallel to minimize wait time.
    // The backend returns aggregated values suitable for dashboard display.
    try {
      const token = localStorage.getItem("token");
      const headers = { Authorization: `Bearer ${token}` };

      const params = {
        startDate: dateRange.startDate,
        endDate: dateRange.endDate,
      };

      const [
        statsRes,
        salesRes,
        topProductsRes,
        orderStatusRes,
        lowStockRes,
        settingsRes,
        currenciesRes,
        customerStatsRes,
        supplierStatsRes,
        categoryStatsRes,
        productStatsRes,
      ] = await Promise.all([
        axios.get("/api/admin/dashboard-stats", { headers, params }),
        axios.get("/api/admin/sales-over-time", { headers, params }),
        axios.get("/api/admin/top-products", { headers, params }),
        axios.get("/api/admin/order-status-distribution", { headers, params }),
        axios.get("/api/admin/low-stock-products", { headers }),
        axios.get("/api/settings"),
        axios.get("/api/settings/currencies"),
        axios.get("/api/admin/customer-stats", { headers }),
        axios.get("/api/suppliers/stats", { headers }),
        axios.get("/api/categories/stats", { headers }),
        axios.get("/api/products/admin/stats", { headers }),
      ]);

      // Log the high-level response for debugging during development
      console.log("Dashboard Data:", {
        stats: statsRes.data,
        sales: salesRes.data,
        topProducts: topProductsRes.data,
        orderStatus: orderStatusRes.data,
        lowStock: lowStockRes.data,
        settings: settingsRes.data,
        currencies: currenciesRes.data,
      });

      // Store API results into local state for rendering
      setStats(statsRes.data);
      setSalesData(salesRes.data);
      setTopProducts(topProductsRes.data);
      setOrderStatus(orderStatusRes.data);
      setLowStockProducts(lowStockRes.data);
      setCustomerStats(
        customerStatsRes.data || {
          totalCustomers: 0,
          activeCustomers: 0,
          inactiveCustomers: 0,
        }
      );
      setSupplierStats(
        supplierStatsRes.data || {
          totalSuppliers: 0,
          activeSuppliers: 0,
          inactiveSuppliers: 0,
        }
      );
      setCategoryStats(
        categoryStatsRes.data || {
          totalCategories: 0,
          activeCategories: 0,
          inactiveCategories: 0,
        }
      );
      setProductStats(
        productStatsRes.data || {
          totalProducts: 0,
          activeProducts: 0,
          inactiveProducts: 0,
        }
      );
    } catch (err) {
      console.error("Error fetching dashboard data:", err);
    }
  }, [dateRange]);

  useEffect(() => {
    if (!loadingSettings) {
      if (!isUserAdmin) {
        navigate("/");
      } else {
        fetchDashboardData();
      }
    }
  }, [isUserAdmin, loadingSettings, navigate, fetchDashboardData]);

  // Effect to refresh data when date range changes
  useEffect(() => {
    if (!loadingSettings && isUserAdmin) {
      fetchDashboardData();
    }
  }, [dateRange, isUserAdmin, loadingSettings, fetchDashboardData]);

  // Function to handle stock update
  const handleUpdateStock = async (productId) => {
    if (!newStockValue || isNaN(newStockValue) || parseInt(newStockValue) < 0) {
      setStockUpdateMessage("Please enter a valid non-negative number");
      return;
    }

    try {
      const token = localStorage.getItem("token");
      const headers = { Authorization: `Bearer ${token}` };

      // Convert productId to number for consistent comparison
      const productIdNum = parseInt(productId);

      // Get the product from lowStockProducts first (we already have this data)
      const productFromList = lowStockProducts.find(
        (p) => parseInt(p.product_id || p.id) === productIdNum
      );

      if (!productFromList) {
        throw new Error("Product not found in current list");
      }

      // Try to get full product details by searching admin endpoint with product name
      let product = null;

      // If we couldn't find it in admin endpoint, try regular endpoint (for active products)
      if (!product) {
        try {
          const productRes = await axios.get(`/api/products/${productIdNum}`, {
            headers,
          });
          product = productRes.data;
          console.log("Found product via regular endpoint");
        } catch (regularErr) {
          console.log(
            "Regular endpoint failed (product may be inactive):",
            regularErr.response?.data
          );
        }
      }

      // If still no product, we need to fetch it differently
      // Try fetching all pages from admin endpoint if search didn't work
      if (!product) {
        try {
          let page = 1;
          const limit = 100;
          let found = false;

          while (page <= 20 && !found) {
            // Limit to 20 pages
            const adminRes = await axios.get(
              `/api/products/admin/all?page=${page}&limit=${limit}`,
              { headers }
            );

            const products = adminRes.data.products || [];
            product = products.find((p) => {
              const pId = parseInt(p.product_id || p.id);
              return pId === productIdNum;
            });

            if (product) {
              found = true;
              console.log(`Found product on page ${page}`);
              break;
            }

            if (
              !adminRes.data.pagination ||
              !adminRes.data.pagination.hasNextPage
            ) {
              break;
            }

            page++;
          }
        } catch (paginationErr) {
          console.error("Error paginating through products:", paginationErr);
        }
      }

      // If we still don't have the product, we can't proceed
      if (!product) {
        throw new Error(
          `Product with ID ${productIdNum} not found. Please refresh the page and try again.`
        );
      }

      // Ensure we have all required fields for the update
      const updateData = {
        name: product.name,
        description: product.description || "",
        price: product.price,
        stock: parseInt(newStockValue),
        image: product.image || "",
        supplier_id: product.supplier_id || null,
        category_id: product.category_id || null,
      };

  
      await axios.put(`/api/products/${productIdNum}`, updateData, { headers });

      setStockUpdateMessage("Stock updated successfully!");
      setEditingStock(null);
      setNewStockValue("");

      // Refresh the dashboard data
      fetchDashboardData();

      // Clear success message after 2 seconds
      setTimeout(() => setStockUpdateMessage(""), 2000);
    } catch (err) {
      console.error("Error updating stock:", err);
      setStockUpdateMessage(
        err.response?.data?.message || err.message || "Error updating stock"
      );
    }
  };

  if (loadingSettings) {
    return (
      <div className="dashboard-container">
        <p>Loading Admin Panel...</p>
      </div>
    );
  }

  if (!isUserAdmin) {
    return null;
  }

  // Prepare chart data
  // Sales Over Time Line Chart
  const salesLineData = {
    labels:
      salesData.length > 0
        ? salesData.map((d) => formatDateShort(d.period))
        : ["No Data"],
    datasets: [
      {
        label: "Total Sales",
        data:
          salesData.length > 0
            ? salesData.map((d) =>
                convertFromILSSync(d.total_revenue, currency)
              )
            : [0],
        borderColor: "#007bff",
        backgroundColor: "rgba(0,123,255,0.1)",
        tension: 0.3,
        fill: true,
      },
      {
        label: "Order Count",
        data: salesData.length > 0 ? salesData.map((d) => d.orders_count) : [0],
        borderColor: "#28a745",
        backgroundColor: "rgba(40,167,69,0.1)",
        tension: 0.3,
        fill: false,
        yAxisID: "y1",
      },
    ],
  };
  // Options for sales line chart
  const salesLineOptions = {
    responsive: true,
    plugins: { legend: { position: "top" } },
    scales: {
      y: {
        beginAtZero: true,
        ticks: {
          callback: function (value) {
            // Data is already converted, just format it
            return formatPrice(value, currency);
          },
        },
      },
      y1: {
        beginAtZero: true,
        position: "right",
        grid: { drawOnChartArea: false },
        title: { display: true, text: "Orders" },
        ticks: { callback: (v) => v },
      },
    },
    plugins: {
      tooltip: {
        callbacks: {
          label: function (context) {
            let label = context.dataset.label || "";
            if (label) {
              label += ": ";
            }
            if (context.parsed.y !== null) {
              if (context.dataset.label === "Order Count") {
                label += context.parsed.y;
              } else {
                // Data is already converted, just format it
                label += formatPrice(context.parsed.y, currency);
              }
            }
            return label;
          },
        },
      },
    },
  };

  // Top Products Bar Chart
  const sortedTopProducts =
    topProducts && topProducts.length > 0
      ? [...topProducts].sort(
          (a, b) => (b.total_sold || 0) - (a.total_sold || 0)
        )
      : [];
  // Data and options for top products bar chart
  const topProductsBarData = {
    labels:
      sortedTopProducts.length > 0
        ? sortedTopProducts.map((p) => p.name)
        : ["No Products"],
    datasets: [
      {
        label: "Units Sold",
        data:
          sortedTopProducts.length > 0
            ? sortedTopProducts.map((p) => p.total_sold)
            : [0],
        backgroundColor: "#ffc107",
      },
      {
        label: "Total Sales",
        data:
          sortedTopProducts.length > 0
            ? sortedTopProducts.map((p) =>
                convertFromILSSync(p.total_revenue, currency)
              )
            : [0],
        backgroundColor: "#007bff",
      },
    ],
  };
  // Options for top products bar chart
  const topProductsBarOptions = {
    responsive: true,
    plugins: {
      legend: { position: "top" },
      tooltip: {
        callbacks: {
          label: function (context) {
            let label = context.dataset.label || "";
            if (label) {
              label += ": ";
            }
            if (context.parsed.y !== null) {
              if (context.dataset.label === "Total Sales") {
                // Convert back to ILS, then format with tax
                const priceInILS = convertToILS(context.parsed.y, currency);
                label += formatPriceWithTax(priceInILS, currency, vat_rate);
              } else {
                label += context.parsed.y;
              }
            }
            return label;
          },
        },
      },
    },
    scales: {
      y: {
        beginAtZero: true,
        ticks: {
          callback: function (value, index, ticks) {
            return value;
          },
        },
      },
    },
  };

  // Order Status Distribution Pie Chart
  const orderStatusPieData = {
    labels:
      orderStatus && orderStatus.length > 0
        ? orderStatus.map((s) => s.status)
        : ["No Orders"],
    datasets: [
      {
        label: "Orders",
        data:
          orderStatus && orderStatus.length > 0
            ? orderStatus.map((s) => s.count)
            : [0],
        backgroundColor: [
          "#007bff",
          "#28a745",
          "#ffc107",
          "#dc3545",
          "#6c757d",
        ],
      },
    ],
  };

  return (
    <div className="dashboard-container">
      <h2>
        <MdSpaceDashboard color="#363636b7" /> Dashboard
      </h2>
      <p className="subtitle">Overview of your store's performance</p>

      {/* Low-stock alert section: shows products with low inventory and highlights them visually */}
      <div className="chart-container low-stock-section">
        <h3
          className={
            lowStockProducts && lowStockProducts.length > 0
              ? "low-stock-header low-stock-glow"
              : "low-stock-header"
          }
        >
          Low Stock Products (≤10 units)
        </h3>
        {lowStockProducts.length > 0 ? (
          <>
            {/* Grid of low-stock product cards (image, name, category, stock, price) */}
            <div className="low-stock-grid">
              {lowStockProducts
                .slice(0, lowStockDisplayCount)
                .map((product) => (
                  <div
                    key={product.product_id || product.id}
                    className="low-stock-product-card"
                  >
                    <div className="low-stock-product-info">
                      <h4 className="low-stock-product-name">{product.name}</h4>
                      <p className="low-stock-product-category">
                        {product.category}
                      </p>
                    </div>
                    <div className="low-stock-product-image">
                      {product.image ? (
                        <img
                          src={
                            product.image &&
                            product.image.startsWith("/uploads")
                              ? `http://localhost:3001${product.image}`
                              : product.image ||
                                "https://via.placeholder.com/50"
                          }
                          alt={product.name}
                          onError={(e) => {
                            e.target.style.display = "none";
                            e.target.nextSibling.style.display = "block";
                          }}
                        />
                      ) : null}
                      <div
                        className={`low-stock-product-placeholder ${
                          product.image ? "hidden" : ""
                        }`}
                      >
                        📦
                      </div>
                    </div>
                    <div className="low-stock-product-info">
                      <div className="low-stock-product-details">
                        <span className={"stock-badge low"}>
                          {product.stock} left
                        </span>
                        {!product.is_active && (
                          <span className="inactive-badge">INACTIVE</span>
                        )}
                        <span className="product-price">
                          {formatPriceWithTax(
                            product.price,
                            currency,
                            vat_rate
                          )}
                        </span>
                      </div>
                      <button
                        onClick={() => {
                          setEditingStock(product.product_id || product.id);
                          setNewStockValue(product.stock.toString());
                          setStockUpdateMessage("");
                        }}
                        className="update-stock-button"
                      >
                        Update Stock
                      </button>
                    </div>
                  </div>
                ))}
            </div>
            {lowStockProducts.length > lowStockDisplayCount && (
              <div className="load-more-container">
                <button
                  onClick={() => setLowStockDisplayCount((prev) => prev + 4)}
                  className="load-more-button"
                >
                  Load More ({lowStockProducts.length - lowStockDisplayCount}{" "}
                  remaining)
                </button>
              </div>
            )}
          </>
        ) : (
          <div className="no-low-stock-message">
            <div className="no-low-stock-icon">✅</div>
            <h4 className="no-low-stock-title">
              All products are well stocked!
            </h4>
            <p className="no-low-stock-text">
              No products have stock levels ≤ 10 units.
            </p>
          </div>
        )}
      </div>

      {/* Stock Update Modal */}
      {editingStock && (
        <div
          className="stock-update-modal-overlay"
          onClick={() => {
            setEditingStock(null);
            setNewStockValue("");
            setStockUpdateMessage("");
          }}
        >
          <div
            className="stock-update-modal"
            onClick={(e) => e.stopPropagation()}
          >
            <h3>Update Stock</h3>
            <p className="stock-update-product-name">
              {
                lowStockProducts.find(
                  (p) => (p.product_id || p.id) === editingStock
                )?.name
              }
            </p>
            <div className="stock-update-form">
              <label>
                New Stock Quantity:
                <input
                  type="number"
                  min="0"
                  value={newStockValue}
                  onChange={(e) => setNewStockValue(e.target.value)}
                  className="stock-update-input"
                  autoFocus
                />
              </label>
              {stockUpdateMessage && (
                <p
                  className={`stock-update-message ${
                    stockUpdateMessage.includes("successfully")
                      ? "success"
                      : "error"
                  }`}
                >
                  {stockUpdateMessage}
                </p>
              )}
              <div className="stock-update-buttons">
                <button
                  onClick={() => handleUpdateStock(editingStock)}
                  className="stock-update-save-button"
                >
                  Save
                </button>
                <button
                  onClick={() => {
                    setEditingStock(null);
                    setNewStockValue("");
                    setStockUpdateMessage("");
                  }}
                  className="stock-update-cancel-button"
                >
                  Cancel
                </button>
              </div>
            </div>
          </div>
        </div>
      )}

      {/* Four metric cards in a single row: Customers, Suppliers, Categories, Products */}
      <div className="entity-stats-container">
        <div className="stat-card">
          <h3>Total Customers</h3>
          <p className="stat-number">{customerStats.totalCustomers}</p>
          <div className="stat-subline">
            <span className="stat-badge active">
              {customerStats.activeCustomers} Active
            </span>
            <span className="stat-badge inactive">
              {customerStats.inactiveCustomers} Inactive
            </span>
          </div>
        </div>

        <div className="stat-card">
          <h3>Total Suppliers</h3>
          <p className="stat-number">{supplierStats.totalSuppliers}</p>
          <div className="stat-subline">
            <span className="stat-badge active">
              {supplierStats.activeSuppliers} Active
            </span>
            <span className="stat-badge inactive">
              {supplierStats.inactiveSuppliers} Inactive
            </span>
          </div>
        </div>

        <div className="stat-card">
          <h3>Total Categories</h3>
          <p className="stat-number">{categoryStats.totalCategories}</p>
          <div className="stat-subline">
            <span className="stat-badge active">
              {categoryStats.activeCategories} Active
            </span>
            <span className="stat-badge inactive">
              {categoryStats.inactiveCategories} Inactive
            </span>
          </div>
        </div>

        <div className="stat-card">
          <h3>Products</h3>
          <p className="stat-number">{productStats.totalProducts}</p>
          <div className="stat-subline">
            <span className="stat-badge active">
              {productStats.activeProducts} Active
            </span>
            <span className="stat-badge inactive">
              {productStats.inactiveProducts} Inactive
            </span>
          </div>
        </div>
      </div>

      {/* Date Range Picker */}
      <div className="date-range-picker">
        <div className="date-range-controls">
          <label className="date-range-label">Date Range:</label>
          <input
            type="date"
            value={dateRange.startDate}
            onChange={(e) =>
              setDateRange((prev) => ({ ...prev, startDate: e.target.value }))
            }
            className="date-input"
          />
          <span className="date-separator">to</span>
          <input
            type="date"
            value={dateRange.endDate}
            min={dateRange.startDate || undefined}
            onChange={(e) =>
              setDateRange((prev) => ({ ...prev, endDate: e.target.value }))
            }
            className="date-input"
          />
        </div>

        <button
          onClick={() => setDateRange(getLast30DaysRange())}
          className="date-range-button secondary"
        >
          Last 30 Days
        </button>

        <button
          onClick={() => {
            const today = new Date();
            const sevenDaysAgo = new Date(
              today.getTime() - 7 * 24 * 60 * 60 * 1000
            );
            setDateRange({
              startDate: sevenDaysAgo.toISOString().split("T")[0],
              endDate: today.toISOString().split("T")[0],
            });
          }}
          className="date-range-button primary"
        >
          Last 7 Days
        </button>

        <button
          onClick={() => setDateRange({ startDate: "", endDate: "" })}
          className="date-range-button secondary"
        >
          All Time
        </button>
      </div>

      {/* Date Range Summary */}
      <div className="date-range-summary">
        <p className="date-range-summary-text">
          {!dateRange.startDate && !dateRange.endDate ? (
            <>
              <strong>Statistics for:</strong> All Time
            </>
          ) : (
            <>
              <strong>Statistics for:</strong> {formatDate(dateRange.startDate)}{" "}
              to {formatDate(dateRange.endDate)}
            </>
          )}
        </p>
      </div>

      <div className="stats-row">
        <div className="stat-card">
          <h3>Total Revenue</h3>
          <p className="stat-number">
            {formatPriceConverted(stats.total_revenue, currency)}
          </p>
        </div>
        <div className="stat-card">
          <h3>Total Orders</h3>
          <p className="stat-number">{stats.total_orders}</p>
        </div>
      </div>

      {/* Charts Section */}
      <div className="charts-grid">
        <div className="chart-container">
          <h3>Sales Over Time</h3>
          <Line data={salesLineData} options={salesLineOptions} />
        </div>
        <div className="chart-container">
          <h3>Order Status</h3>
          <Pie data={orderStatusPieData} />
        </div>
      </div>

      <div className="chart-container">
        <h3>Top Selling Products</h3>
        <Bar data={topProductsBarData} options={topProductsBarOptions} />
      </div>
    </div>
  );
}
