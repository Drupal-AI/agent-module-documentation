<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# pcb backend API (mechanism)

## The permanence trick

Every pcb backend uses `PermanentBackendTrait`:

```php
public function deleteAll() {}                 // no-op: called on cache rebuild → data survives
public function deleteAllPermanent() {          // explicit clear
  parent::deleteAll();                          // the real deleteAll of the underlying backend
}
```

and implements `PermanentBackendInterface extends CacheBackendInterface` (adds
`deleteAllPermanent()`). So a permanent bin is a normal cache backend for everything except that
the blanket `deleteAll()` invoked during `drush cr` / `drupal_flush_all_caches()` does nothing,
and clearing requires the explicit `deleteAllPermanent()`.

## Backends & factory services

| Service | Class | Provided by |
|---|---|---|
| `cache.backend.permanent_database` | `PermanentDatabaseBackendFactory` → `PermanentDatabaseBackend` (extends core `DatabaseBackend`) | pcb |
| `cache.backend.permanent_memcache` | `PermanentMemcacheBackendFactory` → `PermanentMemcacheBackend` | pcb_memcache submodule |
| `cache.backend.permanent_redis` | `PermanentRedisBackendFactory` → `PermanentRedisBackend` | pcb_redis submodule |

pcb also ships `PermanentChainedFastBackend`/`PermanentChainedFastBackendFactory` for chained-fast
bins that should also be permanent.

The database factory service:

```yaml
cache.backend.permanent_database:
  class: Drupal\pcb\Cache\PermanentDatabaseBackendFactory
  arguments: ['@database', '@cache_tags.invalidator.checksum', '@settings', '@serialization.phpserialize', '@datetime.time']
```

Its `get($bin)` returns a `PermanentDatabaseBackend` for that bin, using the same
`cache_<bin>` table layout as core's database cache.

## Programmatic use

```php
// A registered bin:
$cache = \Drupal::service('cache.stock');
$cache->set('sku:123', $data, Cache::PERMANENT, ['stock']);   // tags/expiry work normally
$cache->get('sku:123');
$cache->deleteAll();            // no-op (survives rebuilds)
$cache->deleteAllPermanent();   // actually clears the bin

// Any bin, straight from the factory (unregistered):
$bin = \Drupal::service('cache.backend.permanent_database')->get('my_bin');
```

## Detecting a permanent bin

The reliable runtime test used throughout pcb (Drush commands, the admin buttons) is
`method_exists($backend, 'deleteAllPermanent')`. If true, the bin is backed by a pcb permanent
backend.

## What an agent must remember

- The whole point is survival across `drush cr`; do not "fix" a stale permanent cache by running
  `drush cr` — use `drush pcbf <bin>` or `deleteAllPermanent()`.
- Nothing here has a config object or schema; behavior is entirely wiring (which bin → which
  backend) plus these classes.
