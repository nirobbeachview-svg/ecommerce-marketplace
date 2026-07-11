# E-Commerce Frontend

React-based frontend for the e-commerce marketplace.

## Technologies

- **React 18** - UI library
- **Redux Toolkit** - State management
- **Tailwind CSS** - Styling
- **Axios** - HTTP client
- **React Router v6** - Navigation
- **React Query** - Server state management
- **Formik & Yup** - Form handling and validation

## Setup

### Prerequisites
- Node.js 14+
- npm or yarn

### Installation

```bash
cd frontend
npm install
```

### Environment Variables

Create a `.env` file:

```
REACT_APP_API_URL=http://localhost:5000
REACT_APP_STRIPE_PUBLIC_KEY=your_stripe_public_key
```

### Running the App

```bash
npm start
```

The app will open at `http://localhost:3000`

## Project Structure

```
src/
├── components/          # Reusable components
├── pages/              # Page components
├── store/              # Redux store configuration
├── slices/             # Redux slices
├── services/           # API services
├── hooks/              # Custom hooks
├── utils/              # Utility functions
├── styles/             # CSS/Tailwind styles
└── App.jsx
```

## Available Scripts

- `npm start` - Start development server
- `npm run build` - Build for production
- `npm test` - Run tests
- `npm run eject` - Eject from create-react-app (irreversible)

## Features

- Product listing with filters and search
- Shopping cart management
- User authentication
- Order management
- User profile and preferences
- Product reviews and ratings
- Admin dashboard (product management)
- Responsive design

## Building for Production

```bash
npm run build
```

This creates an optimized production build in the `build/` directory.
