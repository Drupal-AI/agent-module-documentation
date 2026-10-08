<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Pesapal — payment flow (source-grounded)

All references are to `commerce_pesapal` 1.0.x. The gateway uses Pesapal's OAuth 1.0
(HMAC-SHA1) API v2. The vendored OAuth client (`includes/OAuth.php`) is loaded with
`require_once` in both the redirect form and the status query.

## 1. Checkout redirect — `PesapalRedirectForm::buildConfigurationForm()`

`src/PluginForm/OffsiteRedirect/PesapalRedirectForm.php` (the `offsite-payment` form).

- Reads the order: total price → `Amount` (formatted `number_format($n, 2, '.', '')`),
  currency, `Reference = $order->id()`, email, and first/last name from the billing profile
  address.
- Builds a `<PesapalDirectOrderInfo …>` XML payload (all attribute values run through
  `htmlspecialchars(..., ENT_QUOTES)`), then `htmlentities()`-encodes the whole document as
  Pesapal expects.
- Picks endpoint + credentials by mode via `$gateway_plugin->getBaseUrl()` and
  `getCredentialsForMode()`; endpoint = `{base}/API/PostPesapalDirectOrderV4`.
- OAuth-signs a `GET` request (`\OAuthRequest::from_consumer_and_token` +
  `\OAuthSignatureMethod_HMAC_SHA1`) with `oauth_callback` = the Commerce **return URL**
  (absolute) and `pesapal_request_data` = the encoded XML.
- Submits with `buildRedirectForm(..., $redirect_url, [], self::REDIRECT_GET)` — the browser is
  sent to the signed Pesapal URL. The full signed URL and mode are logged at `notice`
  (subject to `logging_verbosity`).

## 2. IPN callback — `PesapalIpnController::notify()` → `PesapalRedirect::onNotify()`

Route `commerce_pesapal.ipn` (`/payment/pesapal/ipn`, `_permission: 'access content'`) loads
all `commerce_payment_gateway` entities, finds the one whose plugin is `PesapalRedirect`, and
calls `onNotify($request)`.

`onNotify()` (`src/Plugin/Commerce/PaymentGateway/PesapalRedirect.php`):

1. Reads `pesapal_notification_type`, `pesapal_transaction_tracking_id`,
   `pesapal_merchant_reference` from the query string; logs them.
2. If `type === 'CHANGE'` and both tracking id and merchant reference are present, calls
   `queryPaymentStatus($merchant_reference, $tracking_id)` — a **server-side, OAuth-signed
   re-fetch** of the real status from Pesapal.
3. If the re-fetched status is `COMPLETED`, loads the order by `merchant_reference` (which is the
   order id) and calls `ensureSuccessfulPayment($order, $tracking_id)`.
4. Always returns a `Response` whose body echoes the three `pesapal_*` params
   (`http_build_query`) — Pesapal's expected IPN acknowledgement.

## 3. Browser return — `PesapalRedirect::onReturn()`

- `merchant_reference` = `pesapal_merchant_reference` query param, else `$order->id()`;
  `tracking_id` = `pesapal_transaction_tracking_id`.
- If a tracking id is present, it re-fetches status via `queryPaymentStatus()` and, on
  `COMPLETED`, calls `ensureSuccessfulPayment()`. Returns `NULL` (Commerce handles the redirect
  to the order-complete page).

## 4. Status query — `queryPaymentStatus()`

- Endpoint `{base}/API/QueryPaymentStatus`, OAuth 1.0 signed `GET` with
  `pesapal_merchant_reference` + `pesapal_transaction_tracking_id`.
- Executed with `\Drupal::httpClient()->get($url, ['timeout' => 30])` — Guzzle default TLS
  verification (no `verify => false`).
- Parses the response: `pesapal_response_data` from a `parse_str()` of the body, else a bare
  body string matched against the allow-list `['PENDING','COMPLETED','FAILED','INVALID']`
  (strict `in_array` comparison). Returns the status string or `NULL` on error/unknown.
- The public wrapper `testQueryPaymentStatus()` exposes this to the admin status-tester form
  (`/admin/commerce/pesapal/status`, `administer commerce_payment`).

## 5. Order completion — `ensureSuccessfulPayment()`

- Refuses to do anything without a tracking id.
- **Idempotent:** returns early if a `commerce_payment` already exists for this `order_id` +
  `remote_id` (tracking id).
- Creates a `commerce_payment` with `state = completed`, `amount` = the **server-side order
  total** (`$order->getTotalPrice()`), `remote_id` = tracking id, `remote_state = completed`.
- Then sets the order `state` to `completed` (direct `$order->set('state', …)->save()`, guarded
  by a try/catch that logs on failure) unless it is already completed.

## Verification summary

Status is always taken from Pesapal's authenticated `QueryPaymentStatus` re-fetch, never from
the request payload; fulfilment happens only on a re-fetched `COMPLETED`; the recorded amount is
computed server-side from the order; and payments are de-duplicated by remote transaction id.
