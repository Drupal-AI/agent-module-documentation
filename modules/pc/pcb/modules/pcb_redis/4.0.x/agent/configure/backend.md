<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Use the Redis permanent backend

pcb_redis adds exactly one thing: the cache backend service **`cache.backend.permanent_redis`**.
There is no config object, form, or route.

## Requirements

- Contrib **Redis** module enabled (`redis:redis >= 8.x-1.0-rc2`).
- Parent **pcb** module enabled.
- A working Redis server wired into Drupal (the standard `redis` settings, e.g.
  `$settings['redis.connection']['host']` and `$settings['cache']['default'] = 'cache.backend.redis'`
  or per-bin).

Enable it: `drush en pcb_redis -y`.

## Point a bin at it

Service definition (a module's `*.services.yml`):

```yaml
cache.stock:
  class: Drupal\Core\Cache\CacheBackendInterface
  tags:
    - { name: cache.bin, default_backend: cache.backend.permanent_redis }
  factory: cache_factory:get
  arguments: [stock]
```

Or in `settings.php`:

```php
$settings['cache']['bins']['stock'] = 'cache.backend.permanent_redis';
```

## Behavior

Identical semantics to the database variant, but stored in Redis:

- `deleteAll()` is a **no-op** → `drush cr` does not clear the bin.
- `deleteAllPermanent()` clears it (via `drush pcbf <bin>`, the Performance-page button, or
  `\Drupal::service('cache.stock')->deleteAllPermanent()`).

The service factory:

```yaml
cache.backend.permanent_redis:
  class: Drupal\pcb_redis\Cache\PermanentRedisBackendFactory
  arguments: ['@redis.factory', '@cache_tags.invalidator.checksum', '@serialization.phpserialize']
```

`PermanentRedisBackendFactory` extends the Redis module's `CacheBackendFactory` and its `get($bin)`
returns a `PermanentRedisBackend` (Redis backend + `PermanentBackendTrait`).

See the parent module's [api/backend.md](../../../../../4.0.x/agent/api/backend.md) for the shared
permanence mechanism, and [drush/commands.md](../../../../../4.0.x/agent/drush/commands.md) for
`pcbf`/`pcb-list`.
