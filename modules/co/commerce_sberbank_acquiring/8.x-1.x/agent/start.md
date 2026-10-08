<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sberbank Acquiring — agent index

Off-site **Drupal Commerce** payment gateway for **Sberbank Acquiring** (Sberbank's card-acquiring
service). At checkout the module registers the order with Sberbank's REST API and redirects the shopper to
Sberbank's hosted payment form; on the browser return the order status is **re-fetched server-side from
Sberbank's authenticated REST API** and the payment is recorded. Wraps the
`voronkovich/sberbank-acquiring-client` PHP library.

- **Version** `8.x-1.0-rc7` (release candidate). **Package** `Commerce`.
- **Core** `^8.7.7 || ^9 || ^10 || ^11` (from `commerce_sberbank_acquiring.info.yml`).
- **Dependencies** `commerce:commerce`, `commerce:commerce_payment`; composer requires
  `voronkovich/sberbank-acquiring-client ^1.1`.
- **License** GPL-2.0-or-later. **Not** covered by Drupal's security-advisory policy. Project created
  2018-05; maintainer Niklan.

## What ships

- `src/Plugin/Commerce/PaymentGateway/SberbankAcquiring.php` — the
  `@CommercePaymentGateway(id = "sberbank_acquiring")` plugin. Extends `OffsitePaymentGatewayBase`.
  `payment_method_types = {"credit_card"}`; `credit_card_types = {maestro, mastercard, visa, mir}`;
  `requires_billing_information = FALSE`. Holds `defaultConfiguration()`, the config form
  (username/password/prefix/suffix), and `onReturn()`.
- `src/PluginForm/OffsiteRedirect/SberbankAcquiringForm.php` — the `offsite-payment` plugin form
  (`PaymentOffsiteForm`). Registers the order with Sberbank and builds the redirect (`REDIRECT_GET`) to
  Sberbank's hosted `formUrl`.
- `commerce_sberbank_acquiring.services.yml` — one service: the `logger.channel.commerce_sberbank_acquiring`
  log channel.
- `commerce_sberbank_acquiring.commerce_adjustment_types.yml` — declares a `sberbank_acquiring_fee`
  Commerce order-adjustment type (label "Sberbank Acquiring Fee", `has_ui: true`). Nothing in this module
  applies it; it is provided for other code/UI to add an acquiring fee adjustment.
- `commerce_sberbank_acquiring.api.php` — documents
  `hook_commerce_sberbank_acquiring_register_order_alter(&$params, $context)`.
- `commerce_sberbank_acquiring.install` — `hook_requirements('install')` errors unless
  `Voronkovich\SberbankAcquiring\Client` exists (the Composer library must be present).
- `config/schema/commerce_payment_sberbank_acquiring.schema.yml` — typed config for the four gateway
  settings.

No routing.yml, no controller, no permissions.yml. `onNotify()` is **not** overridden — there is no inbound
callback/webhook endpoint; completion happens only in the browser-return path.

## Configuration (gateway plugin settings)

Set on the Commerce payment-gateway entity (`/admin/commerce/config/payment-gateways`). Keys/defaults from
`defaultConfiguration()` (SberbankAcquiring.php:102-109) plus the standard Commerce `mode` (test/live) and
`display_label`:

| Key | Type | Notes |
| --- | --- | --- |
| `username` | textfield (required) | Sberbank REST API userName for the selected mode. |
| `password` | password (required) | Sberbank REST API password; stored in config/DB. Leave the field empty on edit to keep the existing password (`submitConfigurationForm` preserves it; `validateConfigurationForm` errors only if no password is set at all). |
| `order_id_prefix` | textfield | Optional string prepended to the Sberbank order number. Default empty. |
| `order_id_suffix` | textfield | Optional string appended to the Sberbank order number. Default empty. |

Test and live REST APIs have **different** credentials; `mode` selects `SberbankClient::API_URI_TEST` vs
`SberbankClient::API_URI`.

## Payment flow

1. **Checkout (register + redirect).** `SberbankAcquiringForm::buildConfigurationForm()`
   (SberbankAcquiringForm.php:104-192):
   - Force-saves the `commerce_payment` if new, then builds the Sberbank order number as
     `order_id_prefix . payment->id() . order_id_suffix` — the **payment id**, not the order id, is used
     (comment: Sberbank rejects re-registering the same order number, so a fresh payment id per attempt
     keeps it unique).
   - Amount is `(int)(payment amount * 100)` (minor units); currency is the order's numeric ISO-4217 code.
   - `$params = ['failUrl' => cancel_url]`, then `hook_commerce_sberbank_acquiring_register_order_alter()`
     may add params (e.g. `sessionTimeoutSecs`).
   - `$client->registerOrder($order_id, $order_amount, $return_url, $params)`. On success the payment stores
     `remoteId = result['orderId']`, sets `authorized` time and state `authorization`, and redirects
     (`buildRedirectForm(..., REDIRECT_GET)`) to `result['formUrl']`.
   - On `ActionException` it logs the order id + message, sets the payment to `authorization_voided`, and
     throws `PaymentGatewayException`.
2. **Return (completion).** `SberbankAcquiring::onReturn()` (SberbankAcquiring.php:198-242):
   - Reads `orderId` from the return query, builds an authenticated `SberbankClient` (userName/password,
     mode-selected apiUri, Drupal `http_client` via `SberbankGuzzleAdapter`).
   - `getOrderStatusExtended($orderId)` — **server-side, authenticated** status fetch.
   - Loads the payment via `loadByRemoteId($orderId)`. If Sberbank reports `DEPOSITED`, marks the payment
     `completed`, records amount + remote state + completed time. Otherwise (incl. `DECLINED`) voids the
     payment and throws `PaymentGatewayException`.

## HTTP / library

All Sberbank calls go through `Voronkovich\SberbankAcquiring\Client` wired to Drupal's `http_client`
(Guzzle) via `SberbankGuzzleAdapter`. The API endpoint is the library's fixed HTTPS constant (test or live);
there is no free-text endpoint setting. TLS verification is left at Guzzle's secure default.

## Extension point

`hook_commerce_sberbank_acquiring_register_order_alter(array &$params, array $context)` — alter the extra
parameters sent to `registerOrder`. `$context['payment']` is the `PaymentInterface`. See
`commerce_sberbank_acquiring.api.php`. Misuse can break order registration (documented warning).

## Security posture (positive)

Order status is re-fetched on return from Sberbank's **authenticated** REST API
(`getOrderStatusExtended`, using the configured credentials) rather than trusting the returning request's
fields. The Sberbank API host is a fixed HTTPS constant (no free-text endpoint, no SSRF), and TLS
certificate verification uses Guzzle's secure default. Keep the Sberbank username/password out of exported
config (env var / `settings.php` override) and serve checkout over HTTPS.

## See also

- `../usage.md` — task-oriented summary.
- `../human-docs/` — UI setup guide for site builders.
