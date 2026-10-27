# CONTRA BY NIRO® — international commerce setup

## Storefront features in source
- Country selection for Bangladesh, Saudi Arabia, UAE, US, UK, EU, Canada, Australia, Pakistan and India.
- Region-based currency display and payment-method choices.
- International checkout fields: recipient, phone, email, street address, city/region and postal code.
- Bangladesh options: bKash, Nagad, Rocket, cards, bank transfer and COD; Saudi Arabia options: mada, STC Pay, Apple Pay, cards, PayPal and COD; other regions show available common card/wallet choices.
- Dedicated Supabase project with the core commerce schema, row-level security, and 12 seeded editorial product listings.
- Storefront reads active catalog records from Supabase using a public publishable key and the public-products RLS policy; local demo data is a fallback only.
- RLS policies prevent browser clients from directly creating or editing orders, payments, or inventory.

## Payment integration status
Payment choices in the UI are not live gateway integrations. Before accepting money, the merchant must open and verify provider accounts, configure secrets on a trusted server, implement provider-specific checkout creation, signature/webhook verification, idempotency, refunds and reconciliation, then complete sandbox and production tests. Never put secret keys in browser code, public Git or Vite client variables.

### Recommended rollout
1. Bangladesh first: merchant-approved bKash Checkout and/or a Bangladesh gateway supporting the selected mobile financial services and cards. Keep COD as a separate manual payment method.
2. Saudi Arabia: a locally approved provider such as Moyasar for mada, cards, Apple Pay and STC Pay where the merchant account has those methods enabled.
3. International cards and wallets: use a provider that supports the country where the business entity and payout bank are registered. A customer's location does not determine whether a Bangladesh-based merchant can open a Stripe account. PayPal and wallet availability also depends on merchant country and account approval.
4. Add additional local gateways country-by-country after business registration, settlement, compliance and refund requirements are confirmed.

## Server-side environment secrets
Use a hosting secret manager; add only providers you onboard:
- SUPABASE_URL
- SUPABASE_SERVICE_ROLE_KEY (server-side only)
- BKASH_BASE_URL, BKASH_APP_KEY, BKASH_APP_SECRET, BKASH_USERNAME, BKASH_PASSWORD
- MOYASAR_SECRET_KEY, MOYASAR_PUBLISHABLE_KEY
- STRIPE_SECRET_KEY, STRIPE_WEBHOOK_SECRET (only if eligible)
- PAYPAL_CLIENT_ID, PAYPAL_CLIENT_SECRET, PAYPAL_WEBHOOK_ID
- Add Nagad, SSLCommerz, aamarPay, PortWallet or other credentials only for the chosen provider and contract.

## Currency, tax and delivery
- Currency conversion in the front-end is an indicative display only, not a live FX feed. Never use it to calculate a charge.
- Store catalogue prices in BDT and calculate the payable amount on the server with a trusted exchange-rate source or provider-specific settlement logic. Persist currency, rate, shipping, tax and total snapshots on each order.
- Configure country-specific shipping zones, delivery estimates, returns, import duties/VAT and taxes before international launch. Do not promise free shipping worldwide by default.
- The catalog is connected, but checkout is still a preview: it does not persist orders, reserve stock, charge payment methods or send confirmation emails.

## Database migration
The initial schema is at `supabase/migrations/202610270001_contra_commerce_core.sql`, with performance tuning in `supabase/migrations/202610270002_contra_commerce_indexes_rls_tuning.sql` and the editorial catalog seed in `supabase/migrations/202610270003_contra_seed_editorial_catalog.sql`. The dedicated project is `ffhxtxntgiecklaosgza` (Singapore). The schema and seed have been applied there.

## Deployment blocker
GitHub source is updated, but Vercel returned 403 when attempting to create a new project. Do not connect this repo to or overwrite the unrelated nirob-portfolio project. An authorised Vercel project must be created or selected before production deployment.
