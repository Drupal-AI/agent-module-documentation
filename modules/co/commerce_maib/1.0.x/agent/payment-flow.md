<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Payment flow — registration, redirect, server-side confirmation

Files: `src/PluginForm/OffsiteRedirect/PaymentOffsiteForm.php`,
`src/Plugin/Commerce/PaymentGateway/OffsiteRedirect.php`,
`src/Controller/PaymentCheckoutController.php`, `commerce_maib.routing.yml`,
`src/Plugin/QueueWorker/PaymentWorker.php`, `commerce_maib.module`,
`src/MAIBGateway.php`. API client: `Maib\MaibApi\MaibClient` (`maib/maibapi`).

## 1. Registration (customer → bank), `PaymentOffsiteForm::buildConfigurationForm()`

Runs at the checkout "payment" step:

1. Reads the gateway config; `#capture = (intent === 'capture')`.
2. Computes the **amount server-side** from `$payment->getAmount()->getNumber()` and currency
   numeric code, plus client IP, `Order #<id>` description, and current language.
3. Builds the API client via `$payment_gateway_plugin->getClient()` (mutual-TLS, see §5) and
   registers the transaction with MAIB:
   - capture → `registerSmsTransaction(amount, currency, ip, description, language)`
   - authorize → `registerDmsAuthorization(...)`
4. Requires `TRANSACTION_ID` in the response (throws `MAIBException` on `error` or missing id).
5. `storePendingPayment($order, $transactionId)` creates a `commerce_payment` with
   `state = new`, `amount = $order->getBalance()` (server-side), `remote_id = TRANSACTION_ID`,
   `remote_state = CREATED`, `expires = requestTime + 180s`.
6. Auto-POSTs (`buildRedirectForm`, `REDIRECT_POST`) the browser to the bank redirect URL
   (`getRedirectUrl()`, test/live constant) with fields `{ trans_id: TRANSACTION_ID, language }`.

The bank's card page is keyed by `trans_id`; no amount or secret is entrusted to the browser.

## 2. Return bounce (bank → site), `PaymentCheckoutController`

Route `commerce_maib.checkout_return` — path `/commerce-maib/return`, `_controller =
PaymentCheckoutController::returnPage`, `_custom_access =
PaymentCheckoutController::checkAccess`.

`checkAccess()` (custom access) allows the request only if:
- `trans_id` is present (else logs + `forbidden`),
- it resolves to an existing MAIB payment via
  `loadByProperties(['remote_id' => $trans_id, 'payment_gateway' => commerce_maib_get_all_gateway_ids()])`
  (else `forbidden`),
- the order is **not** `canceled` and `hasItems()`, and the account has the
  `access checkout` permission.

`returnPage()` reads `trans_id` (POST), loads the payment → order, then **immediately**
`redirectToCheckoutFinishedUrl()` throws a `NeedsRedirectException` (302) to
`commerce_payment.checkout.return` **with the order id + step in the URL** and `trans_id` in the
query. (This is the module's whole job here — work around Commerce issue 2931044 where the order
is not a route param on the bank's callback. The code after the throw is unreachable; the actual
`onReturn` is invoked by Commerce's own controller on the redirected route.)

`cancelPage()` (route `commerce_maib.checkout_cancel`, `/commerce-maib/cancel`): loads the
payment, `->delete()`s it, calls the plugin's `onCancel`, and redirects back to the previous
checkout step.

## 3. Server-authoritative confirmation, `OffsiteRedirect::onReturn()`

Invoked by Commerce after the §2 redirect. This is where a payment becomes paid:

1. Reads `trans_id` from the request (throws if missing).
2. Loads the pre-registered payment by `remote_id = trans_id` (+ MAIB gateway ids).
3. **Re-queries the bank**: `$this->getClient()->getTransactionResult($transId,
   $order->getIpAddress())` — mutual-TLS, authenticated with the merchant client cert.
4. Branches on the bank's `RESULT`:
   - `OK` + `intent = authorize` → payment `authorization`, `remote_state = OK`, store
     `payment_info`, success message + notice log.
   - `OK` + capture → payment `completed`, `remote_state = OK`, store `payment_info`.
   - not `OK` and not `PENDING` → **delete** the payment, error message + log, throw
     `MAIBException` (declined/failed/reversed/timeout).
   - `PENDING` → payment `pending`, "still in process" message.

The amount is never taken from the request; it is the balance fixed at registration. `RESULT`
is the bank's own answer. `trans_id` is MAIB's opaque id and the payment is pre-bound to this
order, so the return cannot be forged into a free/underpriced fulfilment.

## 4. Cron reconciliation & day-close, `hook_cron` + `PaymentWorker`

- Once per calendar day, for each MAIB gateway, `closeDay()` is called ("close business day");
  guarded by `state('commerce_maib.last_closed_day')` so it runs at most once/day.
- Queries `commerce_payment` in `new`/`authorization` state whose `expires < now` and queues
  each id into `commerce_maib_queue`.
- `PaymentWorker::processItem()` re-queries `getTransactionResult` for each stalled `new`
  payment and: `OK` → set `completed`/`authorization` (per intent) + store `payment_info`;
  a terminal fail state (`FAILED/DECLINED/REVERSED/AUTOREVERSED/TIMEOUT`) → delete; `transaction
  not found` → delete the ghost payment. `CREATED`/`PENDING` are left for a later pass.

## 5. `getClient()` — mutual-TLS client

`OffsiteRedirect::getClient()` builds a Guzzle client, then `MaibClient`:

```
base_uri => test/live MerchantHandler constant
verify   => TRUE
cert     => public_key_path            // certificate PEM
ssl_key  => [private_key_path, private_key_password]
config.curl => [ CURLOPT_SSL_VERIFYHOST => 2, CURLOPT_SSL_VERIFYPEER => TRUE ]
```

When `debug` is on, a Monolog `StreamHandler` on `debug_file` logs Guzzle request/response
(bodies only; the cert/key travel as TLS options, not in the body).

## 6. Capture / void / refund (authorize workflow)

- `capturePayment($payment, $amount?)` — asserts `authorization`; `makeDMSTrans(transId, amount,
  currencyNumeric, ip, desc, lang)`; on `OK` set `completed` + amount; else throw.
- `voidPayment($payment)` — asserts `authorization`; `revertTransaction(transId, amount)`; on
  `OK` delete the payment; else throw.
- `refundPayment($payment, $amount?)` — asserts `completed`, checks refund amount;
  `revertTransaction(transId, amount)` (MAIB supports full refund of the authorised amount); on
  `OK` set `refunded` + refunded amount; else throw.

## Config reference (gateway plugin `maib_redirect`)

| Field | Meaning |
|-------|---------|
| `mode` | Base test/live selector (from `OffsitePaymentGatewayBase`); picks the MAIB endpoint/redirect constants. |
| `intent` | `capture` (SMS, funds move immediately — recommended) or `authorize` (DMS hold, capture later). |
| `public_key_path` | Path to the certificate PEM (extracted from the bank `.pfx`). Test default: the `maib/maibapi` bundled test cert. |
| `private_key_path` | Path to the private-key PEM. Test default: the bundled test key. |
| `private_key_password` | PFX passphrase for the private key (kept if the field is left blank on re-save). |
| `debug` / `debug_file` | Optional Guzzle request/response logging to a file path. |
