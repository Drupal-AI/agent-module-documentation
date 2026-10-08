<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# HootsuiteAPIClient — OAuth2 + REST client

Service `assignments_hootsuite.client`, class `Service\HootsuiteAPIClient` implements `HootsuiteAPIClientInterface`. Constructor args (services.yml): `@config.factory`, `@logger.factory`, `@http_client` (Guzzle `ClientInterface`), `@messenger`, `@state`. Reads config object `assignments_hootsuite.settings`; logs to channel `assignments_hootsuite`.

## Methods

### `createAuthUrl(): string`
Builds the OAuth2 authorization URL: `url_auth_endpoint . '?' . http_build_query([...])` with `response_type=code`, `client_id`, `scope=offline`, and `redirect_uri = <scheme>://<host>/assignments_hootsuite/callback` (scheme/host derived from `$_SERVER['HTTP_HOST']`).

### `getAccessTokenByAuthCode(string $code = NULL): bool`
Two paths against `url_token_endpoint` (POST) with HTTP Basic auth header `base64(client_id:client_secret)` and `Content-Type: application/x-www-form-urlencoded`:
- **With `$code`** — `grant_type=authorization_code`, form params `code`, `redirect_uri`, `scope=offline`. On HTTP 200 + `access_token` present, stores `hootsuite_access_token` and `hootsuite_refresh_token` in state, returns TRUE.
- **No `$code` but a stored `hootsuite_refresh_token`** — `grant_type=refresh_token`, sends the stored refresh token; on HTTP 200 refreshes both stored tokens.
Guzzle exceptions are caught, logged, surfaced via messenger, and return FALSE.

### `connect(string $method, string $endpoint, string $query = NULL, array $body = NULL): mixed`
Generic authenticated REST call. Sends `Authorization: Bearer <hootsuite_access_token>` (+ `Content-Type: application/json`); JSON-encodes `$body` into the request body and passes `$query` as query params. Calls `$this->httpClient->{$method}($endpoint, $options)` (`$method` ∈ get/post/put/delete). On a caught `401 Unauthorized` (or a response status 400/401/403) it calls `getAccessTokenByAuthCode()` to refresh and **retries once** recursively; a caught `400 Bad Request` is logged and returns FALSE. Returns the Guzzle response **body stream** (callers do `Json::decode($response)` or `$response->getContents()`), or FALSE on failure.

### `getHttpClient(): ClientInterface`
Exposes the raw Guzzle client (used by `HootsuitePostManager::uploadToAws()` for the direct PUT to Hootsuite's returned upload URL).

## Notes for agents
- Tokens are **state**, not config, so they are not exported by config sync and not shown on the form.
- Requests use Drupal's shared `@http_client` (Guzzle) with default options — TLS verification is on; no per-call `verify`/proxy overrides.
- The client rolls its own OAuth2 token handling; despite the `oauth2_client` dependency it does not use that module's client for token exchange.
- `redirect_uri` is rebuilt from the inbound `Host` header on both the auth URL and the token exchange, so it must match Hootsuite's registered redirect and be reached on the canonical host.
