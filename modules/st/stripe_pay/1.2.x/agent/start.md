<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Stripe Pay (stripe_pay) — agent index

**Stripe Checkout integration: a Stripe payment field plus public payment-init/success/cancel routes.**

- **Version:** 1.2.x
- **Core:** `^9 || ^10 || ^11`
- **Depends:** field (+ Stripe PHP SDK via `stripe_pay.libraries.yml`)
- **Configure:** `/admin/stripe-configurations` (`StripeConfig`, perm `administer site configuration`) — test/live keys, currency, test_mode.
- **Field:** `StripePayment` field type + widget + default formatter.
- **Routes:** `stripe_pay.payment_init` `/stripe-payment-init` (POST, `_access: 'TRUE'`); `stripe_pay.payment_success` `/stripe-pay/success` (`_access: 'TRUE'`); `stripe_pay.payment_cancel` `/stripe-pay/cancel` (`_access: 'TRUE'`); settings route (admin-gated).
- **Hooks:** `stripe_pay_success_redirect|success_message|cancel_redirect|cancel_message`.

**Security (RECORDED Danger 3 — do not re-investigate):** all three payment routes are `_access: 'TRUE'` (public). `paymentInit()` takes the charge **amount** from the request body (`StripeController.php:78`) → price manipulation; `paymentSuccess()` (`:204`) fulfils/redirects on the visitor's return using request-supplied `redirect`/`session_id` with **no Stripe verification** (no webhook signature / session retrieval) → success bypass + reflected redirect target (`:158-159`, `:225`). See [api/routes.md](api/routes.md).
