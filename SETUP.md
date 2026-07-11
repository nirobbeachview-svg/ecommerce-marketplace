# E-Commerce Marketplace - Setup Guide

## Prerequisites

Before you start, make sure you have installed:

- **Node.js** (v14 or higher) - [Download](https://nodejs.org/)
- **Docker** & **Docker Compose** (optional) - [Download](https://www.docker.com/products/docker-desktop)
- **MongoDB** (if not using Docker) - [Download](https://www.mongodb.com/try/download/community)
- **Git** - [Download](https://git-scm.com/)

## Option 1: Using Docker (Recommended)

The easiest way to get started is using Docker Compose, which sets up MongoDB, backend, and frontend automatically.

### Steps:

1. Clone the repository:
```bash
git clone https://github.com/nirobbeachview-svg/ecommerce-marketplace.git
cd ecommerce-marketplace
```

2. Create environment file:
```bash
cp .env.example .env
```

3. Update the `.env` file with your configuration:
   - Add your Stripe keys from https://stripe.com
   - Change JWT_SECRET to a secure random string

4. Start the application:
```bash
docker-compose up
```

5. Access the application:
   - Frontend: http://localhost:3000
   - Backend API: http://localhost:5000
   - MongoDB: mongodb://admin:password@localhost:27017

## Option 2: Manual Setup

### Backend Setup

1. Navigate to backend directory:
```bash
cd backend
```

2. Install dependencies:
```bash
npm install
```

3. Create `.env` file in backend directory:
```bash
cp ../.env.example .env
```

4. Update `.env` with your configuration

5. Make sure MongoDB is running (locally or via Docker)

6. Start the backend server:
```bash
npm run dev
```

Backend will run on http://localhost:5000

### Frontend Setup

1. In a new terminal, navigate to frontend directory:
```bash
cd frontend
```

2. Install dependencies:
```bash
npm install
```

3. Create `.env` file:
```bash
echo "REACT_APP_API_URL=http://localhost:5000" > .env
```

4. Start the frontend:
```bash
npm start
```

Frontend will run on http://localhost:3000

## Configuration

### Environment Variables

**Backend (.env):**
```
PORT=5000
NODE_ENV=development
MONGODB_URI=mongodb://admin:password@mongodb:27017/ecommerce
JWT_SECRET=your_super_secret_jwt_key_here
JWT_EXPIRE=7d
CORS_ORIGIN=http://localhost:3000
STRIPE_PUBLIC_KEY=pk_test_xxxx
STRIPE_SECRET_KEY=sk_test_xxxx
```

**Frontend (.env):**
```
REACT_APP_API_URL=http://localhost:5000
REACT_APP_STRIPE_PUBLIC_KEY=pk_test_xxxx
```

## Getting Stripe Keys

1. Go to [Stripe Dashboard](https://dashboard.stripe.com)
2. Sign up or log in
3. Navigate to Developers > API Keys
4. Copy your publishable and secret keys
5. Add them to your `.env` files

## Database Initialization

The MongoDB database will be automatically initialized with the connection. Mongoose will create collections as needed.

Optionally, you can seed initial data by running:
```bash
cd backend
node scripts/seedDatabase.js
```

## Testing the Application

### Test User Account
```
Email: test@example.com
Password: password123
```

### Test Stripe Card
```
Card Number: 4242 4242 4242 4242
Expiry: Any future date (e.g., 12/25)
CVC: Any 3 digits (e.g., 123)
```

## Common Issues

### Port Already in Use
```bash
# Change the port in .env
PORT=5001
```

### MongoDB Connection Error
Make sure MongoDB is running:
```bash
# If using local MongoDB
mongod

# If using Docker
docker run -d -p 27017:27017 -e MONGO_INITDB_ROOT_USERNAME=admin -e MONGO_INITDB_ROOT_PASSWORD=password mongo
```

### Module Not Found
```bash
# Clear node_modules and reinstall
rm -rf node_modules package-lock.json
npm install
```

## Stopping the Application

### With Docker:
```bash
docker-compose down
```

### Manual:
```bash
# Stop frontend (Ctrl+C in terminal)
# Stop backend (Ctrl+C in terminal)
```

## Next Steps

1. Create admin account
2. Add products to the catalog
3. Configure payment settings
4. Customize the theme
5. Set up email notifications

## Useful Resources

- [Express.js Documentation](https://expressjs.com/)
- [React Documentation](https://react.dev/)
- [MongoDB Documentation](https://docs.mongodb.com/)
- [Stripe Documentation](https://stripe.com/docs)
- [Tailwind CSS](https://tailwindcss.com/)

## Support

For issues or questions, please create an issue in the repository.
