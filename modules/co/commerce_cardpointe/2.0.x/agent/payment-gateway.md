<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hosted-iframe gateway & CardConnect Gateway API

Plugin `cardpointe_hostediframe` — `src/Plugin/Commerce/PaymentGateway/HostedIframe.php`
(`OnsitePaymentGatewayBase`). Interface `HostedIframeInterface`.

## Configuration (`buildConfigurationForm` / `defaultConfiguration`)

Settings: `site`, `merchant_id`, `api_username`, `api_password`, `iframe_styling.enable_custom`,
`custom_css`, `intent` (`capture` | `authorize`), `log.request` / `log.response`, and a `terminal`
fieldset (`terminal.site`, `terminal.api_key`) used only when the terminal payment-method type is
enabled. `custom_css` is `strip_tags()`-ed on submit. `validateConfigurationForm()` verifies the
credentials by calling `inquireMerchant/{merchant_id}`, and (if the terminal type is enabled) calls
`IntegratedTerminalApi::listTerminals()`; if the terminal type is disabled it clears the terminal
settings.

- API base URL (`getApiUrl`): `https://{site}-uat.cardconnect.com` for mode `uat`, else
  `https://{site}.cardconnect.com`. Request URL (`buildRequestUrl`): `{base}/cardconnect/rest/{request}`.

## Charge flow

- **`createPayment($payment, $capture)`** — asserts state `new`. Builds `auth` request:
  `merchid`, unique `orderid` = `{order_id}-{time}`, `account` = payment method `remoteId` (the token),
  **`amount` from `$payment->getAmount()`** formatted to 2 fraction digits, `currency`, `expiry`
  (`YYYYMM`), `capture` = `Y`/`N` from the gateway's `intent` config (not the `$capture` arg),
  `ecomind` (`E`, or `R` for merchant-initiated recurring), and card-on-file flags (`cof`, `cofscheduled`,
  `cofpermission`) for reusable methods. If a CVV is present in private tempstore (`commerce_cardpointe:card_code`,
  set by the checkout CVV field for stored-card reuse), it is added as `cvv2` and then **deleted**.
  Billing profile (name/address/email) is appended. On `respstat === APPROVED` sets state to
  `completed`/`authorization`, stores AVS code + `retref` as remote id.
- **`capturePayment`** — asserts `authorization`; posts `capture` with `retref` + amount (server-side).
- **`voidPayment`** — asserts `authorization`/`completed`; `inquire`s voidability, posts `void`.
- **`refundPayment`** — asserts `completed`/`partially_refunded`; `assertRefundAmount`; `inquire`s
  refundability, posts `refund`; transitions to `partially_refunded`/`refunded`.
- **`createPaymentMethod`** — requires `token` + `expiration`; for a reusable method runs a `$0` `auth`
  to verify the card. Stores only: card type (2nd char of token), **last 4** (`substr(token, -4)`),
  expiry. Remote id = the token.

`ResponseStatus` enum (`src/Enum/ResponseStatus.php`) defines `APPROVED = 'A'` etc.

## CardConnect Gateway API client — `src/GatewayApi.php`

Single method `apiRequest($config, $url, $transaction = [], $method = 'get')`. Sets header
`Authorization: Basic base64(api_username:api_password)` and JSON body, calls the core Guzzle
`http_client` (default TLS verification), JSON-decodes the response. When `log.request` /
`log.response` are enabled it writes debug log entries. Logger channel `commerce_cardpointe`.

## Hosted iframe & JS

`PaymentMethodAddForm::buildCreditCardForm()` embeds an `<iframe>` pointing at
`{base}/itoke/ajax-tokenizer.html` (query flags: `useexpiry`, `usecvv`, expiry/CVV validation events,
plus the styling CSS). Hidden `token` + `expiration` fields receive the tokenizer output. `js/hosted-iframe.js`
listens for `postMessage` from the iframe, **validates `event.origin` against the tokenizer URL origin**
(`isValidOrigin`), stores the token, and submits the form once a valid token+expiry is present (with a
5-second timeout and validation-error handling). The credit-card form defers validation/submit to the
gateway plugin.
