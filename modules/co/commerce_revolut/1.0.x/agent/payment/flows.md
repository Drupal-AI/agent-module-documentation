<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Order lifecycle, payments, capture / void / refund

All methods are in `src/Plugin/Commerce/PaymentGateway/RevolutTrait.php` unless
noted. The trait backs all three gateways; the offsite-only `onReturn`/`onNotify`
live in `RevolutPaymentLink`.

## Revolut order id storage (binding)

The Revolut order id is **not** persisted on the Commerce order; it is kept in a
key-value-expirable store, keyed by the local order id:
`setRevolutOrderId($order, $id)` / `getRevolutOrderId($order)` on the
`commerce_revolut` collection (TTL `REVOLUT_KEY_VALUE_EXPIRATION` = 6048000s). All
later lookups (`getRevolutOrder`, capture/void/refund, onReturn) resolve the Revolut
order for **this** local order through this store — no Revolut id is read from the
browser/request.

## The REST client — `request()`

`request($endpoint, $method = 'GET', $payload = [])`:
- URL `<sandbox|production base>/api/<endpoint>`; headers `Authorization: Bearer
  <secret_key>`, `Revolut-Api-Version: 2024-09-01`, `Content-Type: application/json`,
  a `User-Agent` naming Commerce Core + PHP version. JSON body when a payload is given.
- Uses `http_client` (Guzzle) with default TLS verification (no `verify` override).
- On any exception: logs `$exception->getMessage()`, decodes the response body and
  throws `RevolutException($message, $code, $data)` (carries Revolut `code`/`message`).
- When `logging` is on, request and response bodies are written to the
  `commerce_revolut` logger channel.

## Building the order payload — `buildOrderPayload()`

Server-side from order data: `amount` = `minorUnitsConverter->toMinorUnits(
$order->getTotalPrice())`, `currency`, `merchant_order_data.reference = $order->id()`,
customer id/email, and a `line_items[]` array (name, physical/service type,
quantity, unit/total minor-unit amounts, `external_id`, plus promotion/bundle
`discounts[]` and `tax` `taxes[]`). `capture_mode` (`automatic`/`manual`) is derived
from the checkout flow's `payment_process.capture` pane setting. The finished payload
is dispatched through `RevolutOrderEvent` (`revolut_order_payload`) so other modules
can alter it before send. See [../api/events.md](../api/events.md).

## Create / update the Revolut order

- `putRevolutOrder($order)` — creates the order if none is stored, else GETs it and,
  **only while its state is `pending`**, PATCHes it with the current payload. Wraps
  `RevolutException` into a `PaymentGatewayException`.
- `createRevolutOrder($order, $data = [])` → `POST /orders`; stores the returned id.
- `updateRevolutOrder($order, $data = [])` → `PATCH /orders/{id}`.
- `getRevolutOrder($id)` → `GET /orders/{id}`.

## Onsite payment — `createPayment()`

(`revolut_checkout` / `revolut_pay`.) Asserts payment state `new`; for a reusable
stored method it first `payForRevolutOrder($order)` (charges the saved method via
`POST /orders/{id}/payments`). It then re-fetches the Revolut order
(`getRevolutOrder(getRevolutOrderId($order))`), maps its `state` via
`REVOLUT_ORDER_STATES_MAPPED` (pending/processing/authorised → `authorization`,
completed → `completed`, cancelled/failed → `authorization_voided`), sets
`remote_id = $revolut_order['id']`, and saves. For a non-reusable method it then
`updatePaymentMethod()` to copy card brand/last4/expiry (and, for the `revolut`
method type, the `revolut_payment_type`) onto the payment method, marking it reusable
only when Revolut returned a stored payment-method id.

`createPaymentMethod()` requires `payment_details['revolut_payment_method_id']`
(the Revolut order id the JS placed in the hidden field), fetches that order, and
populates the method via `updatePaymentMethod()`.

## Offsite flow — `RevolutPaymentLink`

- `PaymentOffsiteForm::buildConfigurationForm()` calls
  `createRevolutOrder($order, ['capture' => automatic|manual, 'redirect_url' =>
  $return_url])` and `buildRedirectForm(... $revolut_order['checkout_url'], 'get')`
  to send the shopper to Revolut's hosted page.
- `onReturn(OrderInterface $order, Request $request)` — re-fetches the Revolut order
  by the stored id, requires a `payments[]` entry (else `PaymentGatewayException 'No
  payment found.'`), raises a payment failure for `pending`/`processing`, then creates
  a `commerce_payment` with state `completed` when the Revolut state is `completed`
  (otherwise `pending`), `amount` = `$order->getBalance()`, `remote_id` /
  `remote_state` from the fetched order. State comes from the authenticated API fetch,
  not from any redirect parameter.
- `onNotify(Request $request)` — no-op ("Nothing for now.").

## Capture / void / refund (onsite gateways)

`SupportsAuthorizationsInterface` + `SupportsRefundsInterface`, driven from the order
management UI:
- `capturePayment($payment, $amount = NULL)` — asserts `authorization`; `POST
  /orders/{remoteId}/capture` with the minor-unit amount (full amount if omitted).
- `voidPayment($payment)` — asserts `authorization`; `POST /orders/{remoteId}/cancel`.
- `refundPayment($payment, $amount = NULL)` — asserts `completed` /
  `partially_refunded`, validates the refund amount, `PATCH
  /orders/{remoteId}/refund` with amount + currency.
- `payForRevolutOrder($order, $initiator = 'merchant')` — charges a saved method:
  `POST /orders/{id}/payments` with `saved_payment_method` {id, type (`card` or, for
  a `revolut_pay` account/card, `revolut_pay`), initiator}.

Each wraps `RevolutException` into `PaymentGatewayException::createForPayment()`.

## Errors

`RevolutException` exposes `getRevolutCode()`, `getRevolutMessage()`,
`getRevolutError()`, `getTimestamp()` from the decoded Revolut error body, used to
surface a meaningful message to the shopper/operator.
