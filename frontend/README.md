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
- Country/region selector for 10 markets, indicative regional currency display, English/Bangla label toggle, dark/light theme
- Newsletter form interaction, mobile navigation and mobile bottom bar
- Accessibility focus styles and reduced-motion/transparency preferences

## Production integrations still required
The storefront now fetches active product listings from the dedicated Supabase catalog and falls back to the bundled editorial demo catalog if the API is unavailable. Cart, wishlist and checkout form state are still client-side only. Persistent customer accounts, orders, stock reservation, order emails, shipping, tax, returns, analytics and a real payment gateway still need secure server-side implementation before taking live orders. Checkout currently previews an order and does not charge or submit a real order.

Product photos use externally hosted Unsplash image URLs. Replace with licensed brand/product photography before commercial launch.


## International checkout
The UI includes country selection for Bangladesh, Saudi Arabia, UAE, US, UK, EU, Canada, Australia, Pakistan and India; regional currency display; and country-specific payment-method options. These options are currently a checkout preview, not live payment processing. See [`docs/INTERNATIONAL_COMMERCE.md`](../docs/INTERNATIONAL_COMMERCE.md) for provider onboarding, secure server-side secrets, FX/tax/shipping requirements and deployment blockers. The schema is in `supabase/migrations/202610270001_contra_commerce_core.sql`; the initial editorial catalog seed is `supabase/migrations/202610270003_contra_seed_editorial_catalog.sql`. These migrations belong only on the dedicated store database.


## Payment and deployment decision plan
See [`docs/PAYMENT_AND_DEPLOYMENT_PLAN.md`](../docs/PAYMENT_AND_DEPLOYMENT_PLAN.md) for the Bangladesh-first gateway recommendation, Saudi/international rollout, merchant eligibility checks, secure webhook requirements and current Vercel deployment blocker.
