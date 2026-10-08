<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Sermepa / Redsýs (commerce_sermepa) — agent index

Off-site Drupal Commerce payment gateway for **Redsýs** (formerly Sermepa), the "TPV Virtual"
platform used by most Spanish banks. Customers are redirected (POST) to Redsýs to pay by card and
Redsýs posts an asynchronous notification back that creates the Commerce payment. The Redsýs
protocol (parameter encoding, signing, response verification) lives in the required PHP library
`commerceredsys/sermepa ^1.0.9`; this module is the thin Commerce integration layer.

- Depends on `commerce:commerce_payment` (Drupal Commerce). Composer requires
  `drupal/commerce ^2.0 || ^3.0` and `commerceredsys/sermepa ^1.0.9`.
- Core: `^10 || ^11`. `.info.yml` carries the legacy `version: '8.x-2.4'`.
- **No settings page / no routing file of its own.** It is a `@CommercePaymentGateway` plugin;
  configuration lives on the payment-gateway config entity, and the redirect/return/notify
  endpoints are provided by Commerce's own payment routing (`commerce_payment.notify`, etc.).
- No permissions, no Drush commands, no plugin types, no submodules. Ships config **schema**.
- Ships `ludwig.json` so the library can be installed without Composer.

What you'd do:
- **Configure the gateway (merchant code, terminal, secret key, environment, currency)** →
  [configure/gateway.md](configure/gateway.md)
- **Understand the redirect + notification (IPN) flow and how a payment is created** →
  [api/payment-flow.md](api/payment-flow.md)

Key facts (real machine names):
- Gateway plugin id: `commerce_sermepa` — class
  `Drupal\commerce_sermepa\Plugin\Commerce\PaymentGateway\Sermepa` (extends
  `OffsitePaymentGatewayBase`, implements `HasPaymentInstructionsInterface`).
- Off-site form: `Drupal\commerce_sermepa\PluginForm\OffsiteRedirect\SermepaForm` (declared as
  the `offsite-payment` form on the plugin).
- Config object: `commerce_payment.commerce_payment_gateway.plugin.commerce_sermepa`.
  Config keys: `merchant_name`, `merchant_code`, `merchant_group`, `merchant_password`,
  `merchant_terminal`, `merchant_paymethods` (sequence), `merchant_consumer_language`,
  `currency` (numeric ISO 4217, default `978` = EUR), `transaction_type` (default `0`),
  `instructions` (+ inherited `mode`, `display_label`, `collect_billing_information`).
- Logger channel: `commerce_sermepa`. Lock: `lock.persistent`, key
  `commerce_sermepa_process_request_<order-uuid>`.
- Library endpoints: test `https://sis-t.redsys.es:25443/sis/realizarPago`,
  live `https://sis.redsys.es/sis/realizarPago`. Signature version `HMAC_SHA256_V1`.
