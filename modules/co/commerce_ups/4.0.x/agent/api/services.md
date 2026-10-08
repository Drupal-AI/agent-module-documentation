# Services & rate/token flow

Defined in `commerce_ups.services.yml`:

| Service id | Class | Role |
|---|---|---|
| `commerce_ups.ups_rate_request` | `UPSRateRequest` (implements `UPSRateRequestInterface`) | Builds the Shop rate request from a `ShipmentInterface`, applies rate type/multiplier and rounding (`@commerce_price.rounder`), returns `ShippingRate[]`. |
| `commerce_ups.ups_sdk_factory` | `UPSSdkFactory` (`UPSSdkFactoryInterface`) | Produces a per-credential configured `UPSSdk` (cloned prototype) with an OAuth2-wired Guzzle client. |
| `commerce_ups.ups_sdk` | `UPSSdk` (`UPSSdkInterface`, prototype) | Performs the HTTP calls (get access token, Shop rates); injected `@cache.ups`, `@commerce_ups.logger`. |
| `commerce_ups.logger` | `LoggerChannel` (`commerce_ups`) | Logging channel used when request/response logging is enabled. |
| `cache.ups` | cache bin | Caches rate responses (`UPSSdkInterface::RATE_CACHE_DURATION = 3600`s). |

## Interfaces / constants (`UPSSdkInterface`)
- `UPS_ACCESS_TOKEN_URL = '/security/v1/oauth/token'`
- `UPS_API_SHOP_RATE_URL = '/api/rating/v1/Shop'`
- `RATE_CACHE_DURATION = 3600`
- Methods: `setClient()`, `setConfiguration()`, `getAccessToken(): ResponseInterface`,
  `setShipment()`, `setShippingMethod()`, `setNegotiatedRates(bool)`,
  `setLogProcess(bool $req, bool $resp)`, `getShipmentShopRates(): array`,
  `getServiceName(string $service): string`.

`UPSRateRequestInterface`: `setConfig(array $configuration): void`,
`getRates(ShipmentInterface $shipment, ShippingMethodInterface $method): array`.

## Authentication flow (`UPSSdkFactory::getClient`)
1. Base URI chosen from `mode` (live → `UPSSdkFactoryInterface::UPS_PRODUCTION_BASE_URL`, else
   integration).
2. A Guzzle client + `sainsburys/guzzle-oauth2-plugin` `OAuthMiddleware` is built with a custom
   `ClientCredentials` grant (`src/ClientCredentials.php`), config
   `client_id`/`client_secret`/token URL and a `token_key = TOKEN_KEY.md5(client_id.secret)`.
3. A previously stored token (Drupal `state`, key `token_key`) is reused if present; the
   middleware handles expiry and retries (`onFailure(2)`).
4. `ClientCredentials::getToken()` persists the new token (`token`/`type`/`expires`) into `state`
   for reuse across requests; `clearToken()` deletes it after a failure.

Because the token cache key hashes the credentials, multiple UPS shipping-method instances with
different credentials keep independent cached tokens. To fetch rates programmatically, resolve
`commerce_ups.ups_rate_request`, `setConfig($method_config)`, then
`getRates($shipment, $shipping_method)`.
