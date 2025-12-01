# 🛒 TechStock - E-commerce Platform

A full-stack e-commerce platform for technology products, featuring a React frontend and Node.js/Express backend with MySQL database integration.

## 📋 Overview

TechStock is a comprehensive e-commerce solution that enables users to browse, search, and purchase technology products. The platform includes user authentication, shopping cart functionality, order management, payment processing via Stripe, and an admin dashboard for managing products, categories, suppliers, and promotions.

## ✨ Features

- 🔐 **User Authentication**: Secure registration and login with JWT-based authentication
- 📦 **Product Management**: Browse products by category with advanced filtering and search
- 🛍️ **Shopping Cart**: Session-based cart management with real-time updates
- 📋 **Order Processing**: Complete checkout flow with order tracking
- 💳 **Payment Integration**: PayPal payment gateway for secure transactions
- 📊 **Admin Dashboard**: Comprehensive admin panel with analytics and charts
- 🎁 **Promotion System**: Automated discount and promotion management
- 🏢 **Supplier Management**: Track and manage product suppliers
- 📞 **Contact System**: Customer support contact form with email notifications
- 📱 **Responsive Design**: Mobile-friendly interface built with React and Material-UI

## 🛠️ Tech Stack

### 🎨 Frontend
- React 19.1.0
- React Router DOM 7.6.0
- Chart.js 4.4.9 (for analytics)
- PayPal React Components
- Axios for API communication

### ⚙️ Backend
- Node.js with Express 4.18.2
- MySQL2 for database connectivity
- JWT for authentication
- bcryptjs for password hashing
- Nodemailer for email notifications
- PDFKit for invoice generation
- Multer for file uploads

## 📁 Project Structure

```
TechStockFinalProject/
├── backend/
│   ├── src/
│   │   ├── controllers/    # Business logic
│   │   ├── routes/         # API endpoints
│   │   └── middleware/     # Authentication middleware
│   ├── utils/              # Utility functions
│   ├── uploads/            # Product images
│   ├── server.js           # Express server
│   └── dbSingleton.js      # Database connection
├── frontend/
│   ├── src/
│   │   ├── components/     # Reusable UI components
│   │   ├── pages/          # Page components
│   │   ├── context/        # React context providers
│   │   ├── hooks/          # Custom React hooks
│   │   └── utils/          # Helper functions
│   └── public/             # Static assets
├── techstockDB.sql         # Database schema
└── users.txt               # Test user credentials
```

## 🚀 Getting Started

### 📋 Prerequisites

- Node.js (v14 or higher)
- MySQL Server
- npm or yarn package manager

### 🗄️ Database Setup

1️⃣ Import the database schema:
```bash
mysql -u root -p < techstockDB.sql
```

2️⃣ Configure database connection in `backend/env.config`:
```
DB_HOST=localhost
DB_USER=your_username
DB_PASSWORD=your_password
DB_NAME=techstock
JWT_SECRET=your_jwt_secret
```

### ⚙️ Backend Installation

```bash
cd backend
npm install
npm start
```

🌐 The backend server will run on `http://localhost:3001`

### 🎨 Frontend Installation

```bash
cd frontend
npm install
npm start
```

🌐 The frontend application will run on `http://localhost:3000`

## 🔑 Test Credentials

Test user accounts are available in `users.txt`:
- 📧 Email: `admin@gmail.com`
- 🔒 Password: `123456`

Additional test accounts are listed in the file with the same password.

## 📡 API Endpoints

### 🔐 Authentication
- `POST /api/auth/register` - User registration
- `POST /api/auth/login` - User login
- `POST /api/auth/logout` - User logout

### 📦 Products
- `GET /api/products` - Get all products
- `GET /api/products/:id` - Get product by ID
- `POST /api/products` - Create product (admin)
- `PUT /api/products/:id` - Update product (admin)
- `DELETE /api/products/:id` - Delete product (admin)

### 📋 Orders
- `GET /api/orders` - Get user orders
- `POST /api/orders` - Create new order
- `GET /api/orders/:id` - Get order details

### 🏷️ Categories
- `GET /api/categories` - Get all categories
- `POST /api/categories` - Create category (admin)

### 🎁 Promotions
- `GET /api/promotions` - Get active promotions
- `POST /api/promotions` - Create promotion (admin)

### 👨‍💼 Admin
- `GET /api/admin/dashboard` - Get dashboard statistics
- `GET /api/admin/users` - Manage users

## 💳 Payment Processing

The application uses **PayPal Sandbox** for testing and development. Configure your PayPal API credentials in the backend environment configuration file.

For production, update the PayPal configuration to use live credentials instead of sandbox credentials.

## 📧 Email Notifications

Order confirmations and contact form submissions are sent via **Nodemailer**. Configure SMTP settings in the backend environment file.

## 🧪 Testing

### 🎨 Frontend Tests
```bash
cd frontend
npm test
```

### ⚙️ Backend Tests
```bash
cd backend
npm test
```

## 👥 Authors

- Bshara Karkaby
- Moner Mahkouly

---

<div align="center">
Made with ❤️ using React & Node.js
</div>
