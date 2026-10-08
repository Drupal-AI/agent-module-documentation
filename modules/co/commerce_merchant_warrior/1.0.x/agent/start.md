<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Merchant Warrior (commerce_merchant_warrior) — agent index

A **Drupal Commerce on-site payment gateway** for **Merchant Warrior** (Australian payment
provider). Cards are tokenized client-side in Merchant Warrior's **Payframe** iframe; the
resulting Payframe token is verified and charged **server-side** via Merchant Warrior's
**Direct API** and **Token API**. The module also exposes **two core-REST endpoints** so a
decoupled/headless front end can run the same Payframe flow. Package `Commerce (contrib)`.
Core `^9.5 || ^10 || ^11`. License GPL-2.0-or-later. Installed **1.0.3** (version dir
`1.0.x`).

## Dependencies

- Drupal modules (`.info.yml`): **`commerce`**, **`commerce_payment`**, **`rest`**.
- Composer (`composer.json`): **`drupal/commerce >=2.39`**. No third-party PHP libraries —
  all API calls use the core `http_client` (Guzzle). No `php` constraint declared.
- One external browser asset: Merchant Warrior's `payframe.js`, loaded from
  `securetest.merchantwarrior.com` / `secure.merchantwarrior.com` (`*.libraries.yml`).

## What it provides (from source)

- **One payment gateway plugin** `merchant_warrior_payframe` —
  `src/Plugin/Commerce/PaymentGateway/Payframe.php` (extends `OnsitePaymentGatewayBase`,
  implements `SupportsAuthorizations` + `SupportsRefunds`), label "Merchant Warrior
  Payframe". Payment method type `credit_card`; card types amex/dinersclub/discover/
  mastercard/visa; `requires_billing_information = TRUE`. Implements `createPayment`,
  `capturePayment`, `voidPayment`, `refundPayment`, `createPaymentMethod`,
  `deletePaymentMethod`. Config: `merchant_uuid`, `api_key`, `api_passphrase` (+ base
  `mode`, `display_label`, transaction settings). → [payment-gateway.md](payment-gateway.md)
- **One API client service** `commerce_merchant_warrior.api_client` —
  `src/Api/MerchantWarriorApi.php` (interface `MerchantWarriorApiInterface`). Wraps the MW
  Direct API (`/post/`), Token API (`/token/`) and Payframe URLs; methods
  `getAccessToken`, `processAuthorization`, `processTokenAuthorization`, `processTokenCard`,
  `processCapture`, `processVoid`, `verifyCard`, `cardInfo`, `refundCard`, plus URL getters
  and the two hash generators. → [api-and-rest.md](api-and-rest.md)
- **Two core-REST resources** (`config/install/rest.resource.*.yml`, both
  `authentication: cookie`, `format: json`):
  - `GET /api/merchant-warrior/get-access-token` — returns an access token + Payframe
    submit/src URLs (`MerchantWarriorGetAccessToken`).
  - `POST /api/merchant-warrior/process-authorization` — authorizes an order's total from a
    Payframe token and records the Commerce payment (`MerchantWarriorProcessAuthorization`).
  → [api-and-rest.md](api-and-rest.md)
- **Add-payment-method form** `src/PluginForm/Onsite/PayframePaymentForm.php` (extends
  `PaymentMethodAddForm`) — renders the Payframe container, fetches an access token, and
  attaches the JS. → [payment-gateway.md](payment-gateway.md)
- **JS** `js/commerce_merchant_warrior_payframe.form.js` (library
  `commerce_merchant_warrior/payframe_form`) — instantiates MW's `payframe`, on
  `HAS_TOKEN` writes the token/key into hidden fields and submits the form.
- **Config schema** `config/schema/commerce_merchant_warrior.schema.yml` for the three
  gateway credential settings. No `.module`, no `.install`, no `.permissions.yml`, no
  hook_theme, no Drush.

## Two integration paths

1. **Standard Drupal checkout** — customer enters card in the Payframe on the add-payment
   form; the JS obtains a Payframe token and submits; `createPaymentMethod()` verifies the
   card via the Direct API and `createPayment()` charges via the Token API.
2. **Decoupled / headless** — the front end calls `get-access-token`, drives the Payframe
   itself, then POSTs `order_uuid` + Payframe token/key to `process-authorization`.

Both paths are described in [api-and-rest.md](api-and-rest.md).

## Security posture (positive facts)

- **Amount is server-side.** Every charge/capture/refund amount comes from the Commerce
  `Payment`/`Order` (`$payment->getAmount()`, `$order->getTotalPrice()`), never a request
  parameter — the client cannot set the price.
- **Card data tokenized client-side.** PAN/CVV are entered only in the Payframe iframe; the
  server receives only Payframe tokens. The stored payment method keeps only card type,
  **last 4**, and expiry. No raw PAN/CVV is stored or logged.
- **TLS on.** All Merchant Warrior endpoints are `https://`; calls use the core Guzzle
  `http_client` with default certificate verification (no `verify => false`).
- **Requests signed per MW's protocol.** An md5 transaction hash (over passphrase + UUID +
  amount + currency) signs most operations, and an **HMAC-SHA256** message hash
  (`hash_hmac('sha256', …, $api_passphrase)`) signs card verification.
- **Outcomes from authenticated API responses.** Success is decided by the Direct/Token API
  response (`responseCode === '0'`) over TLS, not by a browser-supplied status — there is no
  off-site redirect/callback in the trust path.
- **REST endpoints gated.** Both resources require authentication (cookie) and the
  per-resource REST permission; neither is anonymous by default.

Store the merchant UUID / API key / API passphrase as secrets (env var or Key entity) and
serve checkout over HTTPS.

## Related docs

- Human setup guide: [`../human-docs/index.md`](../human-docs/index.md)
- One-paragraph overview: [`../usage.md`](../usage.md)
