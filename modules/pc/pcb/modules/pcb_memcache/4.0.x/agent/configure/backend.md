<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Use the Memcache permanent backend

pcb_memcache adds exactly one thing: the cache backend service
**`cache.backend.permanent_memcache`**. There is no config object, form, or route.

## Requirements

- Contrib **Memcache** module enabled (`memcache:memcache >= 2.0`).
- Parent **pcb** module enabled.
- A working Memcache server wired into Drupal (the standard `memcache` settings, e.g.
  `$settings['memcache']['servers']` and `$settings['cache']['default'] = 'cache.backend.memcache'`
  or per-bin).

Enable it: `drush en pcb_memcache -y` (this also enables `memcache`).

## Point a bin at it

Service definition (a module's `*.services.yml`):

```yaml
cache.stock:
  class: Drupal\Core\Cache\CacheBackendInterface
  tags:
    - { name: cache.bin, default_backend: cache.backend.permanent_memcache }
  factory: cache_factory:get
  arguments: [stock]
```

Or in `settings.php`:

```php
$settings['cache']['bins']['stock'] = 'cache.backend.permanent_memcache';
```

## Behavior

Identical semantics to the database variant, but stored in Memcache:

- `deleteAll()` is a **no-op** → `drush cr` does not clear the bin.
- `deleteAllPermanent()` clears it (via `drush pcbf <bin>`, the Performance-page button, or
  `\Drupal::service('cache.stock')->deleteAllPermanent()`).

The service factory:

```yaml
cache.backend.permanent_memcache:
  class: Drupal\pcb_memcache\Cache\PermanentMemcacheBackendFactory
  arguments: ['@memcache.factory', '@cache_tags.invalidator.checksum', '@memcache.timestamp.invalidator.bin']
```

`PermanentMemcacheBackendFactory` extends the Memcache module's factory and returns a
`PermanentMemcacheBackend` (Memcache backend + `PermanentBackendTrait`).

See the parent module's [api/backend.md](../../../../../4.0.x/agent/api/backend.md) for the shared
permanence mechanism, and [drush/commands.md](../../../../../4.0.x/agent/drush/commands.md) for
`pcbf`/`pcb-list`.
