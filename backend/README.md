# E-Commerce Backend API

Node.js/Express-based REST API for the e-commerce marketplace.

## Technologies

- **Node.js** - Runtime environment
- **Express.js** - Web framework
- **MongoDB** - NoSQL database
- **Mongoose** - ODM for MongoDB
- **JWT** - Authentication
- **Bcrypt** - Password hashing
- **Stripe** - Payment processing
- **Dotenv** - Environment configuration

## Setup

### Prerequisites
- Node.js 14+
- MongoDB 4.4+
- npm or yarn

### Installation

```bash
cd backend
npm install
```

### Environment Variables

Create a `.env` file:

```
PORT=5000
MONGODB_URI=mongodb://admin:password@mongodb:27017/ecommerce
JWT_SECRET=your_jwt_secret_key_here
JWT_EXPIRE=7d
STRIPE_PUBLIC_KEY=your_stripe_public_key
STRIPE_SECRET_KEY=your_stripe_secret_key
NODE_ENV=development
CORS_ORIGIN=http://localhost:3000
```

### Running the Server

```bash
npm start
```

The server will run on `http://localhost:5000`

## Project Structure

```
src/
├── models/              # Database schemas
│   ├── User.js
│   ├── Product.js
│   ├── Order.js
│   ├── Cart.js
│   └── Review.js
├── routes/              # API routes
│   ├── auth.js
│   ├── products.js
│   ├── orders.js
│   ├── users.js
│   └── cart.js
├── controllers/         # Route controllers
├── middleware/          # Custom middleware
│   ├── auth.js
│   └── errorHandler.js
├── utils/               # Utility functions
├── config/              # Configuration files
└── server.js            # Entry point
```

## API Endpoints

### Authentication
- `POST /api/auth/register` - Register new user
- `POST /api/auth/login` - Login user
- `POST /api/auth/logout` - Logout user
- `POST /api/auth/refresh` - Refresh JWT token

### Products
- `GET /api/products` - List all products (paginated)
- `GET /api/products/:id` - Get product details
- `GET /api/products/category/:category` - Get products by category
- `POST /api/products` - Create product (admin only)
- `PUT /api/products/:id` - Update product (admin only)
- `DELETE /api/products/:id` - Delete product (admin only)

### Users
- `GET /api/users/profile` - Get current user profile
- `PUT /api/users/profile` - Update user profile
- `GET /api/users/:id` - Get user by ID (admin only)
- `DELETE /api/users/:id` - Delete user (admin only)

### Orders
- `GET /api/orders` - Get user orders
- `GET /api/orders/:id` - Get order details
- `POST /api/orders` - Create new order
- `PUT /api/orders/:id` - Update order (admin only)
- `DELETE /api/orders/:id` - Cancel order

### Cart
- `GET /api/cart` - Get user cart
- `POST /api/cart` - Add item to cart
- `PUT /api/cart/:itemId` - Update cart item quantity
- `DELETE /api/cart/:itemId` - Remove item from cart
- `DELETE /api/cart` - Clear cart

### Reviews
- `GET /api/reviews/product/:productId` - Get reviews for product
- `POST /api/reviews` - Create review
- `PUT /api/reviews/:id` - Update review
- `DELETE /api/reviews/:id` - Delete review

## Database Models

### User
```javascript
{
  _id: ObjectId,
  name: String,
  email: String (unique),
  password: String (hashed),
  phone: String,
  address: String,
  city: String,
  country: String,
  zipCode: String,
  isAdmin: Boolean,
  createdAt: Date,
  updatedAt: Date
}
```

### Product
```javascript
{
  _id: ObjectId,
  name: String,
  description: String,
  price: Number,
  originalPrice: Number,
  category: String,
  stock: Number,
  images: [String],
  rating: Number,
  reviews: Number,
  seller: String,
  createdAt: Date,
  updatedAt: Date
}
```

### Order
```javascript
{
  _id: ObjectId,
  user: ObjectId (ref: User),
  items: [{
    product: ObjectId (ref: Product),
    quantity: Number,
    price: Number
  }],
  totalPrice: Number,
  status: String,
  shippingAddress: Object,
  paymentMethod: String,
  transactionId: String,
  createdAt: Date,
  deliveredAt: Date
}
```

## Available Scripts

- `npm start` - Start production server
- `npm run dev` - Start development server with nodemon
- `npm test` - Run tests
- `npm run lint` - Run ESLint

## Error Handling

The API uses standard HTTP status codes:
- `200` - Success
- `201` - Created
- `400` - Bad Request
- `401` - Unauthorized
- `403` - Forbidden
- `404` - Not Found
- `500` - Server Error

## Security Features

- JWT authentication
- Password hashing with bcrypt
- CORS protection
- Input validation and sanitization
- SQL injection prevention (using Mongoose)
- Rate limiting (recommended)
- HTTPS in production

## Deployment

See main README.md for Docker deployment instructions.
