# Overriding services

Copy the snippets you need from the module's `example.services.yml` into
`sites/default/services.yml`, or enable the file directly:
```php
$settings['container_yamls'][] = $app_root . '/modules/contrib/memcache/example.services.yml';
```
(The memcache module must be enabled for these to resolve.)

## Use memcache for cache tags (recommended with memcache cache)
```yaml
services:
  memcache.timestamp.invalidator.tag:
    class: Drupal\memcache\Invalidator\MemcacheTimestampInvalidator
    arguments: ['@memcache.factory', 'memcache_tag_timestamps', 0.001]
  cache_tags.invalidator.checksum:
    class: Drupal\memcache\Cache\TimestampCacheTagsChecksum
    arguments: ['@memcache.timestamp.invalidator.tag']
    tags:
      - { name: cache_tags_invalidator }
```

## Use memcache as the lock backend
```yaml
services:
  lock:
    class: Drupal\Core\Lock\LockBackendInterface
    factory: ['@memcache.lock.factory', get]
```

## Notes
- Adjust the `tolerance` factor (3rd arg, default `0.001`) upward when memcached is not on
  localhost / has higher latency.
- Keep the tag-timestamp bin consistent if you also run the bootstrap container in memcache.
- The `memcache.timestamp.invalidator.bin` service (in `memcache.services.yml`) can likewise
  be overridden to tune bin invalidation tolerance.
- For running the container/bootstrap cache in pure memcache, see the README "Cache Container
  on bootstrap" section.
