<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Commerce Stripe

Two layers: (1) the **global settings** config object, and (2) a **payment gateway** config
entity per Stripe account.

## Global settings — `commerce_stripe.settings`

Form: *Commerce → Configuration → Stripe settings* (`/admin/commerce/config/stripe`, route
`commerce_stripe.settings`, permission `administer commerce stripe`). Keys:

| Key | Default | Meaning |
|---|---|---|
| `load_on_every_page` | `false` | Load Stripe.js on every page (fraud/session continuity). |
| `collect_user_fraud_signals` | `true` | Send Stripe advanced-fraud-detection signals. |
| `link_payments_remote_id` | `false` | Deep-link a payment's remote ID to the Stripe dashboard. |

```bash
drush config:get commerce_stripe.settings
drush config:set commerce_stripe.settings load_on_every_page 1 -y
```

## The payment gateway (per Stripe account)

Create at *Commerce → Configuration → Payment gateways → Add* (a `commerce_payment_gateway`
config entity). Pick a plugin:

- **`stripe_payment_element`** — "Stripe Payment Element" (recommended). Off-site style,
  PaymentIntents + Stripe Payment Element. Schema:
  `commerce_payment.commerce_payment_gateway.plugin.stripe_payment_element`.
- **`stripe`** — legacy "Stripe Card Element" (on-site). Schema:
  `…plugin.stripe`.

Key plugin-configuration fields (Payment Element):

| Field | Meaning |
|---|---|
| `mode` | `test` or `live` (from the base gateway config). |
| `publishable_key` | Stripe publishable key (`pk_test_…` / `pk_live_…`). |
| `secret_key` | Stripe secret key (`sk_test_…` / `sk_live_…`). |
| `authentication_method` / `access_token` / `stripe_user_id` | Stripe Connect OAuth (alternative to raw keys). |
| `webhook_signing_secret` | Verifies incoming webhooks (`whsec_…`). |
| `api_version` | Optional Stripe API version pin. |
| `capture_method` | Automatic vs. manual capture. |
| `payment_method_usage` | On-session / off-session storage. |
| `express_checkout.enable_on_cart` | Show Apple/Google Pay buttons on the cart. |
| `express_checkout.allowed_payment_method_types` | Which express methods to offer. |
| `express_checkout.collect_phone_number` / `collect_billing_address` | Extra data in express checkout. |
| `style.theme` / `style.layout` | Payment Element appearance. |

### Create one in code / for tests (local, no Stripe call)

```php
use Drupal\commerce_payment\Entity\PaymentGateway;
$gw = PaymentGateway::create(['id' => 'stripe_test', 'label' => 'Stripe', 'plugin' => 'stripe_payment_element']);
$gw->setPluginConfiguration([
  'mode' => 'test',
  'publishable_key' => 'pk_test_XXX',
  'secret_key' => 'sk_test_XXX',
  'display_label' => 'Stripe',
  'payment_method_types' => ['stripe_card'],
]);
$gw->save();
```

Inspect: `drush config:get commerce_payment_gateway.stripe_test`. Merely **saving** the gateway
does not call Stripe — only real checkout/refund operations hit the API.

## Stripe Connect (OAuth) — instead of pasting keys

Routes `commerce_stripe.connect.oauth_connect_form` / `…oauth_return` /
`…oauth_disconnect_form` under `/admin/commerce/config/payment-gateways/manage/{gateway}/connect`
let an admin authorise a Stripe account; the resulting `access_token` / `stripe_user_id` are
stored on the gateway instead of `secret_key`.
