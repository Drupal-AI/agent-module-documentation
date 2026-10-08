# Permanent Cache Bin (pcb) — manual setup guide

**Permanent Cache Bin** (`pcb`) provides cache backends whose entries are **not**
wiped by a normal cache rebuild (`drush cr`). Drupal's usual behavior is that a
cache clear empties everything, which is fine for cheap-to-rebuild caches but
wasteful for data that is expensive to regenerate — remote API responses, stock
levels, pricing, a heavy computed report. With pcb you can put that kind of data
in a cache bin that survives deploys and cache clears, so you avoid a
"thundering herd" of recomputation every time someone runs `drush cr`.

A permanent bin behaves exactly like a normal cache bin for everyday operations —
get, set, invalidate, delete, cache tags, and expiry all work as usual. The only
difference is that the blanket "delete everything" that Drupal calls during a
rebuild is turned into a no-op. Clearing a permanent bin therefore has to be
**explicit**: you use a Drush command, a per-bin button pcb adds to the
Performance settings page, or a programmatic call. That way the cache is only
purged when its source data actually changes, on your schedule rather than
Drupal's.

The module is aimed at developers and site builders: there is no configuration
form or config object. You opt a bin into permanence either in `settings.php` or
by defining a cache-bin service in a module. It requires PHP 8.1+ and works on
Drupal 10.3, 11, and 12. Two optional submodules, **PCB Memcache**
(`pcb_memcache`) and **PCB Redis** (`pcb_redis`), provide permanent backends
backed by Memcache and Redis instead of the database.

This guide is written for a **human** setting this up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   the optional Memcache/Redis submodules.
2. [Configuration](configuration/index.md) — make a bin permanent, and how to
   clear it (Drush, admin buttons, code).

## Where it lives in the admin menu

pcb has no admin page of its own. Once a bin is permanent, pcb adds a **"Clear
permanent cache for &lt;bin&gt;"** button for it on the core Performance page at
**Configuration → Development → Performance**
(`/admin/config/development/performance`).

## How to use it

Enable the module, then point a cache bin at pcb's permanent backend (in
`settings.php` or a services file) and warm it with your data. From then on
`drush cr` leaves that bin intact, and you clear it deliberately with
`drush pcbf <bin>`, the Performance-page button, or `deleteAllPermanent()` in
code. See [Configuration](configuration/index.md) for the details.
