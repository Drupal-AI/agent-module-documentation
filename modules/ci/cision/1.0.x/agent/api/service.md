<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# cision.api service — `Drupal\cision\Api`

`final class Api` in `src/Api.php`, registered as `cision.api` in `cision.services.yml`. A thin client
for the Cision Next Generation Communications Cloud API.

## Constructor / dependencies
Injected: `@http_client` (Guzzle `ClientInterface`), `@state`, `@key.repository`, `@date.formatter`,
`@cache.default`.

## Constants
- `BASE_URL = 'https://api.trendkite.com/api'`
- Endpoints: `LOGIN_API '/login'`, `TOTALMENTIONS '/v2.2/totalmentions'`, `SEARCH_API '/v2.2/searches'`,
  `STATS_API '/v2.2/stats'`.
- `AUTH_HEADER = 'X-Auth-Token'`, `DATE_FORMAT = 'Y-m-d\TG:i:s.vp'`.
- `CACHE_EXPIRATION = 3600` (1h response cache), `AUTH_TOKEN_EXPIRATION = 240` (token TTL in state).

## Authentication (`getAuthToken()`, private)
1. Reads cached token from state key `cision.auth_token`; returns it if `expires > time()`.
2. Otherwise reads `cision_username` / `cision_password` via `KeyRepository::getKey(...)->getKeyValue()`.
   Returns `NULL` if either is empty.
3. `login()` POSTs `{username, password}` as JSON to `/login` (`http_errors => FALSE`). On HTTP 200 it
   decodes the body and stores `access_token` in state with a 240s expiry, then returns the token.

## Public methods
- `getTotalMentions($s, int $range_start, int $range_end, int $page_num = 0, int $page_size = 100, $sort = 'desc', $gaid = NULL)`
  — GET `/v2.2/totalmentions` with the auth token in the `X-Auth-Token` header and a query built from the
  search id `s`, formatted date range, paging, `sort` (coerced to `asc`/`desc`), `format=json`, optional
  `gaid`. Result cached under `cision:totalmentions:<md5(serialize(query))>`. Returns decoded array or `NULL`.
- `getSearches($shared = TRUE)` — GET `/v2.2/searches?shared=true|false`; returns the `searches` array,
  cached. (Note: its `$cid` concatenation `'cision:searches:' . $shared ? 'true' : 'false'` binds as
  `('cision:searches:' . $shared) ? ...`, so the cid is effectively the string `'true'` — a latent bug,
  not a security issue.)
- `getSearchesOptions(): array` — maps `getSearches()` to `[id => title]` for use as form `#options`;
  cached under `cision:searchesOptions`.
- `getStats($s, int $range_start, int $range_end, $type = 'all')` — GET `/v2.2/stats`; `$type` is
  whitelisted to `ave` | `readership` | `totalMentions` | `socialShares` | `all`. Cached. Returns
  decoded array or `NULL`.

All GETs use `http_errors => FALSE` and return `NULL` on non-200. Requests go over HTTPS through Drupal's
`http_client` (standard TLS verification).

## Using it from custom code
```php
$api = \Drupal::service('cision.api');
$mentions = $api->getTotalMentions($search_id, strtotime('-30 days'), time());
$stats = $api->getStats($search_id, strtotime('-30 days'), time(), 'ave');
```
