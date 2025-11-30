import React from "react";
import { Link, useLocation } from "react-router-dom";
import "./Sidebar.css";

import {
  MdOutlineAdminPanelSettings,
  MdSpaceDashboard,
  MdDiscount,
  MdLocalShipping,
} from "react-icons/md";

import {
  IoBagHandleSharp,
  IoDocumentsSharp,
  IoSettingsSharp,
} from "react-icons/io5";
import { FaUserGroup } from "react-icons/fa6";

import { RiBox3Fill } from "react-icons/ri";

const Sidebar = ({ sidebarOpen, setSidebarOpen }) => {
  const location = useLocation();

  const handleLinkClick = () => {
    // Close the sidebar when a link is clicked on mobile
    if (window.innerWidth <= 768) {
      setSidebarOpen(false);
    }
  };

  const linkClassName = (path) => {
    return location.pathname === path ? "active" : "";
  };

  return (
    <>
      {/* Overlay for closing the sidebar when clicking outside */}
      {sidebarOpen && (
        <div
          onClick={() => setSidebarOpen(false)}
          className="sidebar-overlay"
        ></div>
      )}

      <div className={`sidebar ${sidebarOpen ? "open" : ""}`}>
        <h3 className="sidebar-header">
          <Link
            to="/manager/dashboard"
            className="sidebar-header-link"
            onClick={handleLinkClick}
          >
            <MdOutlineAdminPanelSettings /> Admin Panel
          </Link>
        </h3>
        <nav className="sidebar-nav">
          <Link
            to="/manager/dashboard"
            className={linkClassName("/manager/dashboard")}
            onClick={handleLinkClick}
          >
            <MdSpaceDashboard /> Dashboard
          </Link>
          <Link
            to="/manager/products"
            className={linkClassName("/manager/products")}
            onClick={handleLinkClick}
          >
            <IoBagHandleSharp /> Products
          </Link>
          <Link
            to="/manager/promotions"
            className={linkClassName("/manager/promotions")}
            onClick={handleLinkClick}
          >
            <MdDiscount /> Promotions
          </Link>
          <Link
            to="/manager/customers"
            className={linkClassName("/manager/customers")}
            onClick={handleLinkClick}
          >
            <FaUserGroup /> Customers
          </Link>
          <Link
            to="/manager/categories"
            className={linkClassName("/manager/categories")}
            onClick={handleLinkClick}
          >
            <RiBox3Fill /> Categories
          </Link>
          <Link
            to="/manager/suppliers"
            className={linkClassName("/manager/suppliers")}
            onClick={handleLinkClick}
          >
            <MdLocalShipping /> Suppliers
          </Link>
          <Link
            to="/manager/orders"
            className={linkClassName("/manager/orders")}
            onClick={handleLinkClick}
          >
            <IoDocumentsSharp /> Orders
          </Link>
          <Link
            to="/manager/settings"
            className={linkClassName("/manager/settings")}
            onClick={handleLinkClick}
          >
            <IoSettingsSharp /> Settings
          </Link>
        </nav>
      </div>
    </>
  );
};

export default Sidebar;
