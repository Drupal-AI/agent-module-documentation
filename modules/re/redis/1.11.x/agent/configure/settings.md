# Configure Redis (settings.php)

There is **no admin config form**. All configuration lives in `settings.php` (plus a shipped
services YAML). A reference file `settings.redis.example.php` ships with the module.

## 1. Connection
```php
$settings['redis.connection']['host']      = '127.0.0.1'; // or '/tmp/redis.sock'
$settings['redis.connection']['port']      = 6379;        // 0 for a UNIX socket
$settings['redis.connection']['interface'] = 'PhpRedis';  // PhpRedis | Relay | Predis
// Optional:
$settings['redis.connection']['password']  = 'secret';
$settings['redis.connection']['base']      = 0;           // Redis DB number
```
Defaults (from `ClientFactory`): host `127.0.0.1`, port `6379`, no password, DB none.

## 2. Use Redis as cache
```php
$settings['cache']['default'] = 'cache.backend.redis';
// or per bin:
$settings['cache']['bins']['render'] = 'cache.backend.redis';
```

## 3. Also route lock / flood / cache-tag checksums through Redis
Include the module's example services override (enables `lock`, `lock.persistent`, `flood`,
`cache_tags.invalidator.checksum`):
```php
$settings['container_yamls'][] = 'modules/contrib/redis/example.services.yml';
```
For the bootstrap **container cache** (works before the module is enabled), also add
`redis.services.yml` to `container_yamls`, register the PSR-4 path with `$class_loader`, and set
`$settings['bootstrap_container_definition']` — see `settings.redis.example.php` for the full block.

## 4. Optional tuning keys
| Setting | Effect |
|---|---|
| `cache_prefix` | Key prefix so multiple sites can share one Redis instance |
| `redis_compress_length` | Compress cache entries longer than N bytes |
| `redis_ttl_offset` | Add an offset to entry TTLs |
| `redis_invalidate_all_as_delete` | Treat invalidations as deletes (saves memory) |

## Queues
Queue backends are provided as `queue.redis` and `queue.redis_reliable` (tagged `queue_factory`).
Select them via `$settings['queue_default'] = 'queue.redis_reliable';` or per-queue
`$settings['queue_service_<name>']`.

Source: `settings.redis.example.php`, `example.services.yml`, `redis.services.yml`.
