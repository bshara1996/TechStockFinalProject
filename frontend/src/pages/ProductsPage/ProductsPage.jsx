import { useState, useEffect, useRef, useCallback } from "react";
import axios from "axios";
import { useLocation, useNavigate, useSearchParams } from "react-router-dom";
import { useCart } from "../../context/CartContext";
import { useSettings } from "../../context/SettingsContext";
import { BsCart } from "react-icons/bs";
import { formatPriceWithTax } from "../../utils/currency";
import { convertFromILSSync } from "../../utils/exchangeRate";
import Pagination from "../../components/Pagination/Pagination";
import "./ProductsPage.css";

// Helper: format price with tax and commas
const formatPriceWithCommas = (price, currency, taxRate = 18) => {
  // Delegate to shared price formatter
  return formatPriceWithTax(price, currency, taxRate);
};

const ProductsPage = () => {
  // Global settings and routing hooks
  const { currency, username, user_id, vat_rate } = useSettings();
  const location = useLocation();
  const { addToCart, validateCart } = useCart();
  const navigate = useNavigate();
  const [searchParams, setSearchParams] = useSearchParams();

  // Data state
  const [products, setProducts] = useState([]); // product list
  const [loading, setLoading] = useState(true); // loading flag
  const [categories, setCategories] = useState([
    { category_id: "All Products", name: "All Products" },
  ]); // categories for filter
  const [pagination, setPagination] = useState({
    currentPage: 1,
    totalPages: 1,
    totalItems: 0,
    itemsPerPage: 10,
  }); // pagination meta

  // Filter state
  const [selectedCategory, setSelectedCategory] = useState("All Products"); // current category
  const [priceRange, setPriceRange] = useState({ min: 0, max: 1000 }); // slider bounds
  const [maxPrice, setMaxPrice] = useState(1000); // selected max price (ILS)
  const [priceStats, setPriceStats] = useState({ minPrice: 0, maxPrice: 1000 }); // fetched stats
  const [manufacturers, setManufacturers] = useState([]); // supplier list
  const [selectedManufacturers, setSelectedManufacturers] = useState([]); // selected suppliers

  // Refs
  const sliderRef = useRef(null); // slider DOM ref
  // Cancel old fetches for fast showing filters
  const abortControllerRef = useRef(null);

  // Fetch products with current filters
  const fetchProducts = useCallback(
    async (pageOverride = null) => {
      if (abortControllerRef.current) {
        abortControllerRef.current.abort();
      }

      // Create new AbortController for this request
      const abortController = new AbortController();
      abortControllerRef.current = abortController;

      try {
        const pageToUse =
          pageOverride !== null ? pageOverride : pagination.currentPage;
        const params = new URLSearchParams();

        if (selectedCategory && selectedCategory !== "All Products") {
          params.append("category", selectedCategory);
          console.log("Adding category filter:", selectedCategory);
        }

        if (selectedManufacturers.length > 0) {
          selectedManufacturers.forEach((id) =>
            params.append("manufacturer", id)
          );
          console.log("Adding manufacturer filters:", selectedManufacturers);
        }

        // Append price filters (values are stored in ILS in state)
        if (priceRange && priceRange.min !== undefined) {
          params.append("minPrice", String(priceRange.min));
          console.log("Adding minPrice filter:", priceRange.min);
        }
        if (maxPrice !== undefined && maxPrice !== null) {
          // allow maxPrice = 0 as a valid filter value
          params.append("maxPrice", String(maxPrice));
          console.log("Adding maxPrice filter:", maxPrice);
        }

        params.append("page", pageToUse.toString());
        params.append("limit", "10");
        console.log("Fetching products with params:", params.toString());

        const response = await axios.get(`/api/products?${params}`, {
          signal: abortController.signal,
        });

        // Check if request was aborted
        if (abortController.signal.aborted) {
          return;
        }

        console.log(
          "ProductsPage: Products fetched with filters:",
          response.data
        );

        if (response.data && response.data.products) {
          setProducts(response.data.products);
          if (response.data.pagination) {
            setPagination(response.data.pagination);
          }
        } else if (Array.isArray(response.data)) {
          // Fallback for old API format
          setProducts(response.data);
        } else {
          console.warn("Unexpected response format:", response.data);
          setProducts([]);
        }
      } catch (error) {
        // Don't log error if request was aborted
        if (error.name === "AbortError" || error.name === "CanceledError") {
          console.log("ProductsPage: Request aborted");
          return;
        }
        console.error("ProductsPage: Error fetching products:", error);
        setProducts([]);
      } finally {
        // Only update loading state if this request wasn't aborted
        if (!abortController.signal.aborted) {
          setLoading(false);
        }
      }
    },
    [selectedCategory, maxPrice, selectedManufacturers, priceStats.maxPrice]
  );

  // Cleanup on unmount
  useEffect(() => {
    return () => {
      if (abortControllerRef.current) {
        abortControllerRef.current.abort();
      }
    };
  }, []);

  // Handle URL parameter changes for category
  useEffect(() => {
    const params = new URLSearchParams(location.search);
    const categoryParam = params.get("category");

    // Only sync category from URL if it's different from current state (avoid loops)
    if (categoryParam !== null && categoryParam !== selectedCategory) {
      setSelectedCategory(categoryParam);
    } else if (categoryParam === null && selectedCategory !== "All Products") {
      setSelectedCategory("All Products");
    }
  }, [location.search]);

  // Clean up duplicates on component mount
  useEffect(() => {
    setSelectedManufacturers((prev) => {
      const unique = [...new Set(prev)];
      if (unique.length !== prev.length) {
        return unique;
      }
      return prev;
    });
  }, []);

  // Fetch price statistics based on current filters
  const fetchPriceStats = useCallback(async () => {
    const params = new URLSearchParams();

    if (selectedCategory && selectedCategory !== "All Products") {
      params.append("category", selectedCategory);
    }

    if (selectedManufacturers.length > 0) {
      selectedManufacturers.forEach((id) => params.append("manufacturer", id));
    }

    try {
      const response = await axios.get(
        `/api/products/price-stats?${params.toString()}`
      );
      console.log(
        "ProductsPage: Price stats fetched with filters:",
        response.data
      );
      const newPriceRange = {
        min: response.data.minPrice,
        max: response.data.maxPrice,
      };
      console.log("ProductsPage: Updating priceRange to:", newPriceRange);
      setPriceStats(response.data);
      setPriceRange(newPriceRange);

      // Reset selected maxPrice to new max (ensure slider range)
      const newMaxPrice = response.data.maxPrice;
      console.log("ProductsPage: Updating maxPrice to:", newMaxPrice);
      setMaxPrice(newMaxPrice);
    } catch (err) {
      console.error("ProductsPage: Error fetching price stats:", err);
    }
  }, [selectedCategory, selectedManufacturers]);

  useEffect(() => {
    // Fetch initial price statistics (no filters)
    fetchPriceStats();

    // Fetch categories (only active for filters)
    axios
      .get("/api/categories/public")
      .then((res) => {
        console.log("ProductsPage: Categories fetched from backend:", res.data);
        const categoriesData = Array.isArray(res.data) ? res.data : [];
        // Filter to only show active categories (backend should already filter, but double-check)
        const activeCategories = categoriesData.filter((cat) => {
          const isActive =
            cat.isActive !== undefined
              ? cat.isActive
              : cat.isActive === undefined
              ? true
              : false;
          return isActive === 1 || isActive === true;
        });
        setCategories([
          { category_id: "All Products", name: "All Products", isActive: true },
          ...activeCategories,
        ]);
      })
      .catch((err) =>
        console.error("ProductsPage: Error fetching categories:", err)
      );

    // Fetch suppliers (manufacturers) - only active
    axios
      .get("/api/suppliers/public")
      .then((res) => {
        // Filter to only show active suppliers
        const manufacturerList = res.data
          .filter((supplier) => {
            const isActive =
              supplier.isActive !== undefined ? supplier.isActive : true;
            return isActive === 1 || isActive === true;
          })
          .map((supplier) => ({
            // Use the numeric supplier_id for filtering and the name for display
            id: String(
              supplier.supplier_id ??
                supplier.id ??
                supplier.ID ??
                supplier.SupplierID
            ),
            name: supplier.name || supplier.supplier_name || supplier.Name,
            isActive:
              supplier.isActive !== undefined ? supplier.isActive : true,
          }));
        setManufacturers(manufacturerList);
      })
      .catch((err) =>
        console.error("ProductsPage: Error fetching suppliers:", err)
      );
  }, []);

  // Update price stats when category or manufacturer filters change
  useEffect(() => {
    fetchPriceStats();
  }, [selectedCategory, selectedManufacturers, fetchPriceStats]);

  // Fetch products when filters change (page handled separately)
  useEffect(() => {
    console.log("fetchProducts useEffect triggered");
    // Reset to page 1 when filters change
    setPagination((prev) => ({ ...prev, currentPage: 1 }));
    fetchProducts(1);
  }, [selectedCategory, maxPrice, selectedManufacturers, fetchProducts]);

  // Initial fetch after price stats are loaded
  useEffect(() => {
    if (priceStats.maxPrice > 0) {
      console.log("Initial fetch triggered after price stats loaded");
      fetchProducts(1);
    }
  }, [priceStats.maxPrice, fetchProducts]);

  const handleCategoryChange = (category) => {
    setSelectedCategory(category);
    setPagination((prev) => ({ ...prev, currentPage: 1 })); // Reset to first page

    // Update URL to reflect category change
    const params = new URLSearchParams(searchParams);
    if (category === "All Products") {
      params.delete("category");
    } else {
      params.set("category", category);
    }
    setSearchParams(params);

    // Price stats will be updated via useEffect
  };

  const handleManufacturerChange = (e) => {
    const { value, checked } = e.target;

    // Prevent selecting inactive manufacturers
    const manufacturer = manufacturers.find((m) => String(m.id) === value);
    if (
      manufacturer &&
      (manufacturer.isActive === false || manufacturer.isActive === 0)
    ) {
      return; // Don't allow selection of inactive manufacturers
    }

    // value holds the supplier_id (string)
    setSelectedManufacturers((prev) => {
      if (checked) {
        if (prev.includes(value)) return prev;
        return [...prev, value];
      }
      return prev.filter((id) => id !== value);
    });
    setPagination((prev) => ({ ...prev, currentPage: 1 })); // Reset to first page
  };

  const handlePageChange = async (newPage) => {
    // Scroll to top of product grid when page changes
    window.scrollTo({ top: 0, behavior: "smooth" });

    // Update pagination state first
    setPagination((prev) => ({ ...prev, currentPage: newPage }));

    // Fetch products for the new page using fetchProducts with page override
    await fetchProducts(newPage);
  };

  const handleAddToCart = (product) => {
    if (!username || !user_id) {
      // User is not logged in, redirect to login page
      navigate("/login");
      return;
    }

    // User is logged in, proceed with adding to cart
    addToCart(product);

    // Validate cart after adding item (with a small delay)
    setTimeout(() => {
      validateCart(false); // Don't show notifications for this validation
    }, 500);
  };

  // Products are now filtered on the backend, so we use products directly

  return (
    <div className="products-page-container">
      {/* Hero Section */}
      <div className="products-hero-section">
        <h1>Our Products</h1>
        <p>Discover our wide range of high-quality products</p>
      </div>

      {/* Categories Filter */}
      <div className="categories-filter">
        <div className="categories-filter-buttons">
          {categories.map((cat) => {
            const isInactive = cat.isActive === false || cat.isActive === 0;
            return (
              <button
                key={cat.category_id}
                onClick={() => !isInactive && handleCategoryChange(cat.name)}
                disabled={isInactive}
                className={`category-button ${
                  selectedCategory === cat.name ? "active" : ""
                } ${isInactive ? "inactive" : ""}`}
                title={isInactive ? "This category is inactive" : ""}
              >
                {cat.name}
                {isInactive ? " (Inactive)" : ""}
              </button>
            );
          })}
        </div>
      </div>

      {/* Main Content Layout */}
      <div className="products-page-layout">
        {/* Left Sidebar with Filters */}
        <div className="filters-sidebar">
          {/* Price Range Filter */}
          <div className="filter-section">
            <h3>Price Range</h3>
            <div className="price-range-container">
              {/* Show the current selected maximum price (after tax) in the active currency */}
              <div className="current-price-value">
                Up to: {formatPriceWithTax(maxPrice, currency, vat_rate)}
              </div>

              <input
                key={`price-slider-${currency}-${priceRange.min}-${priceRange.max}`}
                type="range"
                id="priceRange"
                min={convertFromILSSync(priceRange.min, currency)}
                max={convertFromILSSync(priceRange.max, currency)}
                step="0.01"
                value={convertFromILSSync(maxPrice, currency)}
                onChange={(e) => {
                  // Convert the slider value (in current currency) back to ILS for filtering
                  const valueInCurrentCurrency = parseFloat(e.target.value);
                  // Convert back to ILS: if currency is ILS, no conversion needed
                  // Otherwise, we need to reverse the conversion
                  let valueInILS;
                  if (currency === "ILS") {
                    valueInILS = valueInCurrentCurrency;
                  } else {
                    const rate = convertFromILSSync(1, currency);
                    valueInILS = valueInCurrentCurrency / rate;
                  }

                  setMaxPrice(valueInILS);
                  setPagination((prev) => ({ ...prev, currentPage: 1 })); // Reset to first page
                }}
                className="theme-range"
              />

              <div className="price-range-labels">
                <span>
                  {formatPriceWithTax(priceRange.min, currency, vat_rate)}{" "}
                </span>
                <span>
                  {formatPriceWithTax(priceRange.max, currency, vat_rate)}{" "}
                </span>
              </div>
            </div>
          </div>

          {/* Manufacturer Filter */}
          <div>
            <h3>Manufacturer</h3>
            <div className="manufacturer-list">
              {manufacturers.map((manufacturer) => {
                const isChecked = selectedManufacturers.includes(
                  String(manufacturer.id)
                );
                const isInactive =
                  manufacturer.isActive === false ||
                  manufacturer.isActive === 0;
                return (
                  <div key={manufacturer.id} className="manufacturer-item">
                    <label
                      className={`manufacturer-label ${
                        isInactive ? "inactive" : ""
                      }`}
                    >
                      <input
                        type="checkbox"
                        value={manufacturer.id}
                        checked={isChecked}
                        disabled={isInactive}
                        onChange={handleManufacturerChange}
                        className="manufacturer-checkbox-custom"
                      />
                      <span>
                        {manufacturer.name}
                        {isInactive ? " (Inactive)" : ""}
                      </span>
                    </label>
                  </div>
                );
              })}
            </div>
          </div>
        </div>

        <div className="product-grid-container">
          <div className="product-grid">
            {!loading && (
              <>
                {products.length === 0 ? (
                  <div className="no-products-message">
                    <div className="no-products-icon">🔍</div>
                    <h3>No Products Found</h3>
                    <p>
                      {selectedCategory !== "All Products"
                        ? `No products found in the "${selectedCategory}" category`
                        : `No products available`}
                    </p>
                    <div className="no-products-suggestions">
                      <p>Try:</p>
                      <ul>
                        <li>Clearing your search term</li>
                        <li>Selecting a different category</li>
                        <li>Browsing all products</li>
                      </ul>
                    </div>
                    <button
                      className="clear-filters-button"
                      onClick={() => {
                        setSelectedCategory("All Products");
                        setMaxPrice(priceStats.maxPrice);
                        setSelectedManufacturers([]);
                      }}
                    >
                      Clear All Filters
                    </button>
                  </div>
                ) : (
                  products.map((product) => {
                    // Enhanced inventory validation
                    const hasValidStock = product.stock && product.stock >= 0;
                    const isOutOfStock = !hasValidStock || product.stock === 0;
                    const stockStatus =
                      product.stock === 0 || !hasValidStock
                        ? "Out of Stock"
                        : `Stock: ${product.stock}`;

                    return (
                      <div
                        key={product.product_id}
                        className={`product-card ${
                          isOutOfStock ? "out-of-stock" : ""
                        }`}
                      >
                        <h4 className="product-name">{product.name}</h4>

                        <div className="product-image-container">
                          {product.image ? (
                            <img
                              src={
                                product.image &&
                                product.image.startsWith("/uploads")
                                  ? `http://localhost:3001${product.image}`
                                  : product.image ||
                                    "https://via.placeholder.com/150"
                              }
                              alt={product.name}
                              className="product-image"
                            />
                          ) : (
                            <div className="product-placeholder-image">
                              Product Image
                            </div>
                          )}
                          {isOutOfStock && (
                            <div className="out-of-stock-badge">
                              Out of Stock
                            </div>
                          )}
                        </div>
                        <div>
                          <div className="product-meta-row">
                            <p className="category-name">
                              {categories.find(
                                (c) => c.category_id === product.category_id
                              )?.name || "N/A"}
                            </p>
                            <p className="stock-info">{stockStatus}</p>
                          </div>
                          {product.short_description && (
                            <p className="product-info">
                              {product.short_description}
                            </p>
                          )}
                          <p className="product-price">
                            {formatPriceWithCommas(
                              product.price,
                              currency,
                              vat_rate
                            )}
                          </p>
                          <div className="product-card-actions">
                            <button
                              className="details-button"
                              onClick={() =>
                                navigate(`/products/${product.product_id}`)
                              }
                            >
                              For details
                            </button>
                            <button
                              className={`add-to-cart-button ${
                                isOutOfStock ? "disabled" : ""
                              }`}
                              onClick={() =>
                                !isOutOfStock && handleAddToCart(product)
                              }
                              disabled={isOutOfStock}
                              title={
                                product.stock === 0 || !hasValidStock
                                  ? "Out of stock"
                                  : username
                                  ? "Add to cart"
                                  : "Login to add to cart"
                              }
                            >
                              <BsCart />
                            </button>
                          </div>
                        </div>
                      </div>
                    );
                  })
                )}
              </>
            )}
          </div>

          {/* Pagination */}
          {!loading && products.length > 0 && pagination.totalPages > 1 && (
            <div className="pagination-container">
              <Pagination
                currentPage={pagination.currentPage}
                totalPages={pagination.totalPages}
                totalItems={pagination.totalItems}
                itemsPerPage={pagination.itemsPerPage}
                onPageChange={handlePageChange}
              />
            </div>
          )}
        </div>
      </div>
    </div>
  );
};

export default ProductsPage;
