# Services

Defined in `memcache.services.yml`:

| Service | Class | Purpose |
|---|---|---|
| `memcache.settings` | `MemcacheSettings` | Reads `$settings['memcache']` from `settings.php`. |
| `memcache.factory` | `Driver\MemcacheDriverFactory` | Builds driver connections per bin/cluster. |
| `cache.backend.memcache` | `MemcacheBackendFactory` | Cache backend factory; reference it as `$settings['cache']['default']` or per bin. |
| `memcache.lock.factory` | `Lock\MemcacheLockFactory` | Produces a memcache-backed lock backend. |
| `memcache.timestamp.invalidator.bin` | `Invalidator\MemcacheTimestampInvalidator` | Timestamp-based bin invalidation (tolerance arg, default `0.001`). |

## Notes
- You rarely call these directly — Drupal's cache system uses the backend factory once
  `cache.backend.memcache` is assigned to a bin in `settings.php`.
- Drivers wrap either the `Memcache` or `Memcached` PECL extension
  (`src/Driver/MemcacheDriver.php`, `src/Driver/MemcachedDriver.php`).
- `MemcacheBackend` stores large items across multiple pieces via `MultipartItem` to stay
  under memcached's per-item size limit.
- The tag checksum service `TimestampCacheTagsChecksum` (see `example.services.yml`) enables
  cache-tag invalidation without the database.
