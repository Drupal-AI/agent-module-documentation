<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# YooMoney / YooKassa (yookassa) — agent index

Drupal Commerce **off-site payment gateway** for the YooMoney/YooKassa platform. Project name
`yoomoney`; **module machine name `yookassa`** (namespace `Drupal\yookassa`). Version 1.2.1.
Package *YooMoney*. Core `^10 || ^11`, PHP 8.0+, cURL. License GPL-2.0-or-later.

Depends on **`commerce_payment`, `commerce_tax`, `commerce_cart`** (Commerce), optionally uses
`commerce_log`. Backed by the **`yoomoney/yookassa-sdk-php` ^3.14** SDK plus
`yoomoney/yookassa-sdk-validator`, loaded through **Ludwig** (`ludwig.json`,
`YooKassaLudwigRequireHelper::checkLudwigRequire()`); `yookassa_requirements()` in `yookassa.install`
hard-fails install if `\YooKassa\Client` / `\YooKassa\Validator\Validator` are missing.

## What it provides

- **Payment gateway plugin** `yookassa` — `src/Plugin/Commerce/PaymentGateway/YooKassa.php`,
  extends `OffsitePaymentGatewayBase`. Forms: `offsite-payment` → `PaymentOffsiteForm`. Payment
  method type: `yookassa_epl`. Implements `onReturn()` and `onNotify()`.
- **Payment method types** `src/Plugin/Commerce/PaymentMethodType/` — `YooKassaEPL` (id
  `yookassa_epl`) extends abstract `YooKassaPaymentMethod` (no bundle fields).
- **Off-site form** `PaymentOffsiteForm` — creates the YooKassa payment via the SDK and redirects
  to `confirmation.confirmationUrl`.
- **OAuth controller + routes** `YooKassaOauthController` — AJAX endpoints `/get_oauth_url`,
  `/get_oauth_token`, `/check_payment_method`, `/generate_notification_url`
  (`yookassa.routing.yml`), all gated `_permission: administer commerce_payment_gateway`.
- **Event subscriber** `YooKassaEventSubscriber` (service `yookassa.yoo_kassa_event_subscriber`) on
  `OrderEvents::ORDER_PRESAVE` — sends the 54-FZ "second receipt".
- **Order workflow** `yookassa_workflow` (`yookassa.workflows.yml`): draft→waiting→paid→completed
  / canceled.
- **Commerce log template** `order_sent_second_reciept` (`yookassa.commerce_log_templates.yml`).
- **Library** `yookassa/oauth` (`js/yookassa_oauth.js`) attached on gateway add/edit via
  `yookassa_preprocess_page()`. Logs to dblog channel **`yookassa`**.

No permissions of its own, no Drush, no config schema shipped, no `configure` route (configured as a
Commerce payment gateway). Payment gateway config is stored in the
`commerce_payment.commerce_payment_gateway.<id>` config entity.

## Solution docs

- Gateway plugin, checkout redirect, return & notification handling, capture →
  [plugins/payment-gateway.md](plugins/payment-gateway.md)
- OAuth connection flow, routes, webhook registration, SDK client →
  [api/oauth-and-notifications.md](api/oauth-and-notifications.md)
- Settings form fields, config keys, receipts/54-FZ, taxes →
  [config/settings.md](config/settings.md)
