<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Qliro Checkout (commerce_qliro_checkout) — agent index

A **Drupal Commerce off-site payment gateway for Qliro One / Qliro Checkout** — the
Nordic hosted-checkout provider (invoice, instalments, card). At checkout the shopper is
shown Qliro's **embedded checkout HTML snippet** (fetched from Qliro's authenticated
Merchant API and rendered in-page), pays at Qliro, and the module confirms the outcome by
**re-fetching the order from Qliro's authenticated API** — the checkout-status push and the
browser return are used only as triggers, and the payment amount + currency are read from the
authenticated Qliro order, not from the callback body. Package `Commerce (contrib)`. Core
`^10 || ^11`. License GPL-2.0-or-later. Installed version **1.0.3** (version dir `1.0.x`).

## Dependencies

- Drupal module: **`commerce:commerce_payment`** (required, from `.info.yml`).
- PHP libraries (`composer.json`): **`iqv/qliro_php_sdk` `^1.0`** (the Qliro PHP SDK,
  namespace `Qliro\…`) and **`drupal/commerce` `^2.37 || ^3`**.
- Optional: `commerce_shipping` (a "Update shipping profile" config option and shipping order
  lines only appear when it is installed).

## What it provides (from source)

- **One payment gateway plugin** `qliro_checkout` —
  `src/Plugin/Commerce/PaymentGateway/QliroCheckout.php` (`#[CommercePaymentGateway]`, extends
  `OffsitePaymentGatewayBase`, `requires_billing_information: FALSE`). Forms: `offsite-payment`
  → `QliroCheckoutForm`, `capture-payment` → `PaymentCaptureForm`, `void-payment` →
  `PaymentVoidForm`.
- **Offsite form** `src/PluginForm/OffsiteRedirect/QliroCheckoutForm.php` — creates/updates the
  Qliro order via the Merchant API and renders `OrderHtmlSnippet` in-page (the shopper is *not*
  redirected away; Qliro's checkout is embedded). Stores the returned Qliro order id on the
  Commerce order as `data['qliro_order_id']`.
- **Confirmation checkout pane** `commerce_qliro_checkout_confirmation`
  (`src/Plugin/Commerce/CheckoutPane/QliroCheckoutConfirmation.php`) — renders Qliro's
  post-purchase `OrderHtmlSnippet` on the `complete` step.
- **Notification controller** `src/Controller/NotificationController.php` + `*.routing.yml` — one
  route `commerce_qliro_checkout.validate` (`/commerce_qliro_checkout/validate/{commerce_payment_gateway}`,
  POST). Its handler `onValidation()` is a documented **no-op stub** in this release (returns HTTP
  200); the merchant order-validation and available-shipping-methods callbacks are not wired up
  (`MerchantOrderValidationUrl` is commented out in the order request).
- **Qliro manager** `src/QliroManager.php` (+ interface, + `QliroManagerFactory`) — wraps the
  SDK: `createOrder`/`updateOrder`/`getOrder`/`loadOrder` (Merchant API) and
  `createCapture`/`createRefund`/`cancelOrder` (Admin API). The factory
  `commerce_qliro_checkout.manager_factory` builds a `Qliro\Transport\GuzzleConnector` from the
  gateway `api_key`/`api_secret`/`mode`.
- **Order request builder** `src/Builder/OrderRequestBuilder.php` — converts the Commerce order
  into Qliro `OrderItems`/`Shipments`/`Returns` payloads (create, capture, refund, cancel),
  including tax/VAT and shipping lines.
- **Event subscribers** — `OrderSubscriber` cancels the Qliro order on
  `commerce_order.cancel.post_transition`; `QliroEventSubscriber` copies Qliro
  billing/shipping address data onto the order's profiles on acknowledge.
- **Dispatched events** (`src/Event/QliroCheckoutEvents.php`, payload `OrderRequestEvent` or
  `QliroOrderEvent`): `create_order_request`, `update_order_request`, `payment_capture_request`,
  `payment_refund_request`, `acknowledge_order`, `order_validation`,
  `update_authorization_request` — let other modules alter the outbound Qliro payload or react to
  acknowledgement.
- **Config schema** `config/schema/commerce_qliro_checkout.schema.yml` for the gateway plugin.
  No `.install`, no `.permissions.yml` (the module defines no permissions of its own; the notify
  route is the standard Commerce IPN route), no templates, no JS of its own.

## Verification posture (payment gateway)

Server-authoritative on amount. `onNotify()` (Qliro's `CustomerCheckoutStatus` = `Completed`
checkout-status push, at the standard `commerce_payment` notify URL) and
`onReturn()` (browser return) both call `acknowledgeOrder()`, which **re-fetches the order from
Qliro's authenticated Merchant API** (`Qliro\MerchantApi\Order::getOrder`) using the stored
`qliro_order_id` / the pushed `OrderId`. The Commerce payment is created with
`amount = Price(qliro_order['TotalPrice'], qliro_order['Currency'])` — taken from the
authenticated Qliro order, never from the request. Duplicate notifications are ignored: if a
payment already exists for the returned `PaymentTransactionId` (`loadByRemoteId`), acknowledge
returns early (idempotent). All SDK calls go over HTTPS to fixed Qliro hosts (Guzzle default TLS
verification; no `verify => false`); every request is authenticated with a SHA-256 MAC of
`body + api_secret`. See [payment/verification-flow.md](payment/verification-flow.md).

## Solution docs

- **Gateway config form, options, credentials, mode, config schema** →
  [config/gateway-settings.md](config/gateway-settings.md)
- **Embedded-checkout flow, create/update order, onNotify/onReturn acknowledge, capture / void /
  refund, events** → [payment/verification-flow.md](payment/verification-flow.md)
