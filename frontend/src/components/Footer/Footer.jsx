import React from "react";
import "./Footer.css";

import { FaInstagram, FaFacebook } from "react-icons/fa";
import { FaXTwitter } from "react-icons/fa6";
const Footer = () => {
  const handleSocialClick = (url) => {
    window.open(url, "_blank", "noopener,noreferrer");
  };

  return (
    <footer className="footer">
      <div className="footer-container">
        {/* TechStore Info */}
        <div className="footer-section">
          <h3 className="footer-title">TechStock</h3>
          <p className="footer-text">
            Your one-stop shop for premium tech products <br />
            and cutting-edge electronics. Quality guaranteed.
          </p>
        </div>

        {/* Contact Us */}
        <div className="footer-section contact">
          <h3 className="footer-title">Contact Us</h3>
          <p className="footer-text">Email: techstock2025@gmail.com</p>
          <p className="footer-text">Phone 1: (052) 589-2825 </p>
          <p className="footer-text">Phone 2: (054) 601-9717</p>
          <p className="footer-text">
            Address: HaShalom 20 Street, Nesher - Israel
          </p>
        </div>

        {/* Follow Us */}
        <div className="footer-section social">
          <h3 className="footer-title">Follow Us</h3>
          <div className="social-buttons">
            <button
              onClick={() =>
                handleSocialClick(
                  "https://www.facebook.com/GoIvory/?locale=he_IL"
                )
              }
              className="social-button facebook"
              title="Follow us on Facebook"
            >
              <FaFacebook />
            </button>

            <button
              onClick={() =>
                handleSocialClick("https://www.instagram.com/ivory.il/")
              }
              className="social-button instagram"
              title="Follow us on Instagram"
            >
              <FaInstagram />
            </button>

            <button
              onClick={() => handleSocialClick("https://x.com/ivoryservice")}
              className="social-button twitter"
              title="Follow us on X (Twitter)"
            >
              <FaXTwitter />
            </button>
          </div>
        </div>
      </div>

      <div className="footer-bottom">
        © {new Date().getFullYear()} TechStock. All rights reserved.
      </div>
    </footer>
  );
};

export default Footer;
