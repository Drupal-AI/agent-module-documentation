<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cache manager service & Varnish integration

`adv_varnish.cache_manager` (`Drupal\adv_varnish\CacheManager`, interface `CacheManagerInterface`) is
the bridge to Varnish. It is tagged **`cache_tags_invalidator`**, so Drupal cache-tag invalidations
flow through it. There is a deprecated alias `adv_vanish.cache_manager` (original typo) — use the
correct name.

## Purge / invalidation methods

| Method | Effect |
|---|---|
| `invalidateTags(array $tags)` | cache_tags_invalidator entry point; if `general.varnish_purger` is on, converts tags to hashes and BANs them |
| `purgeTags(array $tags): bool` | send a BAN to Varnish for the given cache tags (path `/tags`, header `X-Tag`) |
| `purgeUri(string $uri): bool` | purge a single URI |
| `flushAllCaches(): bool` | full Varnish flush for the site (path `/site`) |
| `deflateCache($number): bool` | "deflate" — progressively reduce TTLs instead of hard purge (path `/deflate`, headers `X-Deflate-Tag`/`X-Deflate-Key`) |
| `purgeUserBlocks()` | on POST (ESI + `esi_purge_user_blocks` + logged-in), purge the `user:id` tag |

Purge requests use HTTP method **`BAN`** (`purgeMethod = 'BAN'`) sent via the core `http_client`.
Every request carries `X-Varnish-Purge: <general.secret>`. `general.varnish_server` may hold multiple
**space-separated** hosts; `sendRequest()` loops over them (prefixing `http://` when a host has no
scheme) and ANDs the per-host results. `singleRequest()` sets a default **5s timeout / 2s
connect_timeout** so a down Varnish never hangs the request, and treats only HTTP 200 as success;
Guzzle exceptions are logged.

Guards:

- Nothing is purged unless **`general.varnish_purger`** is TRUE.
- If the site is in maintenance mode and `general.purger_maintenance_mode` is TRUE, purges are
  skipped (logged at debug level).

## Tag hashing

`cacheTagsToHashes(array $tags): string` compresses each tag (via `compressTag`, using the
`CHARS_INDEX` alphabet) and joins them with `HASHES_SEPARATOR` (a space) to keep the `X-Tag` header
small — this must correspond to the VCL. This is the same hashing applied to the response's tag
header.

## Response headers & TTL

`CacheableResponseSubscriber` (extends core `FinishResponseSubscriber`) + `RequestHandler` call
`CacheManager::getCacheSettings()` / `cachingEnabled()` to decide, per request, whether Varnish
caching applies and to emit the headers. `cachingEnabled()` returns FALSE for: the
`bypass advanced varnish cache` permission, `enable_cache` off, a URL-filter miss/match (per
`url_filter_mode`), authenticated users when `authenticated_users` is off, an active
`page_cache_kill_switch`, a route with `no_cache` (except the ESI routes), and admin routes.

`getCacheSettings()` computes `ttl` from `general.page_cache_maximum_age`, overridden by a node
bundle's `adv_varnish/ttl` third-party setting when `override` is set, then capped by the response's
own `Cache-Control`: `no-store` → 0, `s-maxage=N` → min(N, ttl). It also resolves the
`cache_control` header (first matching `path|header` rule) and the hashed tag list. `RequestHandler`
emits: `X-Grace`, `X-TTL`, `X-Tag`, `X-Adv-Varnish`, `X-Varnish-Secret`, `X-Deflate-Key`,
`Vary: X-Bin`, optional `X-Cache-Debug`, and `X-DOESI` when ESI is enabled. When caching does not
apply, the subscriber instead sets the response non-cacheable and adds `X-Pass-Varnish: YES` and
`X-Adv-Varnish: Cache-disabled`.

## Cache-varying cookies

`adv_varnish.cookie_manager` (`CookieManager`) computes the `ADVBIN` / `ADVINF` cookies that vary the
cache. Anonymous users get an empty bin; authenticated users get a bin derived from their **sorted
role set**, HMAC'd with `general.noise` + the site hash salt (`hash_hmac('sha256', …)`); users with
the bypass permission get a dedicated `bypass_varnish` bin. When the computed bin differs from the
request's cookie, the response is turned into a redirect so the new cookie takes effect (unless a
redirect-forbidden state flag applies, or the request is an ESI callback). This means authenticated
page caching is **per-role**, not per-user — per-user content must be delivered through ESI user
blocks (see [../plugins/user-blocks.md](../plugins/user-blocks.md)).

## ESI helpers

- `esiEnabled()` — TRUE only when `available.esi` is on, the request is not itself an ESI callback,
  and the request carries `Surrogate-Capability: abc=ESI/1.0` (set by Varnish).
- `isEsiRequest()` — TRUE when the request URI is under `/adv_varnish/esi/user_blocks` or
  `/adv_varnish/esi/block`.
- ESI fragments are served by two **static** routes (defined in `adv_varnish.routing.yml`, both
  `_permission: 'access content'`, `no_cache: TRUE`):
  - `adv_varnish.esi_user_block` → `/adv_varnish/esi/user_blocks/{block_id}` (`UserBlocksController::content`)
  - `adv_varnish.esi_block` → `/adv_varnish/esi/block/{block_id}` (`ESIBlockController::content`) —
    renders the placed block entity with `{block_id}`, setting `X-TTL` and a cache context per the
    block's `cache.cachemode` (per-role → `user.roles`, per-user → `user`).

## Deflate lifecycle

`deflateCache()` sends the deflate value with `X-Deflate-Key` from `state('adv_varnish_deflate_key')`.
`hook_cron` (`AdvVarnishHooks::cron`) drains `state('adv_varnish_deflate_ids')` in random order,
`adv_varnish_deflate_info['step']` items per run, calling `deflateCache()` for each.

## Related services

- `adv_varnish.request_handler` (`RequestHandler`) — response-event handling & header emission.
- `adv_varnish.cookie_manager` (`CookieManager`) — cache-varying cookie management.
- `plugin.manager.user_blocks` — see [../plugins/user-blocks.md](../plugins/user-blocks.md).

## Calling it

```php
$cm = \Drupal::service('adv_varnish.cache_manager');
$cm->purgeTags(['node:123']);
$cm->purgeUri('/about');
$cm->flushAllCaches();
```

(These no-op unless `general.varnish_purger` is enabled and a `varnish_server` is reachable.)
