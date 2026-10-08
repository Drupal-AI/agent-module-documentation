<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cache mechanism (Adapter + LruMemoryCache)

The module replaces the entity memory cache by **decorating** core's `entity.memory_cache`
service. Two services in `entity_lru_cache.services.yml`:

```yaml
Drupal\entity_lru_cache\Adapter:
  decorates: entity.memory_cache
  arguments: ['@Drupal\entity_lru_cache\Adapter.inner', '@Drupal\entity_lru_cache\LruMemoryCache', '%lru_mode%']
Drupal\entity_lru_cache\LruMemoryCache:
  arguments: ['@datetime.time', '%lru_memory_cache_slots%']
  public: false
```

## Adapter (`src/Adapter.php`)

`class Adapter implements MemoryCacheInterface`. Constructed with the decorated (original)
memory cache, the `LruMemoryCache`, and the `%lru_mode%` string (converted via `LruMode::from()`).
Every `MemoryCacheInterface` method (`get`, `getMultiple`, `set`, `setMultiple`, `delete`,
`deleteMultiple`, `deleteAll`, `invalidate*`, `garbageCollection`, `removeBin`) simply forwards
to the cache chosen by the private `getCache()`:

```php
private function getCache(): MemoryCacheInterface {
  return match (TRUE) {
    $this->mode === LruMode::ON,
    PHP_SAPI === 'cli' && $this->mode === LruMode::CLI_ONLY => $this->lru,
    default => $this->decorated,
  };
}
```

So the LRU cache is used when mode is `on`, or when mode is `cli` **and** running under CLI;
otherwise the original core memory cache is used. `Adapter::reset()` mirrors
`MemoryBackend::reset()` and calls `reset()` on the active cache if it exists.

Cache IDs are passed through **unchanged** — the Adapter never rewrites or augments `$cid`, so
keying is exactly core's entity memory-cache keying.

## LruMemoryCache (`src/LruMemoryCache.php`)

`class LruMemoryCache extends \Drupal\Core\Cache\MemoryCache\MemoryCache`. Adds LRU bounding on
top of core's PHP-array memory cache (`$this->cache`). Slot count is the injected
`$allowedSlots` (default 300).

- **`set($cid, $data, $expire, $tags)`** — if the cid already exists, it is unset first (so it
  re-appends at the end = most recently used). Otherwise, if the array already holds
  `> $allowedSlots - 1` items, the first (oldest/LRU) item is dropped with
  `unset($this->cache[array_key_first($this->cache)])`. Then delegates to `parent::set()`.
  Deliberately avoids `array_slice`/`array_splice`/`array_shift` to prevent re-indexing numeric
  cache IDs.
- **`get()` / `getMultiple()`** — call `parent::get()`, then `handleCacheHits()` moves each
  **valid** hit to the end of the array (most-recently-used). Invalid items (fetched with
  `$allow_invalid = TRUE`) are left in place. A miss changes nothing.
- **`handleCacheHits()`** — for each valid hit not already last, `unset` then re-append to reorder.
- **`invalidate()` / `invalidateMultiple()` / `invalidateTags()`** — invalidate via
  `parent::invalidate()`, then `moveItemsToLeastRecentlyUsed()` prepends the invalidated items
  (`$this->cache = $items + $this->cache`) so they are the first to be evicted. `invalidateTags()`
  scans all items for a tag intersection.

Net effect: a fixed-size, ordered PHP array where recency governs eviction. It is per-process /
per-request memory only — nothing is persisted to any shared backend.

## Tests (reference behavior)

- `tests/src/Unit/LruMemoryCacheTest.php` — LRU ordering, eviction, numeric keys, `setMultiple`,
  invalidation semantics.
- `tests/src/Kernel/ServiceTest.php` — decoration wiring: with `lru_mode = on`,
  `entity.memory_cache` resolves to `Adapter` routing to the LRU service; with `off` it routes to
  the core cache; also covers `reset()`.
