# Client service — `trustpilot_api.client` (API)

`Drupal\trustpilot_api\TrustpilotApiClient` implements `TrustpilotApiClientInterface`. Constructor
args (from `trustpilot_api.services.yml`): `@config.factory`, `@http_client_factory`,
`@trustpilot_api.endpoint_plugin_manager`, `@serialization.json`, `@logger.factory`,
`@cache.default`.

The Guzzle client is built once in the constructor with:
`base_uri = https://api.trustpilot.com/v1/`, header `apiKey = <config api_key>`, and
`connect_timeout = (float) client_connect_timeout`. TLS is **not** disabled anywhere (no `verify`
override) — Guzzle's default certificate verification applies.

## Basic call

```php
/** @var \Drupal\trustpilot_api\TrustpilotApiClientInterface $client */
$client = \Drupal::service('trustpilot_api.client');

$endpoint = $client->getEndpointPluginManager()->createInstance('business_unit_reviews');

// Returns the decoded-JSON body as a PHP array (or [] on non-200 / connect error).
$data = $client->request($endpoint, [
  'businessUnitId' => 'abc123',   // or rely on the default in config
  'perPage' => 3,
  'stars' => [3, 4, 5],
]);
```

## `request(EndpointPluginInterface $endpoint, array $params = [])`

Flow (`TrustpilotApiClient.php:125`):

1. `$endpoint->setRequestParams($params)` — merges defaults, fills `businessUnitId` from
   `trustpilot_api.settings:business_unit_id` when the endpoint requires it and none was passed, then
   `array_filter`s out empty (`''` / `[]`) values.
2. Builds the Guzzle query from the endpoint params and its `getHeaders()`.
3. If `getRequestAuthType() === 'oauth'`, calls `getAccessToken()` and adds `query['token'] = <access token>`.
4. Options: `http_errors => FALSE`, `query`, `headers`, and an `on_stats` callback capturing the
   effective URI.
5. For `POST` endpoints, the **raw `$params`** (pre-filter) are sent as the JSON body
   (`RequestOptions::JSON`).
6. Performs the request against `getRequestPath()` (the annotation `path` with `[required]`
   placeholders substituted). `ConnectException` is caught, logged, and returns `[]`.
7. If `logging_enabled`, logs an `info` line (endpoint id, status, effective URI) to the
   `trustpilot_api` channel.
8. Returns `json::decode($response->getBody())` on HTTP 200, else `[]`.

Return value is always an array; there is no typed response object and no automatic caching of
response bodies (only the OAuth token is cached).

## OAuth (private endpoints)

For `authType = oauth` endpoints the client manages a bearer token itself:

- `getAccessToken()` reads cid `trustpilot_api.oauth_access_token` from `cache.default`; if absent it
  calls `requestNewAccessToken()` (password grant), if expired it calls `refreshAccessToken()`
  (refresh-token grant). Tokens are re-cached with `expiresAt()` as the cache expiry.
- Token exchange (`requestAccessToken()`) POSTs to
  `https://api.trustpilot.com/v1/oauth/oauth-business-users-for-applications/accesstoken` with Guzzle
  `auth => [api_key, api_secret]` (HTTP basic) and `form_params` (`grant_type`, plus
  `username`/`password` or `refresh_token`). On non-200 it throws
  `Exception\RequestOAuthAccessTokenFailed`.
- `OAuthToken` (`OAuthToken.php`) holds `accessToken`/`refreshToken`/`lifespan`/`expiresAt`;
  `isExpired()` treats the token as expired 10 minutes early. Its `unserialize()` uses
  `allowed_classes => FALSE`.

Call `canAuthorizePrivate()` first to check that `api_key`, `api_secret`, `oauth_email`,
`oauth_password` are all present before invoking an OAuth endpoint.

## Adding endpoints / listing them

See [../plugins/endpoint.md](../plugins/endpoint.md) for the `@Endpoint` annotation, how to add a new
endpoint plugin, and the full list of the 26 bundled endpoint ids.
