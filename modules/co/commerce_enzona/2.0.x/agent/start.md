<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Enzona (commerce_enzona) — agent index

A **Drupal Commerce off-site payment gateway** for **EnZona**, the Cuban payment
platform. The shopper is redirected to EnZona's hosted checkout to pay; on return
the module re-fetches the transaction status from EnZona's REST API and records a
`commerce_payment` when EnZona reports the transaction confirmed/completed.
Package `Commerce (Payment)`. Core `^11`. PHP `>= 8.3`. License GPL-2.0-or-later.
Installed as **2.0.4** (version dir `2.0.x`). Not covered by a security advisory
policy (opt-in coverage; `security coverage: not-covered` in `.info.yml`).

## Dependencies

- Drupal modules (`.info.yml`): **`commerce`**, **`commerce_payment`**,
  **`commerce_order`**, **`commerce_checkout`** (all from `drupal/commerce`).
- Composer: `drupal/core ^11`, `drupal/commerce ^3.3`, `php >=8.3`. No external
  PHP libraries — the EnZona API client is Guzzle (`GuzzleHttp\Client`, from core).

## What it provides (from source)

- **Payment gateway plugin** `enzona_redirect_checkout`
  (`Plugin/Commerce/PaymentGateway/EnzonaRedirectCheckout`, extends
  `OffsitePaymentGatewayBase`) — the credentials/config form, the EnZona REST API
  methods (`authenticate`, `createPayment`, `getPaymentDetails`, `completePayment`,
  `cancelPayment`), and the `onReturn()` reconciliation.
- **Offsite plugin form** `EnzonaRedirectCheckoutForm`
  (`PluginForm/EnzonaRedirectCheckoutForm`) — on the checkout payment step it calls
  `createPayment()`, saves the returned `transaction_uuid` as the payment
  `remote_id`, and auto-submits a redirect form to EnZona's checkout URL.
- **Controller + routes** `EnzonaPaymentController`
  (`Controller/EnzonaPaymentController`) — `return`, `cancel`, `webhook`, plus
  three `debug`/`test` endpoints (`commerce_enzona.routing.yml`).
- **Theme hook** `commerce_enzona_payment_form` (template
  `commerce-enzona-payment-form`; note the template file is not shipped in 2.0.4),
  **library** `commerce_enzona/payment_form` (`js/enzona_payment.js`,
  `css/enzona_payment.css`), **`hook_help`**, **`hook_requirements`**.
- **Config schema** for the gateway plugin settings
  (`commerce_payment.commerce_payment_gateway.plugin.enzona_redirect_checkout`).
- **Legacy Drush 8 commands** (`commerce_enzona.drush.inc`): `enzona-test`
  (`e-test`), `enzona-payment-status <uuid>` (`e-status`) — declared with the
  deprecated `hook_drush_command()`, which does not register on Drush 12+.
- **No** `.permissions.yml`, **no** `hook_install`/`hook_update`, **no** entity
  types or services of its own.

## Solution docs

- **Gateway plugin: config fields, OAuth2 + EnZona API methods, `onReturn` flow,
  offsite redirect form** → [gateway/payment-gateway.md](gateway/payment-gateway.md)
- **Routes and controller actions (return / cancel / webhook / debug), Drush
  commands** → [routes/controller.md](routes/controller.md)
