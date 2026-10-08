<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Pei REST client (`src/Api/`)

Service `pei` = `Drupal\commerce_pei\Api\PeiApi` (defined in `commerce_pei.services.yml`,
args `@config.factory`, `@http_client`, `@logger.channel.commerce_pei`). Injected into the gateway
plugin and the add-method form. All calls use Drupal's core `http_client` (Guzzle) — TLS
verification at defaults (enabled), `ALLOW_REDIRECTS => FALSE`, `HTTP_ERRORS => TRUE`.

## `PeiApi` (`PeiApi.php`)

Constructor reads `commerce_payment.commerce_payment_gateway.pei` config (`configuration` key) and
builds:

- `authorizer` = `PeiApiAuthorization` (OAuth token provider),
- `merchantId` (from config),
- `baseUrl` via `match($mode)`: `live` → `https://api.pei.is`, `test` →
  `https://externalapistaging.pei.is`, anything else → `InvalidRequestException`,
- resources `orders` = `Orders`, `purchaseAccess` = `PurchaseAccess`.

`request(string $method, string $path, ?array $data, ?array $query): mixed` — sets
`Accept`/`Content-Type` = `application/json` and `Authorization: bearer {token}` (token fetched
lazily via `authorizer->getToken()`), JSON-encodes `$data`, adds `$query`, dispatches GET/POST
(other methods throw), and returns `parseResponseBody()`. Guzzle `RequestException` is routed to
`PeiApiException::handle()`.

## `PeiApiAuthorization` (`PeiApiAuthorization.php`)

OAuth2 **client-credentials** grant. Token URL via `match($environment)`:
`live` → `https://auth.pei.is/core/connect/token`, `test` →
`https://authstaging.pei.is/core/connect/token`. Request options
(`prepareRequestOptions`): HTTP **Basic auth** `[client_id, secret]` (Guzzle `RequestOptions::AUTH`
— credentials go in the Authorization header, not the URL), form params
`grant_type=client_credentials`, `scope=externalapi`.

- `getToken()`: caches the token in memory; refetches only when the cached value is null.
  (Expiry is not tracked — there is a `// OR IF EXPIRED` TODO; a stale token simply triggers a
  fresh auth on the next 401-driven retry path in practice.)
- `validate($env, $client_id, $secret)`: used by the gateway config form to test credentials;
  returns bool, swallowing `PaymentGatewayException`.
- Auth failures throw `AuthenticationException('Could not acquire a Pei access token.')`.

## Resources

`ResourceBase::endpoint($param)` builds `api/{TYPE}/{param}`.

- **`Orders`** (`TYPE = 'orders'`): `submit(PaymentInterface): string` → POST `api/orders/pay`.
  Body = `merchantId`, `buyer` (`name` from billing address given/family name, `ssn` from the
  payment method `issn`, `email` from the order, `mobileNumber` from the payment method
  `telephone`), `amount` = `$payment->getAmount()->getNumber()` (bound to the order's payment
  amount; no currency code is sent — Pei is ISK), `reference` = order id, empty
  `successReturnUrl`/`cancelReturnUrl`/`postbackUrl`, and `items[]` (`code`=SKU, `name`, `quantity`,
  `unit`='units', `unitPrice`, `amount`=adjusted total). Returns Pei `orderId`; missing/empty →
  `InvalidResponseException`.
- **`PurchaseAccess`** (`TYPE = 'purchaseaccess'`): `hasAccess($ssn): bool` (GET, query
  `merchantId` + `buyerSsn`); `requestAccess($ssn, $mobile)` (POST — Pei SMSes a PIN);
  `confirmAccess($ssn, $pin)` (POST — buyer confirms merchant access with the PIN). All keyed by
  `merchantId`.

## Response & error handling

- `ResponseTrait::parseResponseBody()` JSON-decodes, unwrapping a doubly-encoded JSON string in a
  loop until it is no longer a string (returns the last non-null value).
- `PeiApiException` extends `PaymentGatewayException`. `handle()` logs the error (status code,
  message, trace, reason phrase — via `logger.channel.commerce_pei`) and maps HTTP status →
  Commerce exception: `400/404/405` → `InvalidRequestException`, `401` →
  `AuthenticationException`, `403` → `DeclineException`, `5xx` → `InvalidResponseException`, else
  base. `message()` maps a Pei numeric `code` (≈55 codes `10001`–`10055`, e.g. credit rating,
  buyer allowance, invalid PIN, card declined) to a translated human message.
