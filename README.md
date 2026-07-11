# E-Commerce Marketplace Platform

A full-stack e-commerce marketplace application similar to Amazon, Daraz, etc. Built with modern web technologies.

## Features

- **Product Catalog**: Browse thousands of products with filters and search
- **Shopping Cart**: Add/remove items, manage quantities
- **Checkout**: Secure payment processing
- **User Accounts**: Registration, profile management, order history
- **Admin Dashboard**: Product management, order tracking, analytics
- **Reviews & Ratings**: User reviews and product ratings
- **Order Management**: Track orders in real-time
- **Multiple Payment Methods**: Credit card, digital wallets

## Tech Stack

### Frontend
- React 18
- Redux Toolkit for state management
- Tailwind CSS for styling
- Axios for API calls
- React Router for navigation

### Backend
- Node.js with Express.js
- MongoDB for database
- JWT for authentication
- Stripe/PayPal integration for payments
- Mongoose ODM

### DevOps
- Docker containerization
- Docker Compose for orchestration
- GitHub Actions for CI/CD

## Project Structure

```
ecommerce-marketplace/
├── frontend/                 # React application
│   ├── src/
│   ├── public/
│   ├── package.json
│   └── README.md
├── backend/                  # Node.js/Express API
│   ├── models/
│   ├── routes/
│   ├── controllers/
│   ├── middleware/
│   ├── server.js
│   ├── package.json
│   └── README.md
├── docker-compose.yml        # Docker setup
└── .gitignore
```

## Quick Start

### Using Docker (Recommended)
```bash
docker-compose up
```

### Manual Setup

**Backend:**
```bash
cd backend
npm install
npm start
```

**Frontend:**
```bash
cd frontend
npm install
npm start
```

## API Endpoints

### Products
- `GET /api/products` - List all products
- `GET /api/products/:id` - Get product details
- `POST /api/products` - Create product (admin)
- `PUT /api/products/:id` - Update product (admin)
- `DELETE /api/products/:id` - Delete product (admin)

### Authentication
- `POST /api/auth/register` - Register user
- `POST /api/auth/login` - Login user
- `POST /api/auth/logout` - Logout user

### Users
- `GET /api/users/profile` - Get user profile
- `PUT /api/users/profile` - Update user profile

### Orders
- `GET /api/orders` - Get user orders
- `GET /api/orders/:id` - Get order details
- `POST /api/orders` - Create order
- `PUT /api/orders/:id` - Update order status (admin)

### Cart
- `GET /api/cart` - Get user cart
- `POST /api/cart` - Add item to cart
- `DELETE /api/cart/:itemId` - Remove item from cart

## Environment Variables

### Backend (.env)
```
PORT=5000
MONGODB_URI=mongodb://admin:password@mongodb:27017/ecommerce
JWT_SECRET=your_jwt_secret_key
JWT_EXPIRE=7d
STRIPE_PUBLIC_KEY=your_stripe_public_key
STRIPE_SECRET_KEY=your_stripe_secret_key
NODE_ENV=development
```

### Frontend (.env)
```
REACT_APP_API_URL=http://localhost:5000
```

## Database Models

- **User**: Email, password, name, address, phone
- **Product**: Name, description, price, category, stock, images, ratings
- **Order**: User, items, total, status, shipping address
- **Cart**: User, items, quantities
- **Review**: Product, user, rating, comment

## Getting Started

See individual README files in `frontend/` and `backend/` directories for detailed setup instructions.

## Contributing

1. Create a feature branch
2. Make your changes
3. Submit a pull request

## License

MIT
