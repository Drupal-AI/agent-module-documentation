<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Fondy Commerce Payment Gateway (commerce_fondy) — agent index

An **off-site Drupal Commerce payment gateway** for [Fondy](https://fondy.eu) (EU/Ukrainian PSP).
At checkout the shopper's browser is POSTed to `https://api.fondy.eu/api/checkout/redirect/` with a
signed parameter set; the shopper pays on Fondy's hosted page and returns, and Fondy also posts a
server-to-server notification. Both paths verify the Fondy **signature** and the **amount/currency**
against the order before recording a completed payment. Package `Commerce`. Core
`^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Installed as **8.x-1.5** (version dir `8.x-1.x`).

## Dependencies

- Drupal modules: **`commerce:commerce_payment`** and **`commerce:commerce`** (`.info.yml`). No
  PHP-library or third-party Composer requirements. No `.permissions.yml`, `.routing.yml`,
  `.services.yml`, `.module` or `.install` — the module is two classes plus a config schema.

## What it provides (from source)

- **Payment gateway plugin** `fondy_redirect` (`@CommercePaymentGateway`,
  `src/Plugin/Commerce/PaymentGateway/OffsiteRedirect.php`), extending
  `OffsitePaymentGatewayBase`. Label "Fondy (Redirect to payment page)", display label "Fondy".
  Declares one form: `offsite-payment` → `FondyOffsiteForm`.
- **Off-site redirect form** `src/PluginForm/OffsiteRedirect/FondyOffsiteForm.php`
  (extends Commerce `PaymentOffsiteForm`) — builds the auto-submitting POST to Fondy and computes
  the request signature.
- **Config schema** `config/schema/commerce_fondy.schema.yml` for the plugin config:
  `merchant_id`, `secret_key`, `language`, `preauth`.

## Configuration (gateway plugin `defaultConfiguration`)

- `merchant_id` (string, required) — Fondy merchant identifier.
- `secret_key` (string, required) — Fondy secret/private key; the shared secret for signing.
- `language` (select) — credit-card-form language: `ru`, `ua`, `en`, `pl`, `lv`, or
  `LANGCODE_NOT_SPECIFIED` ("Language of the user" → the customer's preferred langcode). Default `en`.
- `preauth` (boolean) — send `preauth=Y` to authorize-only instead of capture. Default `FALSE`.

## Payment flow (from source)

- **Request build** (`FondyOffsiteForm::buildConfigurationForm`): assembles `merchant_id`,
  `order_id` (`{order_id}#{time()}`, separator `#`), `order_desc`, `amount` (order total ×100,
  integer minor units), `currency`, `response_url` (Commerce `checkout.return`),
  `server_callback_url` (gateway `getNotifyUrl()`), `sender_email`, `preauth`, `lang`, and a
  `merchant_data` JSON blob of billing-profile fields. Adds `signature` and posts to Fondy.
- **Signature** (`FondyOffsiteForm::getSignature`): drops empty/NULL params, `ksort()`s the rest,
  concatenates `secret_key` then each value joined by `|`, returns `sha1()`. Same routine verifies
  the callback.
- **Return** (`OffsiteRedirect::onReturn`) and **server notify** (`OffsiteRedirect::onNotify`):
  parse the order id, load the order, and call `isPaymentValid()`. On success a `commerce_payment`
  is created in state `completed` with `amount = $order->getTotalPrice()` (the order's own total,
  not the callback figure), `remote_id = payment_id`, `remote_state = order_status`. `onNotify`
  additionally sets the order to `cancelled` for `expired`/`declined` statuses and de-dupes the
  prior payment for the same `payment_id` before recreating it, then echoes `Ok`.
- **Validation** (`OffsiteRedirect::isPaymentValid`): rejects if `merchant_id` mismatches, if the
  callback currency ≠ order currency or `amount/100` ≠ order total (`validateSum`), or if the
  recomputed signature (over the callback params minus `signature`/`response_signature_string`)
  does not match the posted `signature`. Only then is the payment recorded.

No submodules, services, routes, permissions, hooks, JS or templates. The single-file surface does
not warrant separate agent/ subdocs.
