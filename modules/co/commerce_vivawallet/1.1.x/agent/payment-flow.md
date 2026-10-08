<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Viva Wallet — payment flow (source-grounded)

All references are to `commerce_vivawallet` 1.1.1. Viva's REST API is called through
`src/Service/Http/ClientFactory.php`, which builds a per-host Guzzle client (default TLS
verification, `http_errors => FALSE`) with a middleware stack: logger → auth (Basic or Bearer)
→ header/status validator → JSON decoder.

## 0. Authentication (`AccountService`, Bearer middleware)

The `api_oauth` host (`api.vivapayments.com`) is Bearer-authenticated. `BearerAuthorization`
middleware calls `AccountService::getAccessToken()`, which `POST connect/token` to the `account`
host (`accounts.vivapayments.com`) with `grant_type=client_credentials` and Guzzle `auth =>
[client_id, client_secret]` (HTTP Basic). Tokens are cached in the `commerce_vivawallet`
expirable key-value store, keyed by `sha1(client_id ' ' client_secret ' ' mode)`, until
`expires_in`. The `api_basic` host (`www.vivapayments.com/api`) instead uses Basic
`merchant_id:api_key` via `BasicAuthorization` middleware.

## 1. Checkout redirect — `VivawalletOffsiteForm::buildConfigurationForm()`

`src/PluginForm/VivawalletOffsiteForm.php` (the `offsite-payment` form).

- If the payment has no `remote_id` yet: sets a default `expires` time (`now + 3600`), then
  calls `OrderService::createPayment($payment)` and stores the returned **Viva `orderCode`** as
  the payment `remote_id`, and saves the payment.
- Redirects (`buildRedirectForm`) to the Smart Checkout URL for the mode
  (`…/web/checkout`, overridable via `commerce_vivawallet_redirect_url_<mode>`) with query
  `ref = <orderCode>` and `color = <hex>`.

`OrderService::createPayment()` (`src/Service/OrderService.php`) does `POST checkout/v2/orders`
with a body built from the order:

- `amount` = `$payment->getAmount()->multiply(100)->getNumber()` (minor units).
- `customer` = email + billing given/family name + country code (+ a mapped `requestLang`).
- `paymentTimeOut` = seconds until the payment `expires` time (clamped 1..65535).
- `disableCash`/`disableWallet` = TRUE; `sourceCode` = the configured source code.
- `merchantTrns` = `"Order <order id> (<store name>)"`; `tags` = `['Drupal Commerce', <store>]`.
- Returns `response['orderCode']` (int) — the value stored as `remote_id`.

## 2. Customer return — `VivawalletController::success()` / `cancel()`

Routes `commerce_vivawallet.success` / `.cancel` (`…/{payment_gateway}/success|cancel`, GET,
`no_cache`). Access is gated by `VivawalletCallbackAccessCheck`:

1. Gateway plugin must be a `VivawalletPaymentGatewayInterface`.
2. Query must contain `t` and `s`.
3. `t` must be a valid **UUID** (Viva transactionId); `s` must be non-empty **digits** (Viva
   orderCode).
4. A local payment must exist for `(orderCode s, transactionId t)` via
   `PaymentManager::loadByOrderCodeOrTransactionId()`.

The controller then loads that payment, calls `processTransaction($payment, $t)` (section 4),
and on success redirects to Commerce's `checkout.return` (success) or `checkout.cancel`
(cancel) step. `success()` additionally calls `PaymentOrderUpdater::updateOrders()` right away
to avoid a "headers already sent" error during cart/session teardown.

Note: `cancel()` runs the same `processTransaction()` re-fetch as `success()`; the payment state
it sets is derived from the real transaction status, not from which URL Viva used.

## 3. Webhook — `VivawalletController::hook()` and `verifyHook()`

Both are at `…/{payment_gateway}/hook`; the POST is the event, the GET is Viva's verification.

**POST `hook()`** — access `VivawalletHookAccessCheck`: valid gateway; JSON body parses;
`EventTypeId === 1796` (Transaction Payment Created); `EventData.OrderCode` is an int and
`EventData.TransactionId` is a UUID; and a matching local payment exists. The handler reads
`OrderCode`/`TransactionId` from the body, loads the payment, logs it, and calls
`processTransaction($payment, $transactionId)`. Returns an empty `HtmlResponse`.

**GET `verifyHook()`** — route requirement `_user_is_logged_in: FALSE` (Viva's verification bot
is anonymous). Returns `JsonResponse(['key' => $token])` where `$token` = `ConfigService::
getToken()` → `GET messages/config/token` (Basic merchant_id:api_key) → the merchant's Viva
webhook verification `Key`. This is the standard Viva webhook URL-ownership check.

## 4. Transaction re-fetch, order-binding & status — `processTransaction()`

`src/Controller/VivawalletController.php::processTransaction($payment, $transaction_id)`:

1. **Re-fetch:** `TransactionService::get($transaction_id)` →
   **`GET checkout/v2/transactions/{id}`** on the Bearer-authenticated `api_oauth` host. A 404
   raises `TransactionNotFoundException`. The returned array is the authoritative transaction.
2. **Bind to this payment:** reads the local `remote_id`; if it is neither the `transaction_id`
   nor `(string) $transaction['orderCode']`, throws `\InvalidArgumentException` (surfaced as
   404). Since `remote_id` was set to Viva's `orderCode` at redirect time, this ties the fetched
   transaction to this specific payment/order.
3. **Apply state** from `$transaction['statusId']` (also stored as `remote_state`):
   - `A`, `M`, `MA`, `MI`, `MW`, `MS` → `authorization`.
   - `X`, `ML`, `E` → `authorization_voided`.
   - `C`, `F` → `completed` (sets authorized time from `insDate`).
   - `R` → `refunded`.
   - Any other value leaves the state unchanged.
4. Sets `remote_id` to the `transaction_id` and saves the payment.

## 5. Local payment lookup — `PaymentManager`

`src/PaymentManager.php` (all queries `accessCheck(FALSE)`, scoped to the gateway id):

- `loadByOrderCode()` — `remote_id == orderCode` **and** `state == 'new'` (the pre-redirect
  state, where `remote_id` still holds the orderCode).
- `loadByTransactionId()` — `remote_id == transactionId` **and** `state != 'new'` (after
  processing, where `remote_id` has been rewritten to the transactionId).
- `loadByOrderCodeOrTransactionId()` — tries order code first, then transaction id.

## Verification summary

Payment status is always taken from Viva's Bearer-authenticated `GET
checkout/v2/transactions/{id}` re-fetch, never from the return query or webhook body; the fetched
transaction is bound to the local payment by matching the stored `remote_id` (Viva `orderCode`)
before any state change; completion happens only on `statusId` `C`/`F`; and the payment amount /
currency are those recorded on the Commerce payment created server-side at redirect (the Viva
order was created from `$payment->getAmount()`). HTTP calls use Guzzle with default TLS
verification.
