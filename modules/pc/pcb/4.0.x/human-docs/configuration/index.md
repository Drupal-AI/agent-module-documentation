# Configuration

Permanent Cache Bin has no settings form or config object. "Configuring" it means
two things: telling a cache bin to use pcb's permanent backend, and knowing how
to clear that bin when you actually want to.

## Make a cache bin permanent

There are two ways to opt a bin into the permanent backend. Both require you (or a
developer) to edit code — pcb deliberately does not expose this in the UI.

### Option 1 — in `settings.php`

The simplest approach: point an existing (or new) bin at pcb's backend in your
site's `settings.php`. For a bin named `stock`:

```php
$settings['cache']['bins']['stock'] = 'cache.backend.permanent_database';
```

To back the bin with Memcache or Redis instead (with the matching submodule
enabled):

```php
$settings['cache']['bins']['stock'] = 'cache.backend.permanent_memcache'; // needs pcb_memcache
$settings['cache']['bins']['stock'] = 'cache.backend.permanent_redis';    // needs pcb_redis
```

### Option 2 — define a bin service in a module

If you are building a module, register the bin in its `*.services.yml` with pcb's
backend as the default:

```yaml
cache.stock:
  class: Drupal\Core\Cache\CacheBackendInterface
  tags:
    - { name: cache.bin, default_backend: cache.backend.permanent_database }
  factory: cache_factory:get
  arguments: [stock]
```

You then read and write it in code via `\Drupal::service('cache.stock')` (or by
injecting `@cache.stock`).

## What changes once a bin is permanent

- **`drush cr` (and any full cache rebuild) no longer clears that bin** — its
  entries survive deploys and cache clears.
- Everything else works normally: `get`/`set`/`invalidate`/`delete`, cache tags,
  and expiry all behave exactly as with a standard bin. Only the blanket
  "delete everything on rebuild" is suppressed.
- Because of that, you must clear the bin explicitly when its source data changes
  — see below.

## Clearing a permanent bin

Since `drush cr` intentionally leaves permanent bins alone, use one of these
explicit methods:

### With Drush

```bash
drush pcbf stock        # clear one bin (alias of pcb:flush)
drush pcb:flush-all     # clear every permanent bin (prompts to confirm)
drush pcb-list          # list which bins use a permanent backend
```

`drush pcbf <bin>` errors if the named bin is not actually using a pcb backend, so
it doubles as a sanity check.

### From the admin UI

Once a bin is permanent, pcb adds a **"Clear permanent cache for &lt;bin&gt;"**
button for it on the core Performance page at **Configuration → Development →
Performance** (`/admin/config/development/performance`). Click the button for the
bin you want to empty.

### In code

```php
\Drupal::service('cache.stock')->deleteAllPermanent();
```

Note that calling the ordinary `deleteAll()` on a permanent bin does nothing (that
is exactly what makes it survive a rebuild) — you must call `deleteAllPermanent()`
to truly empty it.

## A caution

Don't try to "fix" stale data in a permanent bin by running `drush cr` — that is
the one thing that won't clear it. Use `drush pcbf <bin>`, the Performance-page
button, or `deleteAllPermanent()` instead.
