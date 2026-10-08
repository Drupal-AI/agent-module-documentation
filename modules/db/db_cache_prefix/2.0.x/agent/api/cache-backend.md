<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The prefixed database cache backend

## Install & enable

```bash
composer require drupal/db_cache_prefix
drush en db_cache_prefix -y
drush cr
```

No dependencies beyond Drupal core, no sub-modules, no permissions, no Drush commands, no config
UI. Enabling the module alone changes nothing observable until you set the prefix (below); with the
setting unset it behaves exactly like core's database cache.

## What the service override does

`db_cache_prefix.services.yml` **redefines the core service** `cache.backend.database`:

```yaml
services:
  cache.backend.database:
    class: Drupal\db_cache_prefix\Cache\PrefixedDatabaseBackendFactory
    arguments:
      - '@database'
      - '@cache_tags.invalidator.checksum'
      - '@settings'
      - '@serialization.phpserialize'
      - '@datetime.time'
    tags:
      - { name: backend_overridable }
```

Because `cache.backend.database` is the factory core normally uses for the default database backend,
replacing its class swaps in this module's factory for every bin that resolves to that backend. The
five arguments and the `backend_overridable` tag mirror core's own definition, so the backend is a
drop-in.

### Classes (in `src/Cache/`)

- **`PrefixedDatabaseBackendFactory`** extends core `Drupal\Core\Cache\DatabaseBackendFactory`.
  Overrides `get($bin)` to compute `$max_rows = $this->getMaxRowsForBin($bin)` (inherited) and
  return a `new PrefixedDatabaseBackend($this->connection, $this->checksumProvider, $bin,
  $this->serializer, $this->time, $max_rows)` — i.e. the only change from core is the concrete
  backend class instantiated.
- **`PrefixedDatabaseBackend`** extends core `Drupal\Core\Cache\DatabaseBackend`. Overrides only
  `normalizeCid($cid)`:

  ```php
  public function normalizeCid($cid) {
    $prefix = Settings::get('db_cache_prefix');
    if ($prefix == NULL) {
      return parent::normalizeCid($cid);
    }
    $prefixedCid = implode('_', [$prefix, $cid]);
    return parent::normalizeCid($prefixedCid);
  }
  ```

  Everything else (`set`, `get`, `getMultiple`, `delete`, `deleteAll`, `invalidate`, garbage
  collection, the `cache_*` table schema) is inherited unchanged. Since `normalizeCid()` is applied
  on both reads and writes, a set of `foo` under prefix `test` is stored and later fetched as
  `test_foo`; `deleteAll()` still truncates the whole bin table, so it removes prefixed rows too
  (including rows written under other prefixes — see the kernel `DatabaseTest::testDeleteMultiplePrefixes`).

## Configuration (settings.php only)

The prefix is read at runtime from `settings.php` via `Settings::get('db_cache_prefix')`. There is
**no config object, no schema, and no admin form**.

```php
// sites/default/settings.php (or a settings.*.php include)
$settings['db_cache_prefix'] = 'my_prefix';
```

- Any string is accepted; the module concatenates it as `"{prefix}_{cid}"`. Convention is to derive
  it from the deployment id / git SHA so each release has its own cache namespace.
- Unset (or `NULL`): the backend defers entirely to core — no prefix, no behaviour change.
- Because it is a settings value, set it per-environment in the deploy pipeline rather than in the
  database/config.

## Operating notes & gotchas

- **A prefix change is a cache flush.** Old ids (`oldprefix_*`) become unreachable, so the site
  starts cold. That is the intended behaviour for a clean deploy, but on a busy site expect a
  cache-rebuild spike; treat prefix changes as deployment events.
- **Scope is the database backend only.** Bins pointed at Redis, Memcache, APCu, or
  `cache.backend.chainedfast` do not go through this factory and are unaffected. Verify which bins
  actually use `cache.backend.database` on your site.
- **Not a security boundary.** All entries remain in the same `cache_*` tables; the prefix prevents
  accidental collisions between codebases sharing a table, not deliberate reading by something with
  database access. For confidentiality between tenants use genuinely separate cache stores.
- **Core alternative.** Core already supports `$settings['cache_prefix']` for the database backend
  in some arrangements; decide whether the site needs this module or whether the core setting covers
  the case, depending on the backend layout in use.
- **Motivating bug (from the module's tests).** `tests/src/Kernel/RaceConditionTest.php` /
  `RaceConditionFixedTest.php` demonstrate the class of problem: with a shared unprefixed cache,
  module discovery can reuse a cache populated from an old filesystem so new modules aren't
  discovered until a manual clear; prefixing per codebase avoids it.
