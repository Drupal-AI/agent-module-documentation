<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Saferpay PaymentPage gateway plugin

Class `Drupal\commerce_saferpay\Plugin\Commerce\PaymentGateway\Saferpay`
(`src/Plugin/Commerce/PaymentGateway/Saferpay.php`). Plugin id `saferpay_paymentpage`, label
"Saferpay PaymentPage", offsite form `SaferpayPaymentPageForm`, payment method type `credit_card`.
Extends `OffsitePaymentGatewayBase`; implements `SupportsAuthorizationsInterface`,
`SupportsRefundsInterface`.

## Constants

- `API_VERSION = '1.40'` (sent as `RequestHeader.SpecVersion`).
- `API_URL_PROD = https://www.saferpay.com/api`, `API_URL_TEST = https://test.saferpay.com/api`
  (chosen by `configuration['mode'] === 'live'` in `doRequest()`).
- Saferpay transaction statuses: `AUTHORIZED`, `CAPTURED`, `CANCELED`, `PENDING`.

## Configuration keys

Set in `defaultConfiguration()` / `buildConfigurationForm()` / `submitConfigurationForm()`; schema in
`config/schema/commerce_saferpay.schema.yml`. Stored on the
`commerce_payment.commerce_payment_gateway.<id>` config entity.

| Key | Type | Notes |
|-----|------|-------|
| `customer_id` | string, required | Saferpay Customer ID (Settings > Terminals). |
| `terminal_id` | string, required | Terminal / contract number. |
| `username` | string, required | JSON API basic-auth username. |
| `password` | string, required | JSON API basic-auth password. Plain textfield in the form. |
| `payment_methods` | array | Allowed Saferpay methods (checkboxes from `getSaferpayPaymentMethods()`); empty = all. |
| `order_identifier` | string, required | `OrderId` sent to Saferpay; supports `commerce_order` tokens; falls back to `$order->id()` when empty. |
| `order_description` | string, required | Description shown on the payment page; supports tokens. |
| `autocomplete` | bool (default TRUE) | Auto-capture an AUTHORIZED transaction. |
| `auto_capture_refunds` | bool (default TRUE) | Auto-assert (capture) the refund transaction. |
| `request_alias` | bool (default FALSE) | Adds `RegisterAlias.IdGenerator=RANDOM`; exposes an alias to hook code only (no reusable payment method yet). |
| `debug` | bool (default FALSE) | Verbose `info` logging to the `commerce_saferpay` channel. |
| `webhook_wait` | int (default 0) | `sleep()` seconds at the start of `onNotify()` to let the return path win the race. Blocking. |

Plus inherited `mode` (`test`/`live`) and `display_label` from Commerce.

## Checkout / assertion flow

1. **Offsite form** (`SaferpayPaymentPageForm::buildConfigurationForm`): rejects an already-paid
   order (`$order->isPaid()` → `UnexpectedValueException`), calls `paymentPageInitialize($payment,
   $return_urls)`, stores the returned `Token` via `$order->setData('commerce_saferpay', ['token' =>
   …])->save()`, and builds a `REDIRECT_GET` auto-submit form to `$saferpay_response->RedirectUrl`.
2. **`paymentPageInitialize()`** POSTs `/Payment/v1/PaymentPage/Initialize` with `TerminalId`,
   `Payment.Amount` (minor units via `minorUnitsConverter`, order total price), `OrderId`,
   `Description`, `ReturnUrl.Url` (Commerce return url), and `Notification.SuccessNotifyUrl` /
   `FailNotifyUrl` pointing at `commerce_payment.notify` with `?order=<order uuid>`. Optionally adds
   `RegisterAlias`, `Payer.LanguageCode` (if the current langcode is in `getSaferpayLanguages()`),
   and `PaymentMethods`. Fires `hook_commerce_saferpay_payment_page_data_alter`.
3. **`onReturn(OrderInterface $order, Request $request)`**: reloads the order with
   `loadForUpdate()` when available, then `processPayment($order)`. A `SaferpayException` whose
   `getErrorName()` is `TRANSACTION_ABORTED` redirects to `commerce_payment.checkout.cancel`; any
   other exception is rethrown.
4. **`onNotify(Request $request)`**: optional `sleep(webhook_wait)`; requires `?order=<uuid>`,
   loads the order by `uuid` query (accessCheck FALSE), then `processPayment($order)`. Returns
   `Response('OK', 200)`; returns 400 on missing/invalid order or processing error. `TRANSACTION_ABORTED`
   is ignored; other `SaferpayException`s are logged as NOTICE.
5. **`processPayment(OrderInterface $order)`** (shared by return + notify): skips if a payment for
   this gateway+order already exists (logs "already paid", returns FALSE). Calls
   `paymentPageAssert($order)` — POST `/Payment/v1/PaymentPage/Assert` with the **order-stored
   `Token`** (`$order->getData('commerce_saferpay')['token']`), i.e. the transaction is fetched
   server-to-server from Saferpay's authenticated API, not read from request parameters. Maps
   `Transaction.Status` → Commerce state via `mapTransactionStatusToPaymentState()`
   (AUTHORIZED→authorization, CAPTURED→completed, PENDING→pending, CANCELED→canceled, else failed).
   Creates a `commerce_payment` with `amount = $order->getTotalPrice()`,
   `remote_id = Transaction.Id`, `remote_state = Transaction.Status`. For AUTHORIZED it optionally
   captures (`autocomplete`); for CAPTURED it sets state `completed` and fires
   `hook_commerce_saferpay_assert_result`.

## Capture / void / refund

- `capturePayment()` — asserts `authorization` state; `transactionCapture()` →
  `/Payment/v1/Transaction/Capture`; requires result `Status == CAPTURED` before completing.
- `voidPayment()` — `transactionCancel()` → `/Payment/v1/Transaction/Cancel`; sets `canceled`.
- `refundPayment()` — asserts `completed`/`partially_refunded`; `transactionRefund()` →
  `/Payment/v1/Transaction/Refund`; when `auto_capture_refunds`, immediately captures the refund
  transaction (request id = `md5(order-uuid_transactionId)` to keep it short). Sets `refunded` or
  `partially_refunded`.

## API client — `doRequest($url, $request_id, $data)`

Guzzle `http_client->post()` to prod/test base + path. Sends JSON, adds
`RequestHeader{SpecVersion, CustomerId, RequestId, RetryIndicator:0}`, authenticates with Guzzle
`auth => [username, password]` (HTTP Basic; **default TLS verification** — no `verify => false`).
On a `ClientException` with HTTP **402** it decodes the body and throws `SaferpayException`
(carries the Saferpay `ErrorName`); other exceptions become `PaymentGatewayException`.
