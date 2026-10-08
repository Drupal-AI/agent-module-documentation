<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Stripe Checkout — agent index

Drupal Commerce **off-site payment gateway** for **Stripe Checkout** — Stripe's hosted, pre-built
payment page. The buyer is redirected to `checkout.stripe.com`; no card data touches the site.
This is the **redirect / hosted** integration, distinct from the on-site Elements gateway in the
separate `commerce_stripe` project.

Version **2.0.0**. Core `^10 || ^11`. Requires `stripe/stripe-php` (`^10 || ^15 || ^20`) and
Commerce (`commerce`, `commerce_order`, `commerce_cart`, `commerce_payment`; `commerce >= 2.40`).
No permissions, no Drush commands, no submodules. `configure` → payment-gateways collection.

## Key facts

- **Gateway plugin id**: `commerce_stripe_checkout_checkout` (class
  `Plugin/Commerce/PaymentGateway/CommerceStripeCheckoutCheckout`, extends `OffsitePaymentGatewayBase`,
  implements `SupportsRefundsInterface`). Payment type `payment_default`, method type `credit_card`.
- **Config lives on** the `commerce_payment_gateway.<id>` entity (schema
  `config/schema/commerce_stripe_checkout.schema.yml`). Keys: `live_secret_key`, `secret_key`,
  `pass_customer_email`, `webhook_secret`, `allowed_payment_methods` (sequence), `allow_promotion_codes`,
  `billing_address_collection`, `collect_phone_number`, `locale` (+ inherited `mode`, `display_label`).
  There is **no publishable key** — the redirect flow uses only the secret key server-side.
- **Off-site form** `PluginForm/CommerceStripeCheckoutCheckoutForm` builds the Stripe Checkout
  Session and redirects (`REDIRECT_GET`) to `$session->url`.
- **Return handling is custom**, not Commerce's standard `onReturn`: Stripe's `success_url` /
  `cancel_url` point at this module's own routes (`StripeController`), gated by a one-time `stsess`
  token. The plugin's `onReturn()`/`onNotify()` are not part of the normal flow.
- **Webhook** at `/stripe-pay/webhook/{gateway_id}` (`StripeWebhookController`) is the async /
  fallback confirmation path; verified with the `Stripe-Signature` header + signing secret.
- **Routes** (all `_access: 'TRUE'`): `commerce_stripe_checkout.paymentSuccess`
  (`/stripe-pay/success`, GET), `.paymentCancel` (`/stripe-pay/cancel`, GET), `.webhook`
  (`/stripe-pay/webhook/{gateway_id}`, POST, `no_cache`).
- **Amounts**: `StripeAmountTrait::toStripeAmount()` converts to the smallest unit, skipping ×100
  for the 16 zero-decimal currencies (JPY, KRW, VND, …).

## Subdocs

- **Gateway config keys, form, validation, key modes, admin JS** → [config.md](config.md)
- **Checkout Session build + success/cancel redirect flow** → [flow.md](flow.md)
- **Webhook route, events handled, signature verification** → [webhook.md](webhook.md)
- **Refunds, the alter hook, message hooks, dispatched events** → [extending.md](extending.md)

## Setup essentials

Add a gateway at `/admin/commerce/config/payment-gateways/add`, plugin **Stripe Checkout**; enter
the `sk_test_`/`sk_live_` secret key for the selected mode. Register the shown webhook URL in the
Stripe Dashboard and paste its `whsec_` **signing secret** into the gateway's webhook field —
configuring the signing secret is a required production step, and with it set the webhook verifies
every event via `Stripe\Webhook::constructEvent()` and rejects unsigned/invalid POSTs with HTTP 400.

> Live Stripe calls need real keys. Ground local work in the gateway **config entity**
> (`commerce_payment_gateway.<id>`) with `test`-mode placeholder keys; the Stripe API is only hit
> at Checkout Session creation, refund, and (optionally) webhook time.
