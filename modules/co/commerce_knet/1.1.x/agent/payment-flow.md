<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce KNET — payment flow, UDF mapping, config

Source: `src/PluginForm/KnetPaymentOffsiteForm.php`,
`src/Toolkit/KnetToolKit.php`, `src/Helper/SecureText.php`,
`src/Controller/KnetController.php`, `src/Plugin/Commerce/PaymentGateway/Knet.php`.

## 1. Outbound redirect (checkout → KNET)

`KnetPaymentOffsiteForm::buildConfigurationForm()` runs when the shopper reaches
the `payment` checkout step with KNET selected:

1. Builds `#return_url` = route `commerce_knet.checkout.return` and `#cancel_url`
   = route `commerce_knet.checkout.cancel`, both absolute, with
   `{commerce_order}` = order id and `{step}` = `payment`.
2. Generates `unique_token = uniqid("<order_number>.")`, logged to the `knet`
   channel.
3. Instantiates `KnetToolKit` from gateway config: `setKnetUrl(endpoint_<mode>)`,
   `setTranportalId`, `setTranportalPassword`, `setTerminalResourceKey`,
   `setResponseUrl(#return_url)`, `setErrorUrl(#cancel_url)`, `setLanguage`,
   `setTrackId(order number)`, `setAmount(payment amount)`, and the UDFs below.
4. `performPaymentInitialization()` assembles the request string, **encrypts** it
   with the terminal resource key (`SecureText::encrypt`, AES-128-CBC), and
   returns `…/PaymentHTTP.htm?param=paymentInit&trandata=<enc>&tranportalId=…&responseURL=…&errorURL=…`.
5. `buildRedirectForm(..., 'GET')` sends the browser to that URL.

### Request string fields (KnetToolKit::performPaymentInitialization)
`id`, `password`, `amt`, `trackid`, `currencycode=414` (KWD), `langid`
(`en`→`USA`, `ar`→`AR`, else `AR`), `action=1` (purchase), `responseURL`,
`errorURL`, `udf1..udf5`. Throws if `tranportal_id` / password / resource key /
url are missing, or if encryption yields an empty string.

### UDF mapping (fixed by the form, not freely configurable except udf5)
- `udf1` = `[user_id]` → Drupal uid (`0` for anonymous).
- `udf2` = base64 of `[user_mail]` (user mail, or the order email for anonymous;
  base64-encoded to survive `+` addressing).
- `udf3` = `[order_id]` (technical order id) — used on return to bind the response
  to the order.
- `udf4` = the generated `unique_token`.
- `udf5` = admin-configured tokenized string (default `[order_number]`).

### Available tokens (replaced by `replaceToken()`)
`[user_id]`, `[user_mail]`, `[order_number]` (friendly number, generated via the
order type's number pattern if not yet set), `[order_id]`, `[langcode]`.

## 2. Return handling (KNET → store) — KnetController::returnPage

Route `commerce_knet.checkout.return`, path
`/checkout/{commerce_order}/{step}/knet-success`, `_access: 'TRUE'`.

1. Reads the POST body (`$request->request->all()`); empty → `AccessDenied`.
2. Loads the order from the route, `validateStepId()`, and confirms the order's
   gateway plugin implements `KnetInterface`.
3. `parseAndPrepareKnetData()` **decrypts** `trandata` with the terminal resource
   key (`SecureText::decrypt`), splits the `key=value&key=value` plaintext into an
   array, and base64-decodes `udf2` back to the email.
4. Server-side outcome checks (each failure → `cancelPage`):
   - `udf3` present;
   - `result === 'CAPTURED'` (strict);
   - `udf3` equals `$order->id()` (binds response to this order);
   - `amt` equals `$order->getTotalPrice()->getNumber()` (amount check).
5. Creates a `payment_default` Payment: `state = completed`,
   `amount = new Price(amt, order currency)`, `remote_id = auth ?? tranid`,
   `remote_state = result`, additional data = the full parsed response; saves it
   and advances the checkout flow to the next step.

## 3. Cancel / failure — KnetController::cancelPage

Route `commerce_knet.checkout.cancel`, path `.../knet-failure`. Parses any POST
(when present), logs a warning, shows the shopper an error with tranid / paymentid
/ status, and redirects back to the previous checkout step.

## 4. Gateway configuration fields (Knet plugin)

| Field | Notes |
|---|---|
| `mode` | Base test/live selector; selects `endpoint_<mode>`. |
| `endpoint_live` | Default `https://kpay.com.kw/kpg/PaymentHTTP.htm`. |
| `endpoint_test` | Default `https://kpaytest.com.kw/kpg/PaymentHTTP.htm`. |
| `tranportal_id` | From KNET. |
| `tranportal_password` | From KNET (secret). |
| `terminal_resource_key` | AES key for encrypt/decrypt (secret). |
| `udf5` | Tokenized string, default `[order_number]`. |

Store `tranportal_password` and `terminal_resource_key` securely — the README
recommends entering test credentials in the UI and overriding live values in
`settings.php` so live secrets are not written to the database/config export.

Config-schema note: `config/schema/commerce_knet.schema.yml` still lists a single
`endpoint` key and `udf1..udf5`, whereas the plugin stores `endpoint_live`,
`endpoint_test` and only `udf5`. The form's `#default_value` for both endpoint
fields reads the (unused) `endpoint` key, so saved endpoints do not repopulate as
their own values on re-edit. These are functional/config-validation quirks.

## 5. PHP 8 compatibility

`SecureText::pkcs5Unpad()` uses `ord($text{strlen($text) - 1})` (curly-brace
string offset), removed in PHP 8.0 — a parse error under the PHP 8 that Drupal
10/11 require. Any code path that reaches `SecureText::encrypt`/`decrypt`
(checkout redirect, return parsing) fatals until the line is changed to
`$text[strlen($text) - 1]`.
