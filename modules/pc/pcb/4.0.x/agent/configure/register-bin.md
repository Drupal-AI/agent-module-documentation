<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Make a cache bin permanent

pcb has **no configuration UI or config object**. You opt a specific cache bin into the
permanent backend in one of two ways.

## Option 1 — define a bin service (a module's `*.services.yml`)

```yaml
cache.stock:
  class: Drupal\Core\Cache\CacheBackendInterface
  tags:
    - { name: cache.bin, default_backend: cache.backend.permanent_database }
  factory: cache_factory:get
  arguments: [stock]
```

This registers a `stock` bin whose default backend is pcb's permanent database backend. Get it
with `\Drupal::service('cache.stock')` (or inject `@cache.stock`).

## Option 2 — override an existing bin in `settings.php`

```php
$settings['cache']['bins']['stock'] = 'cache.backend.permanent_database';
```

Use the memcache/redis service instead to back the bin with those stores (submodules):

```php
$settings['cache']['bins']['stock'] = 'cache.backend.permanent_memcache'; // needs pcb_memcache
$settings['cache']['bins']['stock'] = 'cache.backend.permanent_redis';    // needs pcb_redis
```

## What changes once a bin is permanent

- `drush cr` (and any full cache rebuild) **no longer clears** that bin — its `deleteAll()` is a
  no-op.
- Cache tags, expiry, `get`/`set`/`invalidate`/`delete` all behave normally.
- To actually empty the bin you must be explicit — see below.

## Clearing a permanent bin

- Admin UI: pcb adds a **"Clear permanent cache for &lt;bin&gt;"** submit button per permanent bin
  on the Performance page (`admin/config/development/performance`).
- Drush: `drush pcbf <bin>` (see [drush/commands.md](../drush/commands.md)).
- Code: `\Drupal::service('cache.<bin>')->deleteAllPermanent();`

## On-demand (no registration) usage

The factory can produce a permanent backend for any bin name without registering it, which is
handy in scripts/tests:

```php
$bin = \Drupal::service('cache.backend.permanent_database')->get('my_bin');
$bin->set('key', $value);
$bin->deleteAll();           // no-op: value survives
$bin->deleteAllPermanent();  // actually clears it
```

Note: an unregistered bin created this way is not part of `Cache::getBins()`, so it will not
appear in `drush pcb-list` and is not touched by `drush cr` regardless.
