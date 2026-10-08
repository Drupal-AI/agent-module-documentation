<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce National Bank of Greece (Redirect) (commerce_nbg_redirect) — agent index

**Off-site *redirect* payment gateway for the National Bank of Greece (NBG), Greece** for Drupal
Commerce. NBG card acquiring is delivered through the **GlobalPayments Hosted Payment Page (HPP)**:
at the checkout "payment" step the module asks the GlobalPayments GP-API to mint a *Pay-by-Link* /
hosted-payment-page URL and redirects the shopper there; the shopper pays on GlobalPayments'
hosted page; GlobalPayments then POSTs a signed notification back to a module callback, which
records a Commerce payment. No card data touches the Drupal side.

Package `Commerce`. `type: module`. Core `^11`. License GPL-2.0-or-later.
Installed version **1.0.3** (version dir `1.0.x`). Composer `drupal/commerce_nbg_redirect`.

## Dependencies

- Drupal modules (`.info.yml`): **`commerce:commerce`**, **`commerce:commerce_payment`**.
- PHP library (`composer.json` `require`): **`globalpayments/php-sdk: ^14.0.4`** — the official
  GlobalPayments PHP SDK, used to build the hosted-payment-page link. This is a real dependency,
  not optional; Composer pulls it in automatically.

## What it provides (from source)

- **Payment gateway plugin** `nbg_redirect`
  (`src/Plugin/Commerce/PaymentGateway/OffsiteRedirect.php`), extends
  `OffsitePaymentGatewayBase` and is declared with the PHP-attribute
  `#[CommercePaymentGateway(...)]`. `modes = {test, live}`;
  `payment_method_types = {credit_card}`;
  `credit_card_types = amex, dinersclub, discover, jcb, maestro, mastercard, visa, unionpay`;
  `requires_billing_information = FALSE`. Declares one form:
  `offsite-payment` → `PaymentOffsiteForm`.
  - **Config fields** (schema in `config/schema/commerce_nbg_redirect.schema.yml`, type
    `commerce_payment_gateway_configuration`): `country_code` (merchant country, default `GR`),
    `merchant_id`, `app_id`, `app_key` — plus the base `mode` and display fields.
    `app_id` / `app_key` are the GlobalPayments GP-API application credentials; `app_key` also
    signs/verifies the callback. (Note: `country_code` is used by the plugin and stored, though
    the schema file only lists `merchant_id, country_code, app_id, app_key`.)
  - `onReturn(OrderInterface, Request)` — the browser-return handler (see below).
- **Offsite redirect form** `PluginForm/OffsiteRedirect/PaymentOffsiteForm`
  (`buildConfigurationForm` → `createPayByLinkUrl`) — configures the GP-API
  (`GpApiConfig` with `appId`, `appKey`, `country`, `channel = CardNotPresent`,
  `environment = PRODUCTION|TEST` from `mode`), builds a `PayerDetails` from the order's billing
  profile + email, then calls `HPPBuilder::create()` (name, description, reference,
  order-reference, amount, currency, payer, notifications, 3-D Secure challenge preference,
  Google Pay / Apple Pay wallets) and `->execute()`. Redirects the browser to
  `$response->payByLinkResponse->url`. The `order-reference` is
  `order_<order id>_<gateway plugin id>_<random>`; it is echoed back in the notification and used
  to locate the order + gateway on return.
- **Callback / return controller** `Controller/CommerceNbgRedirectController::returnUrl`
  (route `commerce_nbg_redirect.return_url`, path `/commerce-nbg-redirect/return-url`,
  `_access: 'TRUE'`, `methods: [POST]`, `no_cache: TRUE`). GlobalPayments POSTs the payment
  result here (the same URL is registered as success, failure and notification target in the
  HPP builder). It **recomputes a SHA-512 digest over the payload keyed with the merchant
  `app_key` and rejects the request with 403 on mismatch**, then stores the result on the order
  and renders a small auto-redirect page that sends the browser to
  `commerce_payment.checkout.return`. See [payment-flow.md](payment-flow.md).
- **Theme + template** `hook_theme()` registers `commerce_nbg_redirect_return`
  (`templates/commerce-nbg-redirect-return.html.twig`) — a minimal HTML page whose inline
  `window.location.replace()` forwards the browser to the Commerce checkout return step.

## What it does NOT provide

- No `.permissions.yml`, no `.services.yml`, no `.install`, no `.api.php`, no hooks other than
  `hook_theme()`. No Drush commands. No admin settings route of its own (configuration is per
  payment-gateway entity, under Commerce → Payment gateways).

## Security posture (payment gateway)

Sound. The callback recomputes `hash('sha512', <minified JSON payload> . app_key)` and rejects the
request (`AccessDeniedHttpException`, 403) when it does not equal the `X-GP-Signature` header —
the merchant `app_key` is a server-side secret, so a caller who does not know it cannot forge a
"paid" notification. The order id and gateway id used on return are taken from the notification's
`reference` field, which is *inside* the signed body, so they cannot be re-pointed without breaking
the signature. Payment creation happens only in `onReturn()`, gated on
`result_code === 'SUCCESS'` in the order data that only the signature-validated callback can set,
and the recorded amount is the **server-side order balance** (`$order->getBalance()`), never a
request-supplied amount. No direct outbound HTTP in module code (TLS is the GP SDK's concern); no
user-supplied URL is fetched (no SSRF); no secrets are written to dblog. Operational rules: keep
`app_key` secret (env-backed / Key entity), serve the callback over HTTPS, and restrict who can
administer payment gateways. See [payment-flow.md](payment-flow.md).

## Solution docs

- **HPP link build, callback signature verification, return handling, config fields** →
  [payment-flow.md](payment-flow.md)
