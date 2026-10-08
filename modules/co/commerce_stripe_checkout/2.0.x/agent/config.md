<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Gateway configuration

Plugin: `CommerceStripeCheckoutCheckout` (id `commerce_stripe_checkout_checkout`). Config is stored
on the `commerce_payment_gateway.<id>` entity; schema in
`config/schema/commerce_stripe_checkout.schema.yml`.

## Config keys (`defaultConfiguration()`)

| Key | Type | Default | Notes |
|---|---|---|---|
| `mode` | string | `test` | Inherited from `PaymentGatewayBase`. Selects which secret key is used. |
| `live_secret_key` | string | `''` | `sk_live_…`. Used when `mode = live`. |
| `secret_key` | string | `''` | `sk_test_…`. Used when `mode = test`. (There is **no** publishable key.) |
| `pass_customer_email` | bool | `FALSE` | Pre-fills `customer_email` on the Stripe page from `$order->getEmail()`. |
| `webhook_secret` | string | `''` | `whsec_…` signing secret. When set, webhook POSTs are signature-verified. |
| `allowed_payment_methods` | sequence | `['card']` | Stripe `payment_method_types` sent to the session. `card` is always forced in. |
| `allow_promotion_codes` | bool | `FALSE` | Shows the Stripe promo-code field (codes defined in Stripe → Coupons). |
| `billing_address_collection` | string | `auto` | `auto` \| `required`. Only `required` is passed to Stripe. |
| `collect_phone_number` | bool | `FALSE` | Sets `phone_number_collection.enabled`. |
| `locale` | string | `auto` | Stripe Checkout page language; `auto` = browser. ~37 explicit locales offered. |

`submitConfigurationForm()` also writes `payment_method_mode = 'explicit'`.

## Form (`buildConfigurationForm`)

- **Live/Test secret key** — plain textfields (`autocomplete=off`). `hook_form_alter` in the `.module`
  toggles their visibility with `#states` based on the selected `mode`.
- **Webhook** `details` group: shows the endpoint URL
  `Url::fromRoute('commerce_stripe_checkout.webhook', ['gateway_id' => <id>], absolute)` (or a
  "save the gateway first" note when new), plus the **webhook signing secret** as a `#type: password`
  field with a "(saved — enter a new value to replace)" placeholder — a blank submit keeps the
  stored value.
- **Payment methods** `details` (open): a `checkboxes` element listing 57 Stripe method keys grouped
  by family (cards/wallets, BNPL, bank debits, vouchers, bank redirects, mobile/real-time, South
  Korea, crypto). `#default_value` always merges `card` in. Class `stripe-payment-methods-checkboxes`
  scopes the admin JS.
- **Checkout page options** `details` (closed): `allow_promotion_codes`, `billing_address_collection`
  (radios), `collect_phone_number`, `locale` (select).

## Validation (`validateConfigurationForm`)

- Mode `test`: `secret_key` required and must start with `sk_test_`.
- Mode `live`: `live_secret_key` required and must start with `sk_live_`.
- `webhook_secret` (when a new value is entered): must start with `whsec_`.

Errors are set at save time so misconfiguration is caught before checkout. On empty/missing key or a
missing `stripe/stripe-php` library, the off-site form logs an admin-only error and shows the buyer a
generic "payment processing unavailable" message.

## Admin JS

`js/payment-methods-admin.js` (library `commerce_stripe_checkout/payment.methods.admin`) is purely
cosmetic: it locks the **Card** checkbox on (checked + disabled, "(always required)" badge) and adds
**Select all / Uncheck all** buttons. The server independently re-adds `card` in
`submitConfigurationForm()` and in the form's session build, because a disabled checkbox is not
submitted by the browser.

## Payment-method handling notes

- The form always sends explicit `payment_method_types` (never `automatic_payment_methods`) to avoid
  "card provided more than once" errors when Link is enabled.
- Per-method required options are auto-injected: `wechat_pay` → `{client: 'web'}`; `acss_debit` →
  `mandate_options {payment_schedule: sporadic, transaction_type: personal}` (override via the alter
  hook).
- If Stripe rejects a `payment_method_type` as not activated on the account, the form parses the
  error, logs a warning with a Dashboard link, removes that type (keeping `card`), and retries — up
  to `count(methods)+1` attempts.
