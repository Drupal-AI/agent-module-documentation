<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Stripe — agent index

Stripe payment integration for Drupal Commerce (`^3`). Provides two payment-gateway plugins,
a family of Stripe payment-method-type plugins, express checkout (Apple/Google Pay), Stripe
Connect, and webhook logging (submodule). Uses the `stripe/stripe-php` library.

Key facts:
- `configure` route = `commerce_stripe.settings` → `/admin/commerce/config/stripe` (global settings).
- Gateway plugins: **`stripe_payment_element`** (recommended, PaymentIntents + Payment Element) and legacy **`stripe`** (Card Element). Config lives on the `commerce_payment_gateway.<id>` entity (keys: `publishable_key`, `secret_key`, `mode`, `webhook_signing_secret`, `express_checkout.*`).
- Global config object `commerce_stripe.settings`: `load_on_every_page`, `collect_user_fraud_signals`, `link_payments_remote_id`.
- Submodule: **commerce_stripe_webhook_event** (nested docs under `modules/commerce_stripe_webhook_event/`).

- **Create/configure a Stripe payment gateway + global settings** → [configure/gateway.md](configure/gateway.md)
- **Payment gateway & payment-method-type plugin ids** → [plugins/payment-plugins.md](plugins/payment-plugins.md)
- **Services & helpers (StripeHelper, IntentHelper, express checkout)** → [api/services.md](api/services.md)
- **Events (alter PaymentIntent / express-checkout shipping)** → [hooks/events.md](hooks/events.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)

> Live Stripe API calls need real keys; ground local work in the gateway **config entity**
> (`commerce_payment_gateway.<id>`) and `commerce_stripe.settings`, using `test`-mode placeholder keys.
