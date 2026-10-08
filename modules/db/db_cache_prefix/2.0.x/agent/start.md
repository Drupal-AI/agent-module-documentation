<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Database cache prefix (db_cache_prefix) — agent index

Overrides Drupal's **default database cache backend** so that every cache id gets a configurable
prefix from `$settings['db_cache_prefix']`. Package `Performance`. **No dependencies** beyond core,
no routes, no permissions, no config objects/schema, no Drush, no plugins, no hooks. Core
requirement `^10.3 || ^11`. License GPL-2.0-or-later. Version **2.0.0-rc3** (release candidate).

- **What it registers, how it wires into core caching, and how to configure/operate it** →
  [api/cache-backend.md](api/cache-backend.md)

## What it actually is

- `db_cache_prefix.services.yml` redefines the core service **`cache.backend.database`** to
  class `Drupal\db_cache_prefix\Cache\PrefixedDatabaseBackendFactory` (tagged
  `backend_overridable`), passing the same five args core uses: `@database`,
  `@cache_tags.invalidator.checksum`, `@settings`, `@serialization.phpserialize`, `@datetime.time`.
- `PrefixedDatabaseBackendFactory::get($bin)` (extends core `DatabaseBackendFactory`) returns a
  **`PrefixedDatabaseBackend`** instead of core's `DatabaseBackend`, forwarding
  `getMaxRowsForBin($bin)`.
- `PrefixedDatabaseBackend` (extends core `DatabaseBackend`) overrides only **`normalizeCid($cid)`**:
  reads `Settings::get('db_cache_prefix')`; if `NULL`, defers to `parent::normalizeCid()`; otherwise
  prefixes with `implode('_', [$prefix, $cid])` → e.g. `test_foo:bar`.

## How it wires into caching

- The override applies to whatever bins use the `cache.backend.database` factory (the default for a
  stock site). Bins routed to another backend (Redis/Memcache/APCu/`cache.backend.chainedfast`)
  are **not** affected.
- The prefix is a **`settings.php`** value only — set/changed by editing that file (or a deploy
  pipeline), never through the UI. With no setting, behaviour is identical to core.
- Changing the prefix makes previously written ids unreachable ⇒ an effective full cache
  invalidation / cold start. Treat as a deployment event.

## Configuration (settings.php)

```php
$settings['db_cache_prefix'] = 'my_prefix'; // any string; commonly the deploy id / git SHA
```

Details, wiring, gotchas, and the multi-instance rationale in
[api/cache-backend.md](api/cache-backend.md).
