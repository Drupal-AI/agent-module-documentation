<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Guzzle Cache Backend (guzzle_cache) — agent index

Gives Kevinrob's Guzzle caching middleware a Drupal-backed store, so responses to
**outbound** HTTP requests made through Guzzle are cached in a Drupal cache backend using the
RFC 7234 HTTP caching model. Version **3.1.0**, core `^10 || ^11`, no Drupal dependencies.
Requires the `kevinrob/guzzle-cache-middleware` PHP library (`^3.2 | ^4.0`).

This is a **developer building block**, not a configurable feature: no admin UI, no routes, no
permissions, no config schema, no Drush commands, no plugin types.

## What it provides

- **`Drupal\guzzle_cache\DrupalGuzzleCache`** (`src/DrupalGuzzleCache.php`) — a storage adapter
  implementing `Kevinrob\GuzzleCache\Storage\CacheStorageInterface`. It stores Guzzle
  `CacheEntry` objects in any Drupal `CacheBackendInterface`.
  - Constructor: `__construct(CacheBackendInterface $cache, $prefix = 'guzzle:', array $tags = [], ?TimeInterface $time = NULL)`.
  - Cache-id = `$prefix . $key`; default prefix `guzzle:`; prefix limited to 191 chars
    (throws `\InvalidArgumentException` beyond that — cids stay under Drupal's 255 limit).
  - `fetch()` reads `$backend->get($cid)->data`; `save()` writes with `expire =
    $entry->getStaleAt()->getTimestamp()` and the configured tags; `delete()` deletes the cid.
  - **`__invoke()`** makes the object usable as an `http_client_middleware`: it builds a
    `BackendChain` of an in-request `MemoryBackend` in front of the injected Drupal backend,
    wraps it in a fresh `DrupalGuzzleCache`, and returns a
    `CacheMiddleware(new PrivateCacheStrategy($cache))`.
- **`guzzle_cache_middleware`** submodule — registers the `guzzle_cache.middleware` service
  (class `DrupalGuzzleCache`, args `['@cache.default', 'guzzle:', [], '@datetime.time']`) tagged
  `http_client_middleware`, so **all** `\Drupal::httpClient()` traffic is cached automatically.

## Two ways to use it

1. **Automatic, site-wide** — enable the `guzzle_cache_middleware` submodule. Every request
   through Drupal's shared `http_client` runs through the cache against the `cache.default` bin.
   See [`submodules/`](submodules/middleware.md).
2. **Manual, per-client** — instantiate `DrupalGuzzleCache` against a chosen cache bin, push its
   `CacheMiddleware` onto a Guzzle `HandlerStack`, and build your own client. See
   [`api/`](api/developer.md).

## Caching semantics (from `PrivateCacheStrategy`, RFC 7234)

- Cacheable status codes only (200, 203, 204, 300, 301, 404, 405, 410, 414, 418, 501).
- `Cache-Control: no-store` → not cached. `no-cache` → stored but immediately stale (served only
  after revalidation with `ETag`/`Last-Modified`). `max-age` / `Expires` set freshness.
- A `PrivateCacheStrategy` is a *private-client* cache — it will store responses marked
  `Cache-Control: private`. The upstream library warns to share such storage between contexts
  with caution; see `api/developer.md` for how keying and bin selection work.
- `Vary` is honoured: a second key incorporating the varied request headers is stored/matched.

## Files

- `src/DrupalGuzzleCache.php` — the storage adapter + middleware factory.
- `modules/guzzle_cache_middleware/guzzle_cache_middleware.services.yml` — the tagged service.
- `tests/src/Unit/DrupalGuzzleCacheTest.php` — unit coverage for fetch/save/delete/prefix/invoke.

## Subpages

- [`api/developer.md`](api/developer.md) — manual wiring, the adapter API, bin/prefix/tag options.
- [`submodules/middleware.md`](submodules/middleware.md) — the automatic site-wide middleware.
