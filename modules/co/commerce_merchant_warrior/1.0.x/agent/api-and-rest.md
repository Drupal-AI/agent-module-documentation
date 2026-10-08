<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API client & REST endpoints

## API client — `src/Api/MerchantWarriorApi.php`

Service `commerce_merchant_warrior.api_client` (interface `MerchantWarriorApiInterface`).
Constructed with `config.factory`, `http_client` (Guzzle), `request_stack`. Reads gateway
credentials from `commerce_payment.commerce_payment_gateway.merchant_warrior_payframe`
(`configuration.merchant_uuid` / `api_key` / `api_passphrase` / `mode`). Logger channel
`commerce_merchant_warrior`.

### Endpoint constants (all HTTPS)

| Purpose | Test (`mode: test`) | Production |
|---|---|---|
| Direct API (`getApiUrl`) | `https://base.merchantwarrior.com/post/` | `https://api.merchantwarrior.com/post/` |
| Token API (`getTokenApiUrl`) | `https://base.merchantwarrior.com/token/` | `https://api.merchantwarrior.com/token/` |
| Payframe submit (`getPayframeSubmitUrl`) | `https://base.merchantwarrior.com/payframe/` | `https://api.merchantwarrior.com/payframe/` |
| Payframe src (`getPayframeSrcUrl`) | `https://securetest.merchantwarrior.com/payframe/` | `https://secure.merchantwarrior.com/payframe/` |

All requests are `POST` with `form_params`, headers `Accept: application/json` +
`Content-Type: application/x-www-form-urlencoded`. Responses are XML — parsed with
`simplexml_load_string()` → JSON → array. Success is `responseCode === '0'` (strict);
otherwise the client logs the MW `responseMessage` and throws `HardDeclineException` (or
`PaymentGatewayException` on transport failure). Only the response message / order id are
logged — never credentials or card data.

### Methods

- **`getAccessToken(): string`** — `method=getAccessToken` (Direct API); returns MW `token`.
- **`processAuthorization($data)`** — `method=processAuth` (Direct API), used by the REST
  authorization endpoint.
- **`processTokenAuthorization($data)`** — `method=processAuth` (Token API), auth-only.
- **`processTokenCard($data)`** — `method=processCard` (Token API), auth + capture.
- **`processCapture($data)`** — `method=processCapture` (Direct API).
- **`processVoid($data)`** — `method=processVoid` (Direct API).
- **`refundCard($data)`** — `method=refundCard` (Direct API).
- **`verifyCard($data)`** — `method=verifyCard` (Direct API); signs with the message hash
  header (below); used to register a Payframe card token.
- **`cardInfo($data)`** — `method=cardInfo` (Token API); returns BIN / last-4 / expiry.

### Request signing (two hashes)

- **Transaction hash** (`generateHash()`, private): concatenates `md5($api_passphrase)` +
  `merchant_uuid` + `transactionAmount` + `transactionCurrency` (for void: +
  `transactionID`), lowercases, then `md5()`. Sent as the `hash` form param on
  processAuth / processTokenCard / processCapture / processVoid / refundCard. This is
  Merchant Warrior's documented transaction-hash scheme.
- **Message hash** (`generateMessageHash()`, private): `ksort()`s the params, builds an
  RFC1738 query string, url-decodes it, then `hash_hmac('sha256', $query_string,
  $api_passphrase)` lowercased. Sent as the `MW-MESSAGEHASH` request header on `verifyCard`.

These hashes authenticate the module's outbound requests to Merchant Warrior; the design is
on-site (server-to-server over TLS) with no off-site browser callback in the trust path.

## REST endpoints

Both are core `RestResource` plugins installed via
`config/install/rest.resource.*.yml` with `authentication: [cookie]`, `formats: [json]`.
Being REST resources, each is additionally gated by its per-resource permission
(`restful get merchant_warrior_get_access_token_resource`,
`restful post merchant_warrior_process_authorization`), which is granted to no role until an
admin grants it — so neither endpoint is anonymous by default.

### `GET /api/merchant-warrior/get-access-token`

`src/Plugin/rest/resource/MerchantWarriorGetAccessToken.php`. Returns
`{ token, payframeSubmitUrl, payframeSrcUrl }` — a fresh MW access token (server-side via
the merchant UUID + API key) plus the Payframe URLs for the current mode. It does **not**
return the merchant UUID, API key, or passphrase.

### `POST /api/merchant-warrior/process-authorization`

`src/Plugin/rest/resource/MerchantWarriorProcessAuthorization.php`. Body params:

```json
{
  "order_uuid": "…",
  "merchant_warrior_access_token": "…",
  "merchant_warrior_payframe_token": "…",
  "merchant_warrior_payframe_key": "…"
}
```

Missing any of the four → HTTP 401. It loads the order by `order_uuid`, then:

- computes the amount **server-side** from `$order->getTotalPrice()` (rounded) — the request
  never supplies the amount;
- calls `processAuthorization()` (Direct API) with the order/billing data + Payframe token;
- on a response carrying `transactionID` + `cardID`, `createOrderPayment()` creates a
  reusable `credit_card` payment method (storing only card type / last 4 / expiry) and a
  Commerce payment in `authorization` state, then returns `{ order_id, order_uuid,
  order_number, status: 0 }`. The front end then places the order.
- Errors return HTTP 500 with a status/message payload; failures are logged (message only).

## Decoupled flow (README + source)

1. `GET get-access-token` → `token` + Payframe URLs.
2. Front end loads the Payframe iframe, collects card data, calls MW `getPayframeToken` →
   `payframeToken` + `payframeKey` (card data stays in the iframe).
3. `POST process-authorization` with `order_uuid` + token/key → authorizes the order total,
   creates the Commerce payment.
4. Front end places the order.
