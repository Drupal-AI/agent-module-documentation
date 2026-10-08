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
| `purgeTags(array $tags): bool` | send a BAN to Varnish for the given cache tags |
| `purgeUri(string $uri): bool` | purge a single URI |
| `flushAllCaches(): bool` | full Varnish flush for the site |
| `deflateCache($number): bool` | "deflate" — progressively reduce TTLs instead of hard purge |
| `purgeUserBlocks()` | on POST (ESI + `esi_purge_user_blocks` + logged-in), purge the `user:id` tag |

Purge requests use HTTP method **`BAN`** (`purgeMethod = 'BAN'`) sent via the core `http_client` to
`general.varnish_server`. Guards:

- Nothing is purged unless **`general.varnish_purger`** is TRUE.
- If the site is in maintenance mode and `general.purger_maintenance_mode` is TRUE, purges are
  skipped (logged at debug level).

## Response headers

`CacheableResponseSubscriber` (event subscriber) calls `CacheManager::getCacheSettings()` /
`cachingEnabled()` to decide, per request, whether Varnish caching applies (respects
`available.enable_cache`, `authenticated_users`, the URL filter, and the `bypass advanced varnish
cache` permission) and emits the appropriate `Cache-Control` header from `cache_control.anonymous` /
`cache_control.authenticated`, plus the cache-tag hashes Varnish BANs against.

## ESI helpers

- `esiEnabled()` / `isEsiRequest()` — whether ESI is enabled (`available.esi`) and whether the
  current request is for an ESI fragment.
- ESI fragments are served by two routes: `/adv_varnish/esi/user_blocks/{block_id}`
  (`UserBlocksController`) and `/adv_varnish/esi/block/{block_id}` (`ESIBlockController`), both marked
  `no_cache: TRUE`.

## Related services

- `adv_varnish.request_handler` (`RequestHandler`) — request-side handling.
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
