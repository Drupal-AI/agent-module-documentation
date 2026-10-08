<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AlternativeCommerce PayPal Checkout (basket_paypal) — agent index

PayPal payment gateway for the **Basket** (AlternativeCommerce) store. Wraps PayPal's official
`paypal/paypal-server-sdk` PHP client (Orders API) plus the client-side PayPal JS SDK Smart
Buttons. Version 1.1.0, core `^10 || ^11`, PHP `^8.1`.

## Requirements
- Contrib **`basket`** module (the `Basket` service and `Drupal\basket\Entity` are used
  unconditionally — note `basket_paypal.info.yml` does NOT declare this dependency).
- Composer: `paypal/paypal-server-sdk:^0.6`.
- A PayPal REST app client ID + client secret (live and/or sandbox).

## What it provides
- **Payment plugins** (`@BasketPayment`): `basket_paypal` (redirect/approve via `PaymentForm`)
  and `basket_paypal_js` (in-page JS SDK Smart Buttons), in
  `src/Plugin/Basket/Payment/` — `BasketPaypalJsSDK` extends `BasketPaypal`.
- **Services**: `PayPal` (`src/PayPal.php` — payment-record CRUD on the `payments_basket_paypal`
  table + PayPal SDK client factory) and `PayPalJs` (`src/Services/PayPalJs.php` — server-side
  order creation, currency mapping).
- **Routes** (`basket_paypal.routing.yml`):
  - `basket_paypal.settings` → `/admin/config/development/basket_paypal` (`SettingsForm`, perm
    `access basket_paypal settings`) — credentials, sandbox toggle, success message, webhook URL.
  - `basket_paypal.settings.javascript_sdk` → `/admin/config/development/basket_paypal/javascript-sdk`
    (`JavascriptSDKSettingsForm`) — Smart-Button styling, enable/validate flags.
  - `basket_paypal.pages` → `/basket_paypal/{page_type}` (`Pages::pages`, perm `access content`) —
    `pay`, `result`, `cancel`, and `webhook` (PayPal event receiver).
  - `basket_paypal.api` → `/paypal-api/{page_type}` (`ApiPage::page`, perm `access content`) —
    `create` and `capture` for the JS SDK flow.
- **Table**: `payments_basket_paypal` (`basket_paypal.install`) — id, nid, sid, uid, created,
  paytime, amount, currency, status, data(JSON).
- **Config**: `basket_paypal.settings` (`config`: credentials + success text) and
  `basket_paypal.settings.js_sdk` (`config`: enable/validate/style). No config/schema shipped.
- **Permission**: `access basket_paypal settings` (`basket_paypal.permissions.yml`).
- **Hooks/theme**: `hook_page_attachments` injects the PayPal JS SDK script; alter hooks
  `basket_paypal_order_params` / `basket_paypal_payment_params`; themes
  `basket_paypal_buttons`, `basket_paypal_pages`; `hook_form_node_form_alter` on `basket_order`.

## Solution docs
- Config & credentials: [agent/config/settings.md](config/settings.md)
- Payment plugins & order flow: [agent/plugins/payment.md](plugins/payment.md)
- Routes, controllers & webhook: [agent/api/routes.md](api/routes.md)
