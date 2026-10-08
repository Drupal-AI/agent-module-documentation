<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Payment flow — HPP link build + callback signature verification

Files: `src/Plugin/Commerce/PaymentGateway/OffsiteRedirect.php`,
`src/PluginForm/OffsiteRedirect/PaymentOffsiteForm.php`,
`src/Controller/CommerceNbgRedirectController.php`,
`commerce_nbg_redirect.routing.yml`,
`templates/commerce-nbg-redirect-return.html.twig`.

The integration is built on the **GlobalPayments PHP SDK** (`globalpayments/php-sdk ^14.0.4`) and
its GP-API Hosted Payment Page / Pay-by-Link feature. NBG is the acquiring bank behind the
GlobalPayments account.

## 1. Outbound redirect (customer → hosted page)

`PaymentOffsiteForm::buildConfigurationForm()` runs at the checkout "payment" step and calls
`createPayByLinkUrl($payment, $form)`:

1. Reads the gateway plugin config: `app_id`, `app_key`, `country_code`, `mode`.
2. Configures the SDK: `GpApiConfig` with `appId`, `appKey`, `country = country_code`,
   `channel = Channel::CardNotPresent`,
   `environment = Environment::PRODUCTION` when `mode === 'live'` else `Environment::TEST`, then
   `ServicesContainer::configureService($config)`.
3. Builds `PayerDetails` from the order: `firstName` / `lastName` from the billing profile
   `address` (`given_name` / `family_name`), `email` from `$order->getEmail()`, `status = 'NEW'`.
4. Reads amount + currency from `$order->getTotalPrice()->toArray()` (`number`, `currency_code`) —
   **server-side**, taken from the order total, not from any request input.
5. Generates two references with `Drupal\Component\Utility\Random`:
   - `reference` = `'Hosted Payment Page transaction ' . random(16)` (free-form).
   - `order_reference` = `'order_' . $order->id() . '_' . $plugin->getPluginId() . '_' . random(16)`
     — the underscore-delimited string the callback later parses.
6. `return_url` = `Url::fromRoute('commerce_nbg_redirect.return_url', [], ['absolute' => TRUE])`.
7. Builds the hosted page via `HPPBuilder::create()`:
   `withName`, `withDescription`, `withReference`, `withOrderReference`, `withAmount`,
   `withCurrency`, `withPayer`, `withNotifications($return_url, $return_url, $return_url)`
   (success / failure / notification all point at the module callback),
   `withTransactionConfig(country: country_code)`,
   `withAuthentication(ChallengeRequestIndicator::CHALLENGE_PREFERRED, ExemptStatus::LOW_VALUE, TRUE)`
   (3-D Secure), `withDigitalWallets(["googlepay", "applepay"])`, then `->execute()`.
8. Returns `$response->payByLinkResponse->url`; `buildRedirectForm()` sends the browser there.

The `app_key` is used only to authenticate the *server-to-GlobalPayments* API call; it is never
sent to the browser.

## 2. Inbound callback (GlobalPayments → site)

Route `commerce_nbg_redirect.return_url` → `CommerceNbgRedirectController::returnUrl()`
(`_access: 'TRUE'`, `methods: [POST]`, `no_cache: TRUE`).

`returnUrl()`:
1. Reads the `X-GP-Signature` request header.
2. `raw_input = trim($request->getContent())`; `input = json_decode($raw_input, TRUE)`.
3. Parses `input['reference']` with `explode('_', …)` → `['order', <order id>, <gateway id>, <random>]`;
   `order_id = reference[1]`, gateway id = `reference[2]`.
4. Loads the order by `order_id`.
5. **`validateRequest($raw_input, $gp_signature, reference[2])`** — must return TRUE or the request
   is rejected with `AccessDeniedHttpException` (403). See §3.
6. Stores on the order:
   `commerce_nbg_payment = { result_code: input['action']['result_code'], transaction_id: input['id'],
   status: input['status'] }` and saves.
7. Builds the `commerce_nbg_redirect_return` theme with `redirect_url =
   commerce_payment.checkout.return` (step `payment`), renders it in isolation, and returns it as
   the HTTP response — a minimal HTML page whose inline
   `window.location.replace()` forwards the *customer's browser* to the Commerce return step.

## 3. Signature verification (`validateRequest()`)

```
if (!$raw_input || !$gp_signature) return FALSE;          // both required
$parsed = json_decode($raw_input, TRUE);
if (!$parsed) return FALSE;
$gateway = paymentGatewayStorage->load($plugin_id);        // $plugin_id = reference[2]
$app_key = $gateway->getPluginConfiguration()['app_key'];  // server-side secret
$minified = json_encode($parsed, JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE);
return hash('sha512', $minified . $app_key) === $gp_signature;
```

This is GlobalPayments' documented webhook scheme: a SHA-512 digest over the (re-minified) JSON
body concatenated with the merchant `app_key`, compared to the `X-GP-Signature` header. Because
`app_key` is secret and stored server-side, a third party cannot compute a matching signature.
The `reference` (hence order id + gateway id) is part of the signed body, so it cannot be swapped
onto a different order without invalidating the signature.

## 4. Completing the order (`onReturn()`)

The Commerce checkout return step calls `OffsiteRedirect::onReturn($order, $request)`:

1. Reads `$order->getData('commerce_nbg_payment')`. If `result_code` is missing or not `'SUCCESS'`,
   throws `PaymentGatewayException` (no payment created). This data is only ever set by the
   signature-validated callback in §2.
2. Otherwise creates a `commerce_payment` with:
   - `state = 'completed'`,
   - **`amount = $order->getBalance()`** — the server-side outstanding balance, not any
     request-supplied amount,
   - `payment_gateway = $this->parentEntity->id()`,
   - `order_id = $order->id()`,
   - `remote_id = transaction_id` (`input['id']`),
   - `remote_state = status` (`input['status']`).

## 5. Why forgery is blocked

- The callback that sets the "paid" order data recomputes a SHA-512 digest keyed with the merchant
  `app_key` and returns 403 on mismatch; without the secret an attacker cannot forge it.
- Payment creation (`onReturn`) is gated on `result_code === 'SUCCESS'` stored by that
  signature-validated callback — the browser-return path carries no result of its own.
- The credited amount is the order's own server-side balance, so tampering with any amount field
  in the callback both breaks the signature and cannot change the recorded amount.

## Config reference (gateway plugin)

| Field | Meaning |
|-------|---------|
| `mode` | Base test/live selector (from `OffsitePaymentGatewayBase`); maps to GP `Environment`. |
| `country_code` | Merchant country code (default `GR`); GP-API `country` / transaction config. |
| `merchant_id` | NBG merchant identifier. |
| `app_id` | GlobalPayments GP-API application ID. |
| `app_key` | GlobalPayments GP-API application key; **also the callback signing secret**. |
