<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Affirm (commerce_affirm) — agent index

Integrates **Affirm point-of-sale consumer financing (buy-now-pay-later)** into Drupal Commerce as an
**offsite payment gateway**, plus promotional-messaging blocks/formatters that advertise the monthly
payment plan across the site. Package `Commerce (contrib)`. Core `^9.3 || ^10 || ^11`. License
GPL-2.0-or-later. Installed version **2.6.0** (version dir `2.6.x`).

## Dependencies

- Drupal module: **`commerce:commerce_payment`** (from `.info.yml`) — pulls in the Commerce order/payment
  stack. No PHP-library requirements in `composer.json` beyond that.
- Loads Affirm's hosted **`affirm.js`** in the browser (from `cdn1.affirm.com` / `.ca`, sandbox variants
  for test mode) to open the checkout modal and render messaging widgets.

## What it provides (from source)

- **Payment gateway plugin** `affirm_redirect` (`Plugin/Commerce/PaymentGateway/Redirect.php`,
  extends `OffsitePaymentGatewayBase`; implements Refunds, Voids, Authorizations). Config form for keys,
  window mode (modal vs redirect), locale, country, logo/label, checkout instructions, debug logging.
  Offsite form `PluginForm/RedirectForm`. → [payment-gateway.md](payment-gateway.md)
- **Site settings form** `commerce_affirm.settings` at `/admin/commerce/config/affirm`
  (`Form/Settings`, route `commerce_affirm.routing.yml`, requires `access commerce administration pages`):
  enhanced analytics, add-to-cart messaging, remote-ID dashboard links. → [messaging.md](messaging.md)
- **Promotional messaging surface** — Block `commerce_affirm_banner_block` (`Plugin/Block/Banner`),
  Block `commerce_affirm_site_modal_block` (`Plugin/Block/SiteModal`), field formatter
  `commerce_affirm_messaging` for `commerce_price` fields (`Plugin/Field/FieldFormatter/AffirmFormatter`),
  Views area handler `commerce_affirm_monthly_payment_messaging`
  (`Plugin/views/area/MonthlyPaymentMessaging`), three theme hooks + templates, and add-to-cart /
  page-attachment injections in `commerce_affirm.module`. → [messaging.md](messaging.md)
- **Checkout pane** `affirm_checkout_completion_analytics` (`Plugin/Commerce/CheckoutPane/…`) — fires
  Affirm's `trackOrderConfirmed` analytics on the completion step. → [messaging.md](messaging.md)
- **Events + order subscriber** — `AffirmEvents` (`AFFIRM_TRANSACTION_DATA_PRESEND`, `AFFIRM_LOCALE`),
  event classes `AffirmTransactionDataPreSend` / `AffirmLocaleEvent`, and `EventSubscriber/OrderSubscriber`
  (calls `updatePayment()` after the order is placed). → [events.md](events.md)
- **Config schema** for the settings config and the gateway plugin config
  (`config/schema/commerce_affirm.schema.yml`). **No** permissions file, **no** install/update hooks,
  **no** Drush commands.

## Payment flow in one line

Server builds the Affirm checkout object from the order (server-side totals) → browser's `affirm.js`
opens the modal / redirects → on return the gateway sends the returned `checkout_token` to Affirm's
authenticated API (`authorization` request, HTTP Basic auth with the public + private key over HTTPS)
and only creates the Commerce payment when Affirm confirms the charge — it does not treat a client-side
"success" as payment. See [payment-gateway.md](payment-gateway.md).

## Solution docs

- **Gateway plugin: config, checkout-object build, onReturn/authorize, capture/void/refund/update, API
  client, modal vs redirect** → [payment-gateway.md](payment-gateway.md)
- **Site settings form, promotional blocks/formatter/Views area, analytics pane, theme hooks/templates**
  → [messaging.md](messaging.md)
- **Events (transaction-data-presend, locale) and the order subscriber** → [events.md](events.md)
