<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CoinsPaid Commerce (commerce_coinspaid) — agent index

A Drupal Commerce **off-site payment gateway** for **CoinsPaid / CryptoProcessing**
(crypto payment processor). At checkout the shopper is redirected to a CoinsPaid
hosted invoice page; the order is settled when CoinsPaid POSTs a **signed callback**
back to the site. Package `Commerce`. Module machine name `commerce_coinspaid`;
Drupal.org project (and Composer package) is **`drupal/coinspaid`** — the real
module is the nested `commerce_coinspaid/` subdir of that project.
`core_version_requirement: ^8 || ^9 || ^10 || ^11` (per `.info.yml`). Installed **1.0.2**
(version dir `1.0.x`). License GPL-2.0-or-later.

## Dependencies

- Drupal modules (`.info.yml`): **`commerce:commerce_payment`**, **`commerce:commerce`**.
- No Composer libraries, no `composer.json`, no PHP library requirements.

## What it provides (from source)

- **One payment gateway plugin** `coinspaid_redirect`
  (`src/Plugin/Commerce/PaymentGateway/OffsiteRedirect.php`), extending
  `OffsitePaymentGatewayBase`. Config: `public_key`, `secret_key`, `invoice_mode`
  (0 = no time limit, 1 = time-restricted), `debug` — plus the base `mode`
  (test/live). Its `offsite-payment` form is `CoinspaidOffsiteForm`.
- **Offsite redirect form** `src/PluginForm/OffsiteRedirect/CoinspaidOffsiteForm.php`
  — builds the CoinsPaid invoice (`createInvoice`) from the order and redirects the
  buyer to the returned hosted-payment URL.
- **`CoinspaidService`** (`src/Service/CoinspaidService.php`) — a plain (non-DI, `new`-ed)
  cURL client for the CryptoProcessing v2 API: `ping`, `getSupportedCurrencies`,
  `createInvoice`, HMAC-SHA512 request signing (`generateSignature`), and callback
  verification (`validateCallback`, `parseResponse`).
- **`DebugService`** (`src/Service/DebugService.php`) — static logger to the
  `commerce_coinspaid` channel, on only when the gateway `debug` config is set.
- **Config schema** `config/schema/commerce_coinspaid.schema.yml` for the four
  plugin settings. No `.services.yml` (services are instantiated directly).
- **No routing.yml, no permissions, no hooks, no install/update, no templates/JS.**
  The callback arrives on the standard commerce_payment notify route
  `/payment/notify/{commerce_payment_gateway}` → `OffsiteRedirect::onNotify()`.

## Payment / callback flow (security-relevant)

- **Checkout → invoice:** `CoinspaidOffsiteForm::buildConfigurationForm()` calls
  `CoinspaidService::createInvoice()` with `foreign_id = "{order_id}-{time()}"`,
  `amount`/`currency` from the payment entity, and `url_success`/`url_failed` from
  Commerce's `#return_url`/`#cancel_url`, then `buildRedirectForm()` sends the buyer
  to CoinsPaid's returned URL. API requests are signed with
  `X-Processing-Key` (public key) + `X-Processing-Signature`
  (`hash_hmac('sha512', json_encode($params), secret_key)`).
- **Callback → settle:** `onNotify()` parses `foreign_id` → order id (strips the
  trailing `-{time}`), then calls `validateCallback($body, $headers)`, which
  recomputes the HMAC-SHA512 signature with the secret key and **throws unless
  both the `x-processing-key` matches the configured public key and the
  `x-processing-signature` matches** — so no order/payment mutation happens for an
  invalid signature. On `status === 'confirmed'` it creates a **completed**
  `commerce_payment` whose **amount is the order's own total**
  (`$order->getTotalPrice()`), not any callback-supplied amount; on `status ===
  'error'` it sets the order state to `cancelled`.
- API base URLs are hardcoded per env (`test` → sandbox, `live` → es.cryptoprocessing.com);
  cURL uses default TLS verification.

Positive posture: HMAC-SHA512 callback signature verified (throws on mismatch, no
payment recorded); payment amount taken from the server-side order total, not the
callback body; TLS verification on by default.

## Solution docs

- **Gateway plugin, offsite form, CoinspaidService API, callback verification** →
  [payment-gateway/offsite-redirect.md](payment-gateway/offsite-redirect.md)
