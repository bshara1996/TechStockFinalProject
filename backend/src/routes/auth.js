const express = require("express");
const { authenticateToken } = require("../middleware/auth.js");
const loginLimiter = require("../../utils/loginLimiter.js");
const {
  uploadImage,
  register,
  login,

  changePassword,
  forgotPassword,
  resetPassword,
  upload,
} = require("../controllers/authController.js");

const router = express.Router();

// POST route for uploading an image
router.post(
  "/upload-image",
  authenticateToken,
  upload.single("image"),
  uploadImage
);

// Register user
router.post("/register", register);

// Login user
router.post("/login", login);

// Change password
router.put("/change-password", authenticateToken, changePassword);

// Request password reset
router.post("/forgot-password", forgotPassword);

// Reset password
router.post("/reset-password/:token", resetPassword);

module.exports = router;
