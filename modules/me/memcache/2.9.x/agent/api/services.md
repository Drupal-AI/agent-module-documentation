# Services

Defined in `memcache.services.yml`:

| Service | Class | Purpose |
|---|---|---|
| `memcache.settings` | `MemcacheSettings` | Reads `$settings['memcache']` from `settings.php`. |
| `memcache.request_statistics` | `Statistics\RequestStatistics` | Collects per-request memcache operations (shown by memcache_admin when `collect_statistics` is on). |
| `memcache.factory` | `Driver\MemcacheDriverFactory` | Builds driver connections per bin/cluster (takes `@memcache.settings`, `@memcache.request_statistics`). |
| `cache.backend.memcache` | `MemcacheBackendFactory` | Cache backend factory; reference it as `$settings['cache']['default']` or per bin. |
| `memcache.lock.factory` | `Lock\MemcacheLockFactory` | Produces a memcache-backed lock backend. |
| `memcache.flood.factory` | `Flood\MemcacheFloodFactory` | Produces a memcache-backed flood backend (stores events in the `flood` bin; Drupal 10.1+). |
| `memcache.timestamp.invalidator.bin` | `Invalidator\MemcacheTimestampInvalidator` | Timestamp-based bin invalidation (tolerance arg, default `0.001`). |
| `memcache.timestamp.invalidator.bin.key_value` | `Invalidator\KeyValueTimestampInvalidator` | Database-backed bin invalidator; alias `memcache.timestamp.invalidator.bin` to it when each web server runs its own private memcached. |

## Notes
- You rarely call these directly — Drupal's cache system uses the backend factory once
  `cache.backend.memcache` is assigned to a bin in `settings.php`.
- Drivers wrap either the `Memcache` or `Memcached` PECL extension
  (`src/Driver/MemcacheDriver.php`, `src/Driver/MemcachedDriver.php`).
- `MemcacheBackend` stores large items across multiple pieces via `MultipartItem` to stay
  under memcached's per-item size limit.
- The tag checksum service `TimestampCacheTagsChecksum` (see `example.services.yml`) enables
  cache-tag invalidation without the database. On Drupal 11.1+ it implements
  `CacheTagsChecksumPreloadInterface`, looking up a batch's tags in one `getMulti()`.
- The backend uses `TransactionAwareTrait`: deletions and tag invalidations issued inside an
  open database transaction are applied on commit and discarded on rollback (new in 8.x-2.9).
