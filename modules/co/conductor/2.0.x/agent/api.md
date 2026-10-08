<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Conductor — proxy, HTTP client & credentials

## The proxy endpoint

Route `conductor.proxy` (`conductor.routing.yml`):

```
path: /conductor/proxy
methods: [GET, PUT, POST, DELETE]
requirements: { _permission: 'use conductor' }
options: { no_cache: TRUE }
```

`ConductorPathProcessor` (inbound path processor, priority 200) turns
`/conductor/proxy/<rest-of-path>` into the base path `/conductor/proxy` with `?resource=<rest-of-path>`
when no `resource` query is already present. This lets an arbitrary-depth Conductor path ride on one
route. `ConductorProxyController::proxy()` reads `resource` and calls
`ConductorHttpApiClient::forward($resource, $request)`.

`ConductorRouteOptionsEventSubscriber` (on `RoutingEvents::ALTER`) sets
`_disable_route_normalizer = TRUE` on `conductor.proxy*` routes so the path-with-query form keeps
working when the Redirect module's normalizer is active.

## ConductorHttpApiClient

Service `Drupal\conductor\ConductorHttpApiClient` (alias `conductor.http_api_client`). Constructor args
(`conductor.services.yml`): a Guzzle `conductor.http_client` (built from `http_client_factory` with
`stream: true` and `base_uri` = parameter `conductor.api_base_url` = `https://api.conductor.com/`), the
PSR-7 → HttpFoundation factory, config factory, the `conductor` logger channel, current user, default
cache, the Key repository, and the base-URL string.

### forward(string $resource, Request $request): Response

- Copies request headers (drops `host`); strips `br` from `accept-encoding` when
  `brotli_uncompress` is unavailable (DDEV note in source).
- Copies query params except `resource`.
- Builds Guzzle options: `headers`, `query` = `{apiKey, sig, ...passthroughQuery}`, `timeout` 30,
  `connect_timeout` 30, `http_errors: FALSE`; adds `body` = raw request content for non-GET/HEAD.
- If `Accept` contains `application/x-ndjson`, switches to `forwardAsStream()` (stream + no content
  decode), returning a `StreamedResponse` that relays the upstream body line-by-line with
  `Content-Type` NDJSON, `Cache-Control: no-cache, no-transform`, `X-Accel-Buffering: no`,
  chunked transfer.
- Otherwise does one Guzzle `request()` and converts the PSR-7 response to a Symfony response via
  `HttpFoundationFactory`.
- `ConductorCredentialsNotFoundException` → 401 JSON; other exceptions → 500 JSON.

Upstream target is always `getUri($resource)` = `rtrim(baseUrl,'/') . '/' . ltrim($resource,'/')`, so
requests are constrained to the fixed `api.conductor.com` host.

### Credentials & signature

- `getCredentials()` — reads `conductor.settings:key_id`, loads the Key
  (`key.repository->getKey()`), `json_decode`s its value, and requires non-empty `api_key` and
  `shared_secret`; otherwise throws `ConductorCredentialsNotFoundException`.
- `constructSignature()` — returns `md5($api_key . $shared_secret . time())` (Conductor's documented
  request-signing scheme). Every call also sends `apiKey`.
- `getAccountId()` — `GET v3/accounts`, caches the first `accountId` per user (cache key
  `conductor_api:account_id:user:<uid>`, tagged by user); throws if none.

### Other client methods (used by cron cleanup / dashboard)

- `getExistingDrafts()` — `GET v3/accounts/{acct}/drafts/writing-assistant`.
- `deleteDraft($draftId)` — `DELETE v3/accounts/{acct}/drafts/{draftId}/writing-assistant`.

## Settings API

Route `conductor.api.settings` `/conductor/api/settings` (GET, `use conductor`).
`ConductorSettingsApiController` returns `{accountId, maxDrafts, usedDrafts}`; credential errors → 401,
others → 500.
