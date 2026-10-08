<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Synpay (synpay) — agent index

A Drupal Commerce off-site payment gateway that fronts ~18 Russian payment service providers (PSPs),
each implemented as a pluggable **Synpay** provider plugin. Package `Synapse`. Core
`^11 || ^12`. License GPL-2.0-or-later. Version 2.0.15 (doc dir `2.0.x`).

Requires Drupal **Commerce** at runtime (`commerce_payment`, `commerce_order`, `commerce_checkout`,
`commerce_price`, `commerce_product`) — note the `.info.yml` does **not** declare these
dependencies. Composer libraries: `firebase/php-jwt` (Yandex Pay JWS notifications),
`voronkovich/sberbank-acquiring-client` (Sber/Sgb/Alfa RBS APIs), `yoomoney/yookassa-sdk-php`
(YooKassa). Bundles Russian Trusted Root/Sub CA certs under `assets/certs/`.

## Solution docs
- **Providers: every PSP, its ids, credentials and receipt options, and how to add a new one** →
  [payment/gateways.md](payment/gateways.md)
- **The payment flow: checkout → PSP → notify/return routes and how order/payment state is set** →
  [payment/flow.md](payment/flow.md)
- **Install, settings form, per-order check/refund screens, permissions, hooks, block** →
  [config/settings.md](config/settings.md)

## What it provides (from source)
- **Commerce gateway plugin** `SynpayPaymentGateway` (id `synpay`, label *Synpay Gateway*),
  `src/Plugin/Commerce/PaymentGateway/SynpayPaymentGateway.php`, extends
  `OffsitePaymentGatewayBase`; `payment_method_types = {credit_card}`,
  `requires_billing_information = FALSE`. Its config adds one field: `gateway` (radios) that
  selects which **active** Synpay PSP provider this Commerce gateway uses.
- **Off-site plugin form** `OffsitePaymentForm` (`src/PluginForm/OffsiteRedirect/`) — registers the
  order with the selected PSP and builds the redirect (POST for Robokassa, GET otherwise).
- **Custom plugin type `Synpay`**: manager `SynpayGatewayManager` (service `plugin.manager.synpay`,
  discovery dir `Plugin/Synpay`, annotation `SynpayAnnotation` id/title, base `SynpayPluginBase`,
  interface `SynpayPluginInterface`). 18 provider plugins in `src/Plugin/Synpay/`.
- **Service** `synpay.gateway` = `GatewayService` (instantiates the selected provider and proxies
  `registerOrder` / `onReturn` / `onNotify` / `getPrecision` / `getSettingsForm`).
- **Controller** `PayController` (`src/Controller/PayController.php`) for the `synpay.*` routes.
- **Forms**: `Settings` (`synpay.settings`), `PaymentsCheckForm`, `PaymentsRefundForm`,
  `PayForm`, `BuyNowForm`.
- **Block** `ModalDolyame` (id `modal_mydolyame`) + template `block--modal-mydolyame.html.twig`;
  `hook_install()` places it in the active theme's bottom region.
- **Hooks** (`src/Hook/*`): checkout-form alter (test-card notice + Dolyame/Split widget markup),
  page-attachments alter (Yandex Split / Dolyame front-end libraries), `hook_theme`,
  `hook_preprocess_commerce_product`.
- **Permission**: `access synpay pay` (`synpay.permissions.yml`). No config schema, no Drush.

## Routes (`synpay.routing.yml`)
- `synpay.pay` `/synpay/pay/{plugin_name}/{order}/{total}` → `PayController::page` — perm `access synpay pay`.
- `synpay.test` `/synpay/test/{plugin_name}/{orderId}` → `PayController::test` — perm `access synpay pay`.
- `synpay.onsite` `/synpay/onsite/{plugin_name}/{paymentId}` → `PayController::onsite` — perm `access content` (CloudPayments widget).
- `synpay.callback` `/synpay/callback/{plugin_name}` → `PayController::callback` — perm `access content` (PSP result callback).
- `synpay.return` `/synpay/return/{plugin_name}` → `PayController::return` — perm `access content` (Robokassa customer return).
- `synpay.return_direct` `/synpay/return_direct/{plugin_name}` → `PayController::returnDirect` — perm `access content`.
- `synpay.settings` `/admin/config/synpay/settings` → `Settings` form — perm `access administration pages`.
- `synpay.payments_check` `/admin/commerce/orders/{commerce_order}/payments_check` → `PaymentsCheckForm` — perm `administer commerce_order`.
- `synpay.payments_refund` `/admin/commerce/orders/{commerce_order}/payments_refund` → `PaymentsRefundForm` — perm `administer commerce_order`.

Providers also use the Commerce notify route `/payment/notify/{commerce_payment_gateway}`
(`OffsitePaymentGatewayBase` → `SynpayPaymentGateway::onNotify` → the provider's `onNotify()`).
