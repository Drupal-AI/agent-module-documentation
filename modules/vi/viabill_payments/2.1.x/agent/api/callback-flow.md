<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Payment flow: checkout redirect, notify callback, and the ViaBill API client

## 1. Off-site checkout request

`src/PluginForm/ViaBillPaymentsForm.php` (`ViaBillPaymentsForm::buildConfigurationForm()`), the
`offsite-payment` form:

1. Loads the payment/order; requires `api_key` + `api_secret` in the gateway config
   (throws `PaymentGatewayException` otherwise).
2. Builds a transaction id `vb-<orderId>-<random10>` (`ViaBillHelper::formatTransactionId()`,
   `random_int`-based) and formats the order total (`formatAmount()` → 2-decimal string).
3. Builds absolute HTTPS return URLs: `success_url` = `commerce_payment.checkout.return`,
   `cancel_url` = `commerce_payment.checkout.cancel`, `callback_url` = `viabill_payments.callback`.
4. Computes `sha256check = hash('sha256', apikey#amount#currency#transaction#orderId#success_url#cancel_url#secret[#'true' if test])`.
5. Stores the transaction id on the order (`order->setData('viabill_transaction_id', …)`), moves the
   order to `pending`, saves.
6. `ViaBillGateway::checkout($request_data)` POSTs to `/api/checkout-authorize/addon/drupal`
   **without following redirects** and reads the `Location` header (301/302) as the ViaBill payment
   URL.
7. `buildRedirectForm()` returns a `REDIRECT_GET` form that sets `window.location.href` to that URL
   (plus a manual fallback link).

`buildCustomerData()` / `buildCartData()` assemble customer/cart arrays, but the `customParams`/
`cartParams` payload keys are currently commented out in the request.

## 2. The notify callback

Route `viabill_payments.callback` = **`POST /payment/viabill/callback`**, `_access: 'TRUE'`
(publicly reachable, as a server-to-server webhook must be). Handler
`ViaBillController::callback()` (`src/Controller/ViaBillController.php`):

1. Requires `Content-Type: application/json`; `json_decode`s the body.
2. Reads `transaction`, `orderNumber`, `status`, `amount`, `currency`; **400** if `transaction`,
   `status`, `amount` or `currency` is missing.
3. `ViaBillGateway::verifyCallbackSignature($data)` — **400** on failure (see §4).
4. `findOrder($transaction_id, $order_id)`: load by `orderNumber` first; else
   `findOrderByTransactionId()` queries `commerce_order` where `data.viabill_transaction_id ==`
   the id (`accessCheck(FALSE)`), else a `commerce_payment` by `remote_id`. **404** if none.
5. `loadPaymentGateway($order)` from the order's `payment_gateway` field.
6. Dispatch on `status`:
   - `APPROVED` → `processApprovedPayment()`: if `transaction_type == authorize_capture` it calls
     `captureTransaction()` (state `completed` on success, else `authorization`); otherwise state
     `authorization`. Creates a `commerce_payment` with `amount = new Price($amount,$currency)`,
     `remote_id = transaction`, on `order_id`.
   - `CANCELLED` / `REJECTED` → `processFailedPayment()`: transitions the order to `canceled` if not
     already final (`updateOrderState()` picks a valid transition).
   - anything else → **400** "Unknown status".
7. Returns `Response("OK", 200)`; exceptions are logged and return **500**.

`onReturn()`/`onCancel()` on the gateway plugin only handle the browser coming back — order
completion is driven by this callback.

## 3. The ViaBill API client

- `src/Helper/ViaBillOutgoingRequests.php` — static Guzzle wrapper over `\Drupal::httpClient()`.
  `request()` (GET query / POST form_params) and `requestWithoutRedirect()` (POST,
  `allow_redirects => FALSE`, used for checkout). TLS verification is left at Guzzle's secure default
  (no `verify => false`). Errors are caught and logged; returns `FALSE` on failure.
- `src/Helper/ViaBillServices.php` — the endpoint catalog `API_END_POINTS`: `checkout`
  (`/api/checkout-authorize/addon/drupal`), `capture_transaction` (`/api/transaction/capture`),
  `cancel_transaction` (`/cancel`), `refund_transaction` (`/refund`), `renew_transaction`,
  `transaction_status`, `myviabill`, `notifications`. Each defines required/optional fields, a
  signature format, and status-code message keys. `ADDON_NAME` = `drupal`
  (`ViaBillConstants::AFFILIATE`). `getApiEndPoint()` `exit()`s on an unknown (hardcoded) endpoint
  name.
- `src/Helper/ViaBillGateway.php` — `ViaBillGateway`:
  - Constructor reads mode/key/secret from `ViaBillHelper` (which loads the gateway entity by id
    `viabill_payments`). `API_PROTOCOL = '3.1'`.
  - `checkout()`, `captureTransaction()`, `refundTransaction()`, `cancelTransaction()`,
    `myViabill()`, `notifications()` all go through `getRequestData()` → `getEndPointData()`, which
    fills required fields, computes any `signature`/`sha256check` field via `parseFormat()` +
    `hash('sha256', …)`, and calls `ViaBillOutgoingRequests`.
  - `parseFormat($format, $data)` substitutes `{field}` tokens from `$data`, and the special tokens
    `{secret}`→apiSecret, `{key}|{apikey}|{apiKey}`→apiKey, `{protocol}`, `{test}`; throws if a
    referenced field is absent.
  - `checkResponseStatus()` treats HTTP 2xx as success for transaction calls.

## 4. Callback signature verification

`ViaBillGateway::verifyCallbackSignature(array $data, string $format = '', bool $silent = TRUE)`:

- Default format `{transaction}#{orderNumber}#{amount}#{currency}#{status}#{time}#{secret}`.
- Requires a `signature` key in `$data` (throws otherwise); removes it, runs `parseFormat()` over
  the rest (so `{secret}` is filled from the stored account secret and `{time}` must be present in
  the payload), computes `hash('sha256', …)` and returns whether it equals the supplied signature.
- With `$silent = TRUE` (as the controller calls it) a mismatch returns `FALSE` → the controller
  answers 400 and no payment is created.

So an `APPROVED` callback is only turned into a completed/authorized payment when its SHA-256
signature — computed over the transaction fields plus the shared account secret — matches. The
amount and order number used for the created payment are the (signature-covered) values from the
request.
