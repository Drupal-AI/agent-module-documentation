<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom cache (custom_cache) — agent index

A drop-in **database cache backend** that imposes a **maximum lifetime on `CACHE_PERMANENT`**
items. Version **1.0.2**. Core `^8.8 || ^9 || ^10 || ^11`. **No module dependencies**, no
permissions, no routes, no admin UI, no config entities — it is configured entirely from
`settings.php`.

## What it provides
- **Service** `cache.backend.custom_cache` (`custom_cache.services.yml`) — a
  `Drupal\Core\Cache\CacheFactoryInterface` you assign to cache bins in `settings.php`.
- **`CustomCacheBackendFactory`** (`src/CustomCacheBackendFactory.php`) extends core
  `DatabaseBackendFactory`; its `get($bin)` returns a `CustomCacheDatabaseBackend`.
- **`CustomCacheDatabaseBackend`** (`src/CustomCacheDatabaseBackend.php`) extends core
  `DatabaseBackend`. It overrides `setMultiple()` to (a) skip cids matching
  `custom_cache_exclude_cids` and (b) force a finite `expire` on permanent items using
  `custom_cache_melt_time` (default 86400s). It also normalises cids on read/write via a private
  `clearCid()` that ends by invoking the alter hook below.
- **Alter hook** `hook_custom_cache_cid_alter(&$cid)` — lets other modules rewrite cache IDs.

## Settings (settings.php, read via `Settings::get()`)
- `custom_cache_melt_time` (int seconds, default `86400`) — the TTL cap applied to permanent items.
- `custom_cache_exclude_cids` (array of substrings, default `[]`) — cids containing any of these are
  not written by this backend.
- `$settings['cache']['bins'][<bin>] = 'cache.backend.custom_cache';` — assign the backend per bin.

## Concept
`CACHE_PERMANENT` means "keep until invalidated". If an invalidation never fires, a permanent item
stays permanently wrong until a manual cache clear. Capping "permanent" is a hedge: correct
invalidation is unaffected, but a *missed* one self-corrects within the cap. It is a **mitigation,
not a fix** — a cap makes broken invalidation intermittent (harder to diagnose), so set it against
acceptable staleness, not desired cache-miss frequency.

## Solution docs
- [Configure it in settings.php](config/settings.md) — the three settings, per-bin assignment, TTL
  semantics, the exclude list.
- [Backend internals & the alter hook](api/cache-backend.md) — the factory/backend classes,
  `setMultiple`/`getMultiple`/`clearCid` behaviour, `hook_custom_cache_cid_alter`.
