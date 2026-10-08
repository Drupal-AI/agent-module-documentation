<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Conductor — proxy, HTTP client & settings API

## The proxy endpoint

Route `conductor.proxy` (`conductor.routing.yml`):

```
path: /conductor/proxy
methods: [GET, PUT, POST, DELETE]
requirements: { _permission: 'use conductor' }
options: { no_cache: TRUE }
```

`ConductorPathProcessor` (inbound path processor, priority 200) turns `/conductor/proxy/<rest-of-path>`
into the base path `/conductor/proxy` with `?resource=<rest-of-path>` when no `resource` query is
already present, so an arbitrary-depth Conductor path rides on one route.
`ConductorProxyController::proxy()` reads `resource` and calls
`ConductorHttpApiClient::forward($resource, $request)`.

`ConductorRouteOptionsEventSubscriber` (on `RoutingEvents::ALTER`) sets `_disable_route_normalizer =
TRUE` on `conductor.proxy*` routes so the path-with-query form keeps working when the Redirect module's
normalizer is active.

## ConductorHttpApiClient

Service `Drupal\conductor\ConductorHttpApiClient` (alias `conductor.http_api_client`). Constructor args
(`conductor.services.yml`): a Guzzle `conductor.http_client` (built from `http_client_factory` with
`stream: true` and `base_uri` = parameter `conductor.api_base_url` = `https://api.conductor.com/`), the
PSR-7 → HttpFoundation factory, config factory, the `conductor` logger channel, current user, default
cache, the Key repository, and the base-URL string.

### forward(string $resource, Request $request): Response

- Copies request headers, dropping `host` and `authorization`; strips `br` from `accept-encoding`
  when `brotli_uncompress` is unavailable (a DDEV note in source).
- Copies query params except `resource`.
- Builds Guzzle options: `headers`, `query` (passthrough + injected auth), `timeout` 30,
  `connect_timeout` 30, `http_errors: FALSE`; adds `body` = raw request content for non-GET/HEAD.
- `applyAuthentication()` injects the credential: `Authorization: Bearer <api_token>` when a token is
  configured, otherwise `apiKey` + `sig` query params (legacy).
- If `Accept` contains `application/x-ndjson`, switches to `forwardAsStream()` (stream, no content
  decode, 60 s header + 60 s read timeouts), returning a `StreamedResponse` that relays the upstream
  body line-by-line with `Content-Type` NDJSON, `Cache-Control: no-cache, no-transform`,
  `X-Accel-Buffering: no`. A mid-stream stall/timeout appends an in-band `{"error": …}` line (headers
  are already sent). Connect failures map to 504 (timed out) or 503; the exception message is dropped
  on purpose because Guzzle embeds the full request URI (which for legacy auth carries `apiKey`/`sig`).
- Otherwise does one Guzzle `request()` and converts the PSR-7 response via `HttpFoundationFactory`.
- `ConductorCredentialsNotFoundException` → 401 JSON; other exceptions → 500 JSON.

Upstream target is always `getUri($resource)` = `rtrim(baseUrl,'/') . '/' . ltrim($resource,'/')`, so
requests are constrained to the fixed `api.conductor.com` host.

### Credentials & signature

- `getCredentials()` — reads `conductor.settings:key_id`, loads the Key (`key.repository->getKey()`),
  `json_decode`s its value, and requires either a non-empty `api_token` or both `api_key` and
  `shared_secret`; otherwise throws `ConductorCredentialsNotFoundException`. Returns an `array_filter`
  of the present fields.
- `applyAuthentication(array &$options, array $credentials)` — bearer token takes priority; else adds
  `apiKey` + `constructSignature()` to the query.
- `constructSignature()` — returns `md5($api_key . $shared_secret . time())` (Conductor's documented
  legacy request-signing scheme).
- `getAccountId()` — `GET v3/accounts`, caches the first `accountId` per user (cache key
  `conductor_api:account_id:user:<uid>`, tagged by user and by `conductor_api:account_id`); throws
  `ConductorCredentialsNotFoundException` if none.

### Other client methods (cron cleanup / dashboard)

- `getExistingDrafts()` — `GET v3/accounts/{acct}/drafts/writing-assistant`.
- `deleteDraft($draftId)` — `DELETE v3/accounts/{acct}/drafts/{draftId}/writing-assistant`.

## Settings API

Route `conductor.api.settings` `/conductor/api/settings` (GET, `use conductor`, `no_cache`).
`ConductorSettingsApiController::__invoke` returns `{accountId, maxDrafts, usedDrafts}` (accountId from
`getAccountId()`, the counts from `DraftRepository`). Credential errors → 401, others → 500. It does
not return the key value or the credentials themselves.
