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

## Use memcache as the flood backend (Drupal 10.1+)
```yaml
services:
  flood:
    class: Drupal\Core\Flood\FloodInterface
    factory: ['@memcache.flood.factory', get]
```
Flood events are stored in the `flood` bin (map it to a cluster like any other bin), expire on
their own without cron, and are counted with a compare-and-swap so concurrent requests are not
lost. Flood state is lost if memcached restarts or evicts under memory pressure.

## Private memcached per web server
When each node runs its own memcached, full bin deletions must travel through the database.
Alias the bin invalidator to the key-value implementation:
```yaml
services:
  memcache.timestamp.invalidator.bin:
    alias: memcache.timestamp.invalidator.bin.key_value
```
Do not use the memcache-backed cache-tag checksum or the pure-memcache bootstrap container in
this setup; leave locks and flood control on the database.

## Notes
- Adjust the `tolerance` factor (3rd arg, default `0.001`) upward when web-server clocks
  disagree; the smallest tolerance among the invalidators is the protection you actually get.
- Keep the tag-timestamp bin consistent if you also run the bootstrap container in memcache.
- The `memcache.timestamp.invalidator.bin` service (in `memcache.services.yml`) can likewise
  be overridden to tune bin invalidation tolerance.
- For running the container/bootstrap cache in pure memcache, see the README "Advanced: caching
  the container in memcache" section.
