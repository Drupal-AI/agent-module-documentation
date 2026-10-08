<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Embedded checkout flow, acknowledge, capture / void / refund

Method references are in `src/Plugin/Commerce/PaymentGateway/QliroCheckout.php`,
`src/QliroManager.php`, and `src/PluginForm/OffsiteRedirect/QliroCheckoutForm.php` unless noted.
The SDK is `iqv/qliro_php_sdk` (`Qliro\MerchantApi\Order`, `Qliro\AdminApi\Order`,
`Qliro\Transport\GuzzleConnector`).

## 1. Show the embedded checkout (createOrder / updateOrder)

`QliroCheckoutForm::buildConfigurationForm()` runs during the offsite-payment step. It does **not**
redirect the browser — Qliro Checkout is embedded:

- Builds `merchant_urls` = { checkout (cancel), return, notify = `getNotifyUrl()` }.
- If the order already has `data['qliro_order_id']`, `QliroManager::updateOrder()`; on SDK
  `ConnectorException` with `ORDER_EXPIRED` (Qliro orders expire after ~2 days) it re-generates the
  order number and creates a fresh Qliro order; other exceptions fall back to create.
- Otherwise `QliroManager::createOrder()`: assigns the Commerce order number (via the order type's
  number pattern) as `MerchantReference`, POSTs the order to the Merchant API, stores
  `data['qliro_order_id']` on the order.
- Renders `Markup::create($qliro_order['OrderHtmlSnippet'])` — the checkout markup comes straight
  from the authenticated Merchant API response, not from request data.
- The `commerce_qliro_checkout_confirmation` checkout pane renders the post-purchase
  `OrderHtmlSnippet` from `QliroManager::getOrder()` on the `complete` step.

The outbound payload is built by `OrderRequestBuilder` (order items with SKU reference,
quantity, inc/ex-VAT unit price, `VatRate` from included tax adjustments, shipping lines when
`commerce_shipping` is present) and can be altered via the `create_order_request` /
`update_order_request` events (`OrderRequestEvent::setRequestData()`).

## 2. Acknowledge — server-authoritative on amount

Two entry points call the protected `QliroCheckout::acknowledgeOrder()`:

- **`onNotify(Request $request)`** — Qliro's checkout-status push (`commerce_payment` notify URL).
  Decodes the JSON body; acts only when `NotificationType == 'CustomerCheckoutStatus'` and
  `Status == 'Completed'`, then acknowledges by the pushed `OrderId` and returns
  `{"CallbackResponse":"received"}`. Exceptions are logged and `NULL` is returned.
- **`onReturn(OrderInterface $order, Request $request)`** — browser return. Uses the
  `qliro_order_id` already stored on the (access-controlled) order; throws if absent.

`QliroManager::acknowledgeOrder($qliro_order_id, $order = NULL)`:
1. `loadOrder($qliro_order_id)` → `Qliro\MerchantApi\Order::getOrder()` — **re-fetches the order
   from Qliro's authenticated API** (HTTPS, MAC-authenticated). The returned array is the source of
   truth for the rest of the flow.
2. When no `$order` was passed (push path), loads the Commerce order by the fetched
   `MerchantReference` (order number) and takes it `loadForUpdate()`.
3. Dispatches `acknowledge_order` (`QliroEventSubscriber` copies Qliro `BillingAddress` /
   `ShippingAddress` onto the order profiles when the corresponding config option is on), sets the
   customer email from the fetched order, and saves.

Back in `QliroCheckout::acknowledgeOrder()`, the Commerce payment is created from the **fetched**
order data:
`Price($qliro_order['TotalPrice'], $qliro_order['Currency'])`, `state = authorization`,
`remote_id = OrderItems[0]['PaymentTransactionId']`, `remote_state = CustomerCheckoutStatus`.
Idempotency: if a payment already exists for that `PaymentTransactionId` (`loadByRemoteId`), it
returns without creating a duplicate. If `capture` is enabled, it immediately calls
`capturePayment()`.

## 3. Capture

`capturePayment()` asserts `authorization` state and calls `QliroManager::createCapture()` →
`Qliro\AdminApi\Order::markItemsAsShipped()` with capture lines from
`OrderRequestBuilder::buildCapture()` (uses the payment's Qliro `PaymentTransactionId`). On
success the payment moves to `completed` and its `remote_id` is updated to the returned
`PaymentTransactionId`. Fires `payment_capture_request`. Triggered automatically when
`capture = TRUE`, or manually via the `capture-payment` form (`PaymentCaptureForm`).

## 4. Void (cancel)

`voidPayment()` asserts `authorization` and calls `cancelOrder()` →
`QliroManager::cancelOrder()` → `Qliro\AdminApi\Order::cancelOrder()`; then voids all of the
order's payments. Also invoked automatically by `OrderSubscriber` on the Commerce
`cancel` transition (`commerce_order.cancel.post_transition`) for Qliro-paid orders. Form:
`void-payment` (`PaymentVoidForm`).

## 5. Refund

`refundPayment()` asserts `completed` / `partially_refunded`, defaults to the full payment amount,
validates the refund amount, then `QliroManager::createRefund()` →
`Qliro\AdminApi\Order::returnItems()` with lines from `OrderRequestBuilder::buildRefund()`. Sets
local state to `partially_refunded` or `refunded` and accumulates the refunded amount. Fires
`payment_refund_request`.

## Transport / auth (SDK)

`QliroManagerFactory` builds one `GuzzleConnector($api_key, $api_secret, $mode === 'test')` per
API key. Hosts are fixed constants (`https://payments.qit.nu/` live, `https://pago.qit.nu/`
test) — HTTPS with Guzzle's default certificate verification (no `verify => false`). Every request
body gets `MerchantApiKey` appended and an `Authorization: Qliro <token>` header where
`token = base64(sha256(body + api_secret))`, so the re-fetch in step 2 is authenticated and the
`OrderId` acts purely as a lookup key scoped to the merchant's account.
