<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Payment flow — redirect digest + callback verification

Files: `src/Plugin/Commerce/PaymentGateway/AlphabankPaymentRedirect.php`,
`src/PluginForm/OffsiteRedirect/AlphabankPaymentRedirectForm.php`,
`src/Controller/CallbackController.php`, `commerce_alphabank_redirect.routing.yml`.

## 1. Outbound redirect (customer → bank)

`AlphabankPaymentRedirectForm::buildConfigurationForm()` runs at the checkout "payment" step:

1. Reads the gateway config (`version, mid, currency, confirmUrl, cancelUrl, shared_secret,
   postUrl, pay_method, beneficiary_code`) and the order.
2. Formats the amount as `sprintf('%0.2f', $order->getTotalPrice()->getNumber())`.
3. Persists `AlphabankGatewayData = { shared_secret, payment_gateway }` on the order (`$order->save()`)
   so the callback can recompute the digest later.
4. Builds a 45-slot positional array (`$digest_data_array[1..45]`), most slots empty, with
   `orderid = <order id> . 'at' . time()`, amount, currency, billing country/zip/city/address,
   `confirmUrl`, `cancelUrl`, and `shared_secret` in slot 45.
5. `digest = base64_encode(hash('sha256', implode('', $digest_data_array), TRUE))`.
6. Emits an auto-POST form (`buildRedirectForm(..., $config['postUrl'], $data, 'post')`) whose
   fields mirror the array positions plus `digest`. **`shared_secret` is not among the POSTed
   fields** — only the derived `digest` is sent.

### IRIS variant (`pay_method === 'iris'`)
Adds `payMethod = 'IRIS'`, payer email, payer phone (from billing field, default `field_phone`,
overridable via `hook_commerce_alphabank_redirect_billing_phone_field_alter`), and an
`orderDesc` = **DIAS RF payment code** computed by `calculateDiasRFCode()`:
- `calculateAmountCheckDigit()` — cents × Mod8 with multiplier cycle `[1,7,3]`.
- `calculateCheckDigits()` — ISO-11649-style Mod97 over `<code>271500`, `98 - remainder`,
  computed with `bcmod` (the number exceeds native int range).
- Result: `RF` + 2 check digits + beneficiary + amount-check-digit + 15-digit order id = 25 chars.
These throw `InvalidArgumentException` on non-positive totals or wrong length. Reference-code
generation only; no external calls.

## 2. Inbound callback (bank → site)

Route `commerce_alphabank_redirect.payment_callback` →
`CallbackController::callback(Request $request)` (`_access: 'TRUE'`, `no_cache: TRUE`).

`callback()`:
1. `$action = $request->get('status')`.
2. Calls `processCallback($request)` (this is where a payment may be created — see below).
3. Parses the order id from `orderid` via `explode('at', …)` → first segment. If empty →
   redirect to `<front>`.
4. If `status === 'CANCELED'` → redirect to `commerce_payment.checkout.cancel`.
5. Recomputes the digest and compares to the posted `digest`; on mismatch shows the error
   message and returns to the `order_information` step, otherwise advances to the `complete` step.

`processCallback()` (creates the payment):
1. If `status` is not `CAPTURED` and not `AUTHORIZED` → log failure, return message, **no payment**.
2. Load the order, recompute the digest with `calculateHash()`.
3. **`calculateHash()`** concatenates 14 request fields
   (`version, mid, orderid, status, orderAmount, currency, paymentTotal, message, riskScore,
   payMethod, txId, Sequence, SeqTxId, paymentRef`) **plus the `shared_secret` read from the
   order's `AlphabankGatewayData`**, then `base64_encode(hash('sha256', …, TRUE))`.
4. If the recomputed hash matches the posted `digest` → `createPayment()` with state
   **`completed`**. Otherwise → `createPayment()` with state **`"Unvalidated"`** and log a
   failure.

`createPayment()` records a `commerce_payment` with **`amount = $order->getBalance()`** (server
side — not the callback amount), `payment_gateway` from the stored gateway data, `remote_id =
txId`, `remote_state = status`, and the completed timestamp.

## 3. Why forgery is blocked

- The digest is keyed with the merchant `shared_secret` (never sent to the browser, stored
  server-side in order data). Without the secret an attacker cannot produce a matching digest.
- A digest mismatch does not fulfil the order: the resulting `"Unvalidated"` payment is not in
  Commerce's `completed` state, and Commerce sums only `completed` payments into the order's
  paid total. Only a secret-valid `CAPTURED`/`AUTHORIZED` response yields a `completed` payment.
- The credited amount is the order's own server-side balance, so tampering with the callback's
  `orderAmount`/`paymentTotal` both breaks the digest and cannot change the recorded amount.

## Config reference (gateway plugin)

| Field | Meaning |
|-------|---------|
| `mode` | Base test/live selector (from `OffsitePaymentGatewayBase`). |
| `pay_method` | `default` or `iris`. |
| `version` | Spec version (value `2`). |
| `mid` | Merchant id (issued by the bank). |
| `beneficiary_code` | IRIS only — DIAS beneficiary code. |
| `currency` | ISO-4217 alphabetic (e.g. `EUR`). |
| `confirmUrl` / `cancelUrl` | Success / failure return URLs (default the module callback with `?action=…`). |
| `shared_secret` | Digest signing/verification secret issued by the bank. |
| `postUrl` | Bank VPOS endpoint (default Cardlink test: `https://alphaecommerce-test.cardlink.gr/vpos/shophandlermpi`). |
