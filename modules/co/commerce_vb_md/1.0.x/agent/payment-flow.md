<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce VictoriaBank Moldova — payment flow (source-grounded)

All references are to `commerce_vb_md` 1.0.x. VictoriaBank uses an RSA-signed
form-POST protocol (fields named `P_SIGN`, `TRTYPE`, `ORDER`, `AMOUNT`, …). The
merchant signs outbound requests with its **private** key; the bank signs callbacks
with its **private** key, which the module verifies with the bank's **public** key.

## 0. Signing helpers — `VictoriaBankSerializer`

`src/VictoriaBankSerializer.php`.

- **`pSignEncrypt($OrderId, $Timestamp, $trtType, $Amount)`** — builds a length-prefixed
  MAC from `ORDER,NONCE,TIMESTAMP,TRTYPE,AMOUNT` (NONCE hardcoded
  `11111111000000011111`), MD5s it, wraps it in a PKCS#1-style padded block with the
  ASN.1 MD5 prefix, and `openssl_private_encrypt(..., OPENSSL_NO_PADDING)` with
  `private://vicb_pem/key.pem`. Returns uppercase hex `P_SIGN`.
- **`pSignDecrypt($P_SIGN,$ACTION,$RC,$RRN,$ORDER,$AMOUNT)`** — builds a length-prefixed
  MAC from `ACTION,RC,RRN,ORDER,AMOUNT` (a literal `-` is passed through un-prefixed),
  MD5s it (uppercase), `hex2bin`s `P_SIGN`, and `openssl_public_decrypt()` with
  `private://vicb_pem/victoria_pub.pem`. It strips the ASN.1 prefix
  `3020300C06082A864886F70D020505000410` from the decrypted hex and returns TRUE only if
  the remainder equals the locally computed MD5, else FALSE. Throws on missing/invalid
  key or decrypt failure.

## 1. Checkout redirect — `PaymentOffsiteForm` + `VictoriaBankPaymentGateway::getFormData()`

`src/PluginForm/PaymentOffsiteForm.php`, `getFormData()` in the gateway.

- `getFormData($order)` computes:
  - `AMOUNT` = `number_format($order->getTotalPrice()->getNumber(), 0, ',', '')` (integer
    string, MDL).
  - `ORDER` = `sprintf('%06s', $order->id())` concatenated with the current Unix
    timestamp (an "order incrementer" that makes each attempt unique). `DESC = "NR: " .
    <6-digit order id>`.
  - Merchant fields from config (`MERCH_NAME/URL/ADDRESS`, `MERCHANT`, `TERMINAL`),
    `EMAIL`, `TRTYPE = 0`, `COUNTRY = md`, `MERCH_GMT` (offset for Europe/Bucharest),
    `NONCE`, `TIMESTAMP` (UTC `YmdHis`), `LANG`, and
    `BACKREF` = absolute `commerce_vb_md.back_ref` URL for this order.
  - `P_SIGN` = `pSignEncrypt(ORDER, TIMESTAMP, 0, AMOUNT)`.
- The form dispatches `VbMdEvents::PAYMENT_OFFSITE_FORM` (subscribers may mutate the
  `$data` array before submission), then `buildRedirectForm(..., getUrl(), $data,
  REDIRECT_POST)` renders an auto-submitting POST to the bank.
- `processVbRedirectForm()` unsets `form_token`, `form_build_id`, `form_id`, `captcha`
  and blanks the submit button `#name` so the cross-domain POST carries only the bank
  fields.

The Commerce off-site `onReturn()` for this gateway just throws a `NeedsRedirectException`
back to the checkout form; `getNotifyUrl()`, `onCancel()`, `onNotify()` all throw
`AccessDeniedHttpException` — this module uses its **own** callback route, not the
Commerce notify route.

## 2. Bank callback — `VictoriaBankCallbackController::index` → `VictoriaBankManager::preprocessResponse()`

Route `commerce_vb_md.callback` (`/commerce-vb-md/callback`, `_permission: 'access
content'`, `no_cache: TRUE`). Server-to-server POST from the bank.

`preprocessResponse(Request $request)` (`src/VictoriaBankManager.php`):

1. Reads the whitelisted POST fields `FILL_OPTIONS`
   (`P_SIGN,ORDER,TRTYPE,AMOUNT,APPROVAL,CURRENCY,ACTION,CARD,INT_REF,RC,RRN,BIN,TIMESTAMP`).
2. Returns early if any of `P_SIGN,ACTION,RC,RRN,ORDER,AMOUNT` is missing.
3. **Verifies the signature:** `pSignDecrypt(P_SIGN,ACTION,RC,RRN,ORDER,AMOUNT)`. On
   FALSE (or exception) it logs and **returns without touching any order** — this is the
   gate that makes a forged callback inert.
4. Derives the real order id as `substr(ORDER, 0, -10)` (strips the 10-digit timestamp
   suffix) and loads the `commerce_order`; throws `VictoriaBankException` if not found.
5. Takes a lock `"{order_id}_{TRTYPE}_{ACTION}"` (5s); if it can't acquire, returns
   (collapses duplicate callbacks). Writes a `commerce_log` entry (`vb_md_callback`) of
   the fields (P_SIGN removed).
6. Acts only when `ACTION` is `0` or `1` (authorization outcomes); otherwise returns.
   Then switches on `TRTYPE`:
   - **0** → `preprocessAuthorization()`
   - **21** → `preprocessCompleteSales()`
   - **24** → `preprocessRefund()`
   Finally releases the lock.

### 2a. `preprocessAuthorization($options)`

- Idempotent: if a `victoria_bank` payment already exists on the order
  (`findPaymentInOrder`), return.
- Creates a `commerce_payment` (`createNewPayment`): `amount = new Price($options['AMOUNT'],
  'MDL')`, `state = new`, `remote_id = RRN`, then calls the gateway's
  `authorizationPayment()` → payment state `authorization`.
- Stores the full callback option set on the order as data key `victoria_bank`
  (`$order->setData('victoria_bank', $options)`), advances `checkout_step` to the next
  step via the checkout flow plugin, and saves the order.
- If `auto_complete_sales` is enabled: fires a referenced complete-sales
  (`TRTYPE = 21`) via `referencedTransactionClientExecute(getUrl(),
  getTransactionOption(...))`. Otherwise sends the "authorized" customer email
  (`sendOrderMailClientInformation($order, "00")`).

### 2b. `preprocessCompleteSales($options)` / `2c. preprocessRefund($options)`

- Load the order's VictoriaBank payment, call the gateway's `completePayment()` (state
  → `completed`) or `refundPayment()` (state → `refund`), then email the customer
  (subject "Successful payment" / "Payment returned").

## 3. Referenced transactions — `referencedTransactionClientExecute()` + `getTransactionOption()`

- `getTransactionOption($payment, $options)` (gateway) builds the option set for a
  complete/refund: `ORDER` (the stored incrementer id), `AMOUNT`
  (`number_format(...,0)`), `CURRENCY`, `RRN` (= payment remote id), `INT_REF` (from the
  stored `victoria_bank` data), `TRTYPE`, `TERMINAL`, `NONCE`, `TIMESTAMP`, and a fresh
  `P_SIGN = pSignEncrypt(ORDER, TIMESTAMP, TRTYPE, AMOUNT)`.
- `referencedTransactionClientExecute($url, $options)` cURL-POSTs the options as
  `k=v&…` to `$url` (`getUrl()` → the mode-selected hardcoded HTTPS endpoint), with
  `CURLOPT_RETURNTRANSFER`. TLS verification is left at the secure default (no
  `CURLOPT_SSL_VERIFYPEER` override). Returns the raw response body.
- The admin `PaymentCompleteForm` (TRTYPE 21) and `PaymentRefundForm` (TRTYPE 24) call
  this directly, `Xss::filter()` the response to a small tag allow-list, show it as a
  status message, and `sleep(1)` to let the bank's async callback land.

## 4. Browser return — `VictoriaBankBackRefController::index` → `VictoriaBankBackRefHandler::redirect()`

Route `commerce_vb_md.back_ref` (`/commerce-vb-md/{commerce_order}/back-ref`).

- First hit (`self_reference != 1`): redirect to the same route with `self_reference=1`
  (the bank's first return is an anonymous POST with no order-payment access; the second
  hop is a clean GET).
- Then `VictoriaBankBackRefHandler::redirect($order)` checks `$order->access('view',
  currentUser)`; if denied → `<front>`. Otherwise (after `sleep(1)` if the order isn't
  locked) redirects to `commerce_checkout.form` for the order — which enforces its own
  access and shows the current checkout step (set during the callback in 2a).

## 5. Customer email — `sendOrderMailClientInformation()` + template

- Builds the `commerce_vb_md_mail` render array (`#order`, `#trtype`), renders it, and
  sends via the mail manager (`commerce_vb_md` module, key `transaction_status`) to
  `$order->getEmail()`.
- `template_preprocess_commerce_vb_md_mail()` (`.module`) fills the template: billing
  full name, masked `card_number` (from stored `victoria_bank` data `CARD`), `rrn`
  (payment remote id), authorized time, merchant fields, order number, support contacts,
  and the absolute return-policy URL. Header text varies by TRTYPE (21 = completed, 24 =
  cancelled/refund, else authorized).

## Verification summary

A callback changes order/payment state **only after** an RSA signature verification
against the bank's public key over `ACTION,RC,RRN,ORDER,AMOUNT`; the signed `ORDER`
binds the message to one order; authorization is idempotent (existing-payment guard) and
serialized by a short lock; complete/refund are further guarded by the payment
state-machine `assertPaymentState()`. Outbound referenced transactions go only to the
two hardcoded HTTPS bank endpoints with default TLS verification.
