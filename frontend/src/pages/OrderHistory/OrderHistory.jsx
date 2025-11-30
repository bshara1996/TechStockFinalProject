import React, { useState, useEffect } from "react";
import { useSettings } from "../../context/SettingsContext";
import { useNavigate, Link } from "react-router-dom";
import { formatPriceWithTax, formatPriceConverted } from "../../utils/currency";
import { formatDateTimeFull } from "../../utils/dateFormat";
import Pagination from "../../components/Pagination/Pagination";
import { FaChevronDown, FaChevronUp } from "react-icons/fa";
import "./OrderHistory.css";

// Helper function to calculate per-item discount
const calculateItemDiscount = (item, promotion) => {
  if (!promotion || !promotion.promotion_type || !promotion.promotion_value) {
    return {
      isApplicable: false,
      discount: 0,
      priceAfterDiscount: item.price * item.quantity,
    };
  }

  // Check if item is applicable to promotion
  let isApplicable = false;
  const applicableProducts = promotion.applicable_products
    ? JSON.parse(promotion.applicable_products)
    : [];
  const applicableCategories = promotion.applicable_categories
    ? JSON.parse(promotion.applicable_categories)
    : [];

  if (
    applicableProducts.length > 0 &&
    applicableProducts.includes(item.product_id)
  ) {
    isApplicable = true;
  } else if (
    applicableCategories.length > 0 &&
    applicableCategories.includes(item.category_id)
  ) {
    isApplicable = true;
  }

  if (!isApplicable) {
    return {
      isApplicable: false,
      discount: 0,
      priceAfterDiscount: item.price * item.quantity,
    };
  }

  // Calculate discount
  const itemSubtotal = item.price * item.quantity;
  let discount = 0;

  if (promotion.promotion_type === "percentage") {
    discount = itemSubtotal * (promotion.promotion_value / 100);
  } else if (promotion.promotion_type === "fixed") {
    // For fixed discount, we need to calculate proportionally
    discount = Math.min(promotion.promotion_value, itemSubtotal);
  }

  const priceAfterDiscount = itemSubtotal - discount;
  return { isApplicable: true, discount, priceAfterDiscount };
};

const OrderHistory = ({ userId }) => {
  const {
    user_id: contextUserId,
    loadingSettings,
    currency,
    vat_rate,
  } = useSettings();
  const navigate = useNavigate();
  const [orders, setOrders] = useState([]);
  const [loadingOrders, setLoadingOrders] = useState(true);
  const [error, setError] = useState(null);
  const [expandedOrders, setExpandedOrders] = useState(new Set());
  const [pagination, setPagination] = useState({
    currentPage: 1,
    totalPages: 1,
    totalItems: 0,
    itemsPerPage: 10,
  });

  // Use the userId prop if provided, otherwise fallback to contextUserId
  const currentUserId = userId || contextUserId;

  const fetchOrders = async (page = 1) => {
    if (loadingSettings) {
      // Still loading settings, wait for user_id to be available
      return;
    }
    if (!currentUserId) {
      // If not logged in, redirect to login page (only if not getting userId via prop)
      if (!userId) {
        // Only navigate if this is the top-level OrderHistory page
        alert("Please log in to view your order history.");
        navigate("/login");
      }
      return;
    }

    setLoadingOrders(true);
    setError(null);
    try {
      const token = localStorage.getItem("token");
      // API call with pagination
      const response = await fetch(
        `/api/orders/history/${currentUserId}?page=${page}&limit=10`,
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      );

      if (!response.ok) {
        const errorData = await response
          .json()
          .catch(() => ({ message: "Failed to parse error response." }));
        throw new Error(errorData.message || "Failed to fetch orders.");
      }
      const data = await response.json();

      // Handle both old format (array) and new format (object with orders and pagination)
      const ordersArray = Array.isArray(data) ? data : data.orders || [];
      const paginationData = data.pagination || {
        currentPage: 1,
        totalPages: 1,
        totalItems: ordersArray.length,
        itemsPerPage: 10,
      };

      // Sort orders by date (newest first)
      const sortedOrders = ordersArray.sort(
        (a, b) => new Date(b.order_date) - new Date(a.order_date)
      );

      setOrders(sortedOrders);
      setPagination(paginationData);
      console.log("Fetched orders:", sortedOrders);
    } catch (err) {
      console.error("Error fetching orders:", err);
      setError(`Failed to load orders: ${err.message}`);
      setOrders([]); // Defensive: always set to array
    } finally {
      setLoadingOrders(false);
    }
  };

  useEffect(() => {
    fetchOrders(1);
  }, [currentUserId, loadingSettings, navigate, userId]);

  const handlePageChange = (newPage) => {
    fetchOrders(newPage);
  };

  const toggleOrder = (orderId) => {
    setExpandedOrders((prev) => {
      const newSet = new Set(prev);
      if (newSet.has(orderId)) {
        newSet.delete(orderId);
      } else {
        newSet.add(orderId);
      }
      return newSet;
    });
  };

  if (loadingOrders) {
    return <div className="loading">Loading order history...</div>;
  }

  if (error) {
    return <div className="error">{error}</div>;
  }

  // Defensive: only map if orders is an array
  if (!Array.isArray(orders)) {
    return (
      <div className="error">
        Failed to load orders: Unexpected response format.
      </div>
    );
  }

  // Check if this is being used as a standalone page (no userId prop)
  const isStandalonePage = !userId;

  return (
    <div className={isStandalonePage ? "order-history-container" : ""}>
      {isStandalonePage ? (
        <>
          {/* Tab Navigation */}
          <div className="tab-navigation">
            <div className="tab-container">
              <button
                onClick={() => navigate("/profile")}
                className="tab-button inactive"
              >
                Profile
              </button>
              <button className="tab-button active">Order History</button>
            </div>
          </div>
          {/* Order History Content */}
          <div className="order-history-content">
            <div className="order-history-header">
              <h1 className="order-history-title">Your Order History</h1>
              <p className="order-history-subtitle">
                Track all your past orders and their status
              </p>
            </div>
          </div>
        </>
      ) : (
        <h2 className="order-history-embedded-title">Your Order History</h2>
      )}

      <div className={isStandalonePage ? "order-history-content" : ""}>
        {orders.length === 0 ? (
          <div className="no-orders">
            <div className="no-orders-icon">📦</div>
            <h2 className="no-orders-title">No Orders Yet</h2>
            <p className="no-orders-text">
              You haven't placed any orders yet. Start shopping to see your
              order history here!
            </p>
            <Link to="/products" className="shop-now-btn">
              Start Shopping
            </Link>
          </div>
        ) : (
          <div>
            {orders.map((order) => {
              const isExpanded = expandedOrders.has(order.order_id);
              return (
                <div key={order.order_id} className="order-card">
                  <div
                    className="order-header clickable"
                    onClick={() => toggleOrder(order.order_id)}
                  >
                    <div className="order-header-left">
                      <h2 className="order-number">Order #{order.order_id}</h2>
                      <span className="order-total">
                        Total:{" "}
                        {formatPriceConverted(order.total_amount, currency)}
                      </span>
                    </div>
                    <div className="order-header-right">
                      {isExpanded ? (
                        <FaChevronUp className="chevron-icon" />
                      ) : (
                        <FaChevronDown className="chevron-icon" />
                      )}
                    </div>
                  </div>
                  {isExpanded && (
                    <div className="order-content">
                      <div className="order-details">
                        <p className="order-detail">
                          Date: {formatDateTimeFull(order.order_date)}
                        </p>
                        <p className="order-detail">
                          Status:{" "}
                          <span className={`order-status ${order.status}`}>
                            {order.status}
                          </span>
                        </p>
                        {order.promotion_code &&
                          (() => {
                            // Prefer stored discount_amount (persisted on order, tax-inclusive) if available
                            const storedDiscount =
                              typeof order.discount_amount !== "undefined" &&
                              order.discount_amount !== null
                                ? order.discount_amount
                                : null;

                            if (storedDiscount !== null) {
                              return (
                                <p className="order-detail">
                                  Promo Code:{" "}
                                  <span className="promotion-badge">
                                    {order.promotion_code}
                                  </span>
                                  {storedDiscount > 0 && (
                                    <span className="order-discount-inline">
                                      Total saved on this purchase:{" "}
                                      {formatPriceConverted(
                                        storedDiscount,
                                        currency
                                      )}
                                    </span>
                                  )}
                                </p>
                              );
                            }
                          })()}
                      </div>

                      <div className="items-section">
                        <h3 className="items-title">Items:</h3>
                        <div className="items-list">
                          {(Array.isArray(order.items) ? order.items : []).map(
                            (item) => {
                              const unitPrice = item.price;
                              const totalPrice = unitPrice * item.quantity;

                              return (
                                <div
                                  key={item.product_id}
                                  className="item-card"
                                >
                                  <img
                                    src={
                                      item.product_image &&
                                      item.product_image.startsWith("/uploads")
                                        ? `http://localhost:3001${item.product_image}`
                                        : item.product_image ||
                                          "https://via.placeholder.com/50"
                                    }
                                    alt={item.product_name}
                                    className="item-image"
                                  />
                                  <div className="item-details">
                                    <p className="item-name">
                                      {item.product_name}
                                    </p>
                                    <p className="item-meta">
                                      Checkout Unit Price:{" "}
                                      {formatPriceConverted(
                                        unitPrice,
                                        currency
                                      )}{" "}
                                      (x{item.quantity})
                                    </p>
                                    <p className="item-meta">
                                      Total:{" "}
                                      {formatPriceConverted(
                                        totalPrice,
                                        currency
                                      )}
                                    </p>
                                  </div>
                                </div>
                              );
                            }
                          )}
                        </div>
                      </div>
                    </div>
                  )}
                </div>
              );
            })}
          </div>
        )}
      </div>

      {/* Pagination */}
      {orders.length > 0 && (
        <div className="pagination-wrapper">
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
  );
};

export default OrderHistory;
