# CONTRA BY NIRO® — payment and deployment plan

## Merchant profile and launch scope
- Business registration country: Bangladesh.
- Initial target markets: Bangladesh, Saudi Arabia, then other international destinations.
- Storefront: React + Vite in `frontend/`; GitHub repository `nirobbeachview-svg/ecommerce-marketplace`.
- Do not connect or overwrite the unrelated `nirob-portfolio` project.

## Recommended provider strategy

### Phase 1 — Bangladesh checkout
1. Apply for a bKash online business / checkout merchant account if the business meets its onboarding requirements.
2. Request merchant onboarding and written confirmation from EPS and SSLCOMMERZ (compare pricing, settlement currencies, chargeback/refund support, international-card acceptance, and the exact supported payment methods).
3. Choose one primary Bangladesh gateway for cards and the local methods it contractually supports. Keep COD as a separate manual payment method.
4. Do not show bKash/Nagad/Rocket/card as an active online payment unless that exact method is enabled in the approved merchant account and is connected end-to-end.

Official starting points:
- bKash business: https://www.bkash.com/en/business
- bKash developer docs: https://developer.bka.sh/docs/checkout-url-process-overview
- EPS gateway: https://www.eps.com.bd/public/eps-gateway
- EPS onboarding: https://eps.com.bd/public/join-us/payment-flow
- SSLCOMMERZ: https://sslcommerz.com/

Before choosing EPS or SSLCOMMERZ, ask each provider to confirm in writing that a Bangladesh-registered merchant selling the store's actual product categories can accept payments from Saudi Arabia and other countries, what currencies customers can pay in, what currency settles to the Bangladeshi bank account, and whether foreign-issued cards are enabled.

### Phase 2 — Saudi customers
- First test Saudi-issued Visa/Mastercard through the approved Bangladesh gateway, if cross-border acquiring is enabled.
- Do not promise mada, STC Pay, or Saudi Apple Pay as available until the selected provider explicitly confirms both method support and merchant eligibility for a Bangladesh entity.
- Moyasar documents cards, Apple Pay, STC Pay and related flows, but merchant onboarding eligibility must be confirmed directly: https://docs.moyasar.com/ and https://www.moyasar.com/en/resources/faqs/.
- If a Saudi-local provider requires a Saudi-registered entity/bank account, defer that integration until the business has the required legal setup.

### Phase 3 — wider international sales
- Add other markets only after confirming card acceptance, settlement, refund handling, shipping coverage, duties/tax obligations, and product restrictions.
- Do not base launch on Stripe for a Bangladesh-registered business: Bangladesh is absent from Stripe's supported business-country list. A customer living in a Stripe-supported country does not make a Bangladesh merchant eligible. See https://stripe.com/global and https://support.stripe.com/questions/requirements-to-open-a-stripe-account-in-another-country.
- Do not advertise PayPal, Apple Pay, Google Pay, Shop Pay, or a local wallet until the selected merchant account and checkout integration actually support it.

## Implementation requirements before accepting money
1. Provision a **dedicated CONTRA store Supabase project** after selecting the organization and reviewing any cost. Do not apply the store migration to an unrelated existing project.
2. Apply and review `supabase/migrations/202610270001_contra_commerce_core.sql` in that dedicated project.
3. Replace the demonstration product catalogue with database-backed products, server-calculated prices, stock validation and shipping rules.
4. Add server-side checkout creation. The browser may submit product IDs, quantities, shipping destination and a selected method; the server must reload product prices and calculate the authoritative amount.
5. Use a provider adapter for the selected gateway; store only provider IDs/statuses, never card PAN/CVV or wallet PIN/OTP.
6. Verify provider webhook signatures server-side; use idempotency keys; handle duplicate/out-of-order events; update payment/order state only after verified provider confirmation; add refund and reconciliation flows.
7. Send order confirmations only after an order is actually persisted; send payment confirmation only after verified success.
8. Test sandbox success, failure, cancellation, duplicate callbacks, expired sessions, refunds, currency/amount mismatch, stock race conditions and webhook retries before production.

## Currency, shipping and compliance
- The current currency conversions are illustrative UI estimates. They must not determine a charge or invoice total.
- For the first live release, charge in the currency and settlement flow approved by the gateway (likely BDT unless the provider confirms other presentment currencies). Displaying SAR/USD is not the same as charging in SAR/USD.
- Calculate shipping by destination and parcel; disclose duties, taxes, delivery estimates, returns and refund rules before payment. Do not imply free worldwide shipping.
- Confirm business registration, tax, consumer protection, import/export and payment-provider requirements for each market with the appropriate professionals/providers.

## Secret management
Add secrets only in Vercel Project Settings → Environment Variables or the chosen backend's secret manager. Never commit real values, paste them into chat, expose them as `VITE_*` variables, or place service-role/payment secrets in browser code.

Expected server-side configuration after provider selection:
- `SUPABASE_URL`
- `SUPABASE_SERVICE_ROLE_KEY` (server-only)
- The selected provider's merchant ID, API key/secret, and webhook verification secret, using the exact names required by its integration.
- Public return/callback URL and allowed production origin, configured without secrets.

## Current deployment state and blocker
The Vercel account's visible team has no linked projects, and the attempt to create a Git-linked project previously returned HTTP 403. Do not retry unchanged or connect this repo to the unrelated portfolio. Deployment requires resolving Vercel Git/project permissions or choosing an already-authorized CONTRA-specific project. Once authorized, use `frontend` as the Vercel root directory and run `npm run build` from that directory.

## Current live-readiness status
The current storefront still uses demo catalogue/client-side state. Payment choices are not live integrations, orders are not persisted, and checkout does not charge customers. Do not accept real orders until the backend, merchant approval, payment callbacks, database, deployment and production tests are complete.
