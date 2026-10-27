# CONTRA BY NIRO® — Storefront

A responsive luxury multi-brand storefront for watches, eyewear, leather goods, bags, shoes, clothing, fragrance and everyday objects.

## Stack
- React + Vite
- Framer Motion for restrained motion and transitions
- Lucide icons
- Responsive custom CSS with monochrome glass UI
- Vercel-ready static frontend

## Run locally
```bash
cd frontend
npm install
npm run dev
```

## Production build
```bash
npm run build
npm run preview
```

## Current storefront features
- Responsive editorial homepage with category discovery
- Product catalog with search, category selection, price filter, offer filter and sorting
- Quick-view product modal, wishlist, compare selection and cart quantity controls
- Shopping bag drawer with complimentary-delivery progress
- Checkout preview with Bangladesh-oriented delivery fields and payment-method selection
- Currency display toggle (BDT/USD), English/Bangla label toggle, dark/light theme
- Newsletter form interaction, mobile navigation and mobile bottom bar
- Accessibility focus styles and reduced-motion/transparency preferences

## Production integrations still required
The current build uses a demonstration product catalogue and client-side state. Connect a database and API for persistent inventory, customers, orders and reviews; configure authentication; connect a real payment gateway (bKash/Nagad/cards), shipping provider, email/newsletter service, analytics and customer support before taking live orders. Checkout currently previews an order and does not charge or submit a real order.

Product photos use externally hosted Unsplash image URLs. Replace with licensed brand/product photography before commercial launch.
