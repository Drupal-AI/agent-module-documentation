<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# coinspaid_redirect — gateway plugin, offsite form, and API service

Everything wiring Drupal Commerce to CoinsPaid / CryptoProcessing. All code is in
`src/`; there is no routing.yml or services.yml — the gateway uses the standard
commerce_payment off-site machinery and instantiates `CoinspaidService` with `new`.

## Payment gateway plugin

`src/Plugin/Commerce/PaymentGateway/OffsiteRedirect.php`, class `OffsiteRedirect
extends OffsitePaymentGatewayBase`.

```
@CommercePaymentGateway(
  id = "coinspaid_redirect",
  label = "CoinsPaid (Redirect to payment page)",
  display_label = "CoinsPaid",
  forms = { "offsite-payment" = "...\PluginForm\OffsiteRedirect\CoinspaidOffsiteForm" }
)
```

- `defaultConfiguration()` returns `public_key: ''`, `secret_key: ''`,
  `invoice_mode: 0`, `debug: false` (plus base `mode`). As a side effect it also
  adds a sandbox warning message on the checkout `order_information` step when
  `mode === 'test'` (non-AJAX only).
- `buildConfigurationForm()` renders four fields: **Public Key**, **Secret key**
  (both required), **Invoice Mode** select (`0` = "Invoice without restriction of
  payment time", `1` = "Invoice with time restriction"), **Debug Mode** checkbox.
- `submitConfigurationForm()` persists those four values into `$this->configuration`.
- `onNotify(Request $request)` — the CoinsPaid callback handler (see below).
- Config schema: `config/schema/commerce_coinspaid.schema.yml`
  (`public_key: string`, `secret_key: string`, `invoice_mode: integer`, `debug: boolean`).

## Offsite redirect form (checkout → CoinsPaid)

`src/PluginForm/OffsiteRedirect/CoinspaidOffsiteForm.php`, class
`CoinspaidOffsiteForm extends PaymentOffsiteForm`.

- On build it instantiates
  `new CoinspaidService(public_key, secret_key, mode)` and calls
  `createInvoice(prepareOrder(...))`.
- `prepareOrder()` builds the invoice payload:
  - `timer` = `(bool) invoice_mode`
  - `title` = order id
  - `currency` / `amount` = from the payment entity (`$this->getEntity()->getAmount()`)
  - `foreign_id` = `"{order->id()}-{time()}"`  (the trailing `-time()` is stripped
    back to the order id on callback)
  - `url_success` = `$form['#return_url']`, `url_failed` = `$form['#cancel_url']`
  - `email_user` = order email, `description` = order item titles joined by `;`
- If a redirect URL is returned it calls `buildRedirectForm(...)` to POST the buyer
  to CoinsPaid; otherwise it surfaces the service errors and throws
  `NeedsRedirectException($form['#cancel_url'])`.
- Note: it unconditionally adds a "Payment failed…" error message during build
  (an existing quirk of the module).

## CoinspaidService — API client

`src/Service/CoinspaidService.php`. Constructed with `(public_key, secret_key,
env)` where `env` is `'live'` (default) or `'test'`.

- Server base URLs (hardcoded): `test` → `https://app.sandbox.cryptoprocessing.com/api/v2`,
  `live` → `https://es.cryptoprocessing.com/api/v2/`.
- Status constants: `STATUS_SUCCESS = 'confirmed'`, `STATUS_PENDING = 'pending'`,
  `STATUS_PROCESSING = 'processing'`, `STATUS_ERROR = 'error'`.
- Methods: `ping()` (GET `/ping`), `getSupportedCurrencies()` (POST
  `/currencies/list`), `createInvoice($params)` (POST `/invoices/create`).
- `execute()` uses raw cURL: sets `Accept`, `Content-Type: application/json`,
  `X-Processing-Key: {public_key}`, `X-Processing-Signature: {HMAC}` headers,
  10s connect/timeout, `CURLOPT_HEADER=true` then splits head/body manually.
  Default TLS verification (no `CURLOPT_SSL_VERIFYPEER` override).
- `generateSignature($params)` = `hash_hmac('sha512', json_encode($params), secret_key)`
  (throws if the body can't be encoded).
- Accessors: `getRedirectLink()` (`response.data.url`), `getResponseData()`,
  `hasErrors()`, `getErrors()`, `getErrorsStr()`, `getResponseStatus()`,
  `getOrderId()`, `getTransactionId()`, `getResponseCode()`.

## Callback verification (onNotify)

`OffsiteRedirect::onNotify(Request $request)`:

1. Reads `$headers = $request->headers->all()` and `$body = json_decode($request->getContent(), true)`.
2. Enables `DebugService` per the `debug` config, then (in debug) logs the body and headers.
3. Only proceeds if `$body['foreign_id']` is non-empty; derives `order_id` by
   stripping the trailing `-{time}` segment and `Order::load($order_id)`.
4. `new CoinspaidService(public_key, secret_key, mode)` then
   **`validateCallback($body, $headers)`**:
   - recomputes `generateSignature($body)` (HMAC-SHA512 over the body, keyed by the secret);
   - requires `headers['x-processing-key'] === public_key` **and**
     `headers['x-processing-signature'] === computed signature`;
   - **throws `Exception('Signature failed validation')` otherwise.** The throw is
     caught by the surrounding `try/catch` (which only logs), so an invalid or
     missing signature results in **no order/payment change**.
5. `parseResponse($body)` extracts `foreign_id`→order id, `status`, and a
   transaction id (last `transactions[].txid`, else `id`).
6. Branch on status:
   - `error` → set order state `cancelled` and save.
   - `confirmed` (`STATUS_SUCCESS`) → delete any prior matching `commerce_payment`
     (gateway + order + remote_id), then create a **`completed`** payment with
     **`amount = $order->getTotalPrice()`** (server-side order total, not a
     callback amount), `remote_id = transaction id`, `remote_state = status`; save;
     `die('Ok')`.

Security-relevant summary: the callback is authenticated by an HMAC-SHA512
signature keyed with the merchant secret and is rejected (by exception) before any
state change if the signature or public key does not match; the recorded amount
comes from the order total, not the callback body; TLS verification is left at cURL
defaults (on). The keys and `debug` flag are stored in the gateway configuration.
