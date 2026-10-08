# Off-site redirect + notification (IPN) flow

`commerce_sermepa` is an off-site gateway. It defines **no routes of its own** — the return and
notify URLs are Commerce's standard payment-gateway endpoints. Class:
`Drupal\commerce_sermepa\Plugin\Commerce\PaymentGateway\Sermepa`.

## 1. Redirect to Redsýs — `SermepaForm::buildConfigurationForm()`

The `offsite-payment` plugin form
`Drupal\commerce_sermepa\PluginForm\OffsiteRedirect\SermepaForm` builds an auto-submitting POST
form to Redsýs:

- Instantiates the library:
  `new CommerceRedsys\Payment\Sermepa($merchant_name, $merchant_code, $merchant_terminal, $merchant_password, $mode)`.
- Only proceeds if the order currency's numeric code equals the configured `currency`.
- Amount is sent in cents: `$payment->getAmount()->multiply(100)->getNumber()`.
- Sets the transaction: `setAmount()`, `setCurrency()`, `setOrder()` (a 12-char order ref built
  from the timestamp + order id), `setMerchantData($order->id())` (echoed back in the
  notification as `Ds_MerchantData`), `setTransactionType()`, `setPaymentMethod()`,
  `setConsumerLanguage()` (respects the `000` "dynamic" language via
  `Sermepa::getUnknownFallbackLanguage()` / `getSermepaCurrentLanguage()`).
- `setMerchantURL($payment_gateway_plugin->getNotifyUrl()->toString())` — the async notify
  callback; `setUrlOK($form['#return_url'])`, `setUrlKO($form['#cancel_url'])`.
- Posts three fields to `$gateway->getEnvironment()` (the test/live Redsýs URL):
  `Ds_SignatureVersion` (`HMAC_SHA256_V1`), `Ds_MerchantParameters` (base64 JSON blob),
  `Ds_Signature`. Uses `buildRedirectForm(... REDIRECT_POST)`.
- On any exception or currency mismatch it logs and redirects back to the payment-information
  pane (`redirectToPaymentInformationPane()`).

## 2. Notification / return — how a payment is created

Both entry points funnel into `Sermepa::processRequest(Request $request, ?OrderInterface $order)`:

- `onNotify(Request $request)` — hit by Redsýs at Commerce's notify URL
  (`/payment/notify/{commerce_payment_gateway}`, route `commerce_payment.notify`, no session).
  Calls `processRequest($request)` (no order argument) and swallows exceptions so a rejected
  notification returns HTTP 500 to Redsýs.
- `onReturn(OrderInterface $order, Request $request)` — the shopper's browser return. Uses the
  persistent lock to avoid racing `onNotify`, reloads the order, and if the state already advanced
  (payment already recorded by the notify) throws `NeedsRedirectException` to the next checkout
  step; otherwise processes and shows a success message.

`processRequest()` steps (the payment-creating path):

1. Reads `Ds_SignatureVersion`, `Ds_MerchantParameters`, `Ds_Signature` from the request; throws
   `PaymentGatewayException` if any are empty.
2. Builds a library instance from the gateway config and `decodeMerchantParameters()` to read the
   returned parameters; `Ds_MerchantData` gives the order id, used to load the order when not
   supplied.
3. Acquires the per-order persistent lock (`commerce_sermepa_process_request_<order-uuid>`).
4. Verifies the response signature via `$gateway->validSignatures($feedback)`; on mismatch releases
   the lock and throws `PaymentGatewayException` — no payment is created.
5. Verifies the result code with `Sermepa::authorizedResponse($parameters['Ds_Response'])`
   (authorized when `Ds_Response <= 99`); otherwise throws.
6. Idempotency: queries existing `commerce_payment` for this gateway + order +
   `remote_id = Ds_AuthorisationCode`; only creates one if none exists.
7. Creates the payment: amount `Ds_Amount / 100` in the order's currency, `state` from
   `getStatusMapping()[transaction_type]` (default `authorization`, mapped up e.g. type `0`
   → `completed`), `remote_id = Ds_AuthorisationCode`,
   `remote_state = Sermepa::handleResponse(Ds_Response)`, `test = (mode == 'test')`, and copies
   the order's `payment_method`. Saves, releases the lock, returns `TRUE`.

## Key methods / services

| Symbol | Purpose |
|--------|---------|
| `Sermepa::onNotify()` / `onReturn()` | Commerce off-site entry points. |
| `Sermepa::processRequest()` | Validates the response and creates the payment. |
| `Sermepa::getStatusMapping()` | Maps Redsýs transaction type → Commerce payment state. |
| `Sermepa::buildPaymentInstructions()` | Renders the configured `instructions` text after checkout. |
| `SermepaForm::buildConfigurationForm()` | Builds the POST redirect to Redsýs. |
| `lock.persistent` | Serializes concurrent notify/return for the same order. |
| logger channel `commerce_sermepa` | Warnings/errors (e.g. order-id mismatch, redirect build failure). |

The Redsýs protocol details (parameter encoding, `HMAC_SHA256_V1` signing of
`Ds_MerchantParameters` with the per-order-keyed merchant secret, response validation) are
implemented in the `commerceredsys/sermepa` library, not this module.
