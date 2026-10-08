<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure: cache settings

The module's only settings page is a cache-mechanism form for PhpSpreadsheet cell caching.

- Route: **`phpexcel.admin`** → `/admin/config/development/phpexcel` (form
  `Drupal\phpexcel\Form\SettingsForm`), requires permission **`administer phpexcel`**.
- Menu link `phpexcel.admin` ("PHPExcel cache settings") under *Configuration › Development*.
- Config object: **`phpexcel.settings`** (schema in `config/schema/phpexcel.schema.yml`).

## Config keys

| Key | Type | Default | Purpose |
|---|---|---|---|
| `cache_mechanism` | string | `cache_in_memory` | Which cell-caching backend to use |
| `phptemp_limit` | integer | `1` | MB kept in memory before `cache_to_phpTemp` spills to disk |
| `apc_cachetime` | integer | `600` | APC cache TTL (seconds) |
| `memcache_host` | string | `localhost` | Memcache host |
| `memcache_port` | integer | `11211` | Memcache port |
| `memcache_cachetime` | integer | `600` | Memcache cache TTL (seconds) |

`cache_mechanism` options offered by the form: `cache_in_memory` (default, fastest),
`cache_in_memory_serialized`, `cache_in_memory_gzip`, `cache_to_phpTemp`, `cache_to_apc`,
`cache_to_memcache`, `cache_to_sqlite3`. The `phptemp` / `apc` / `memcache` fieldsets are shown only
when the matching mechanism is selected, and `validateForm()` enforces integer values for the numeric
fields and a non-empty host for Memcache.

## Set without the UI

```php
\Drupal::configFactory()->getEditable('phpexcel.settings')
  ->set('cache_mechanism', 'cache_to_phpTemp')
  ->set('phptemp_limit', 8)
  ->save();
```

```bash
drush config:set phpexcel.settings cache_mechanism cache_to_phpTemp -y
```

## Runtime behaviour (important caveat)

`PHPExcel::getCacheSettings()` reads `cache_mechanism` and, for `cache_to_phpTemp` / `cache_to_apc` /
`cache_to_memcache`, populates an internal `$this->cacheSettings`. In this 4.0.x code the actual
`Settings::setCache(...)` calls in that switch are commented out, so the method **always returns an
empty array** and `export()`/`import()` never activate a non-default cache backend. Treat the cache
form as largely vestigial in 4.0.x — memory use is governed by PhpSpreadsheet's own defaults regardless
of the chosen mechanism. (Also note `getCacheSettings()` reads a `_memcache_port` key that no schema or
install default defines, so the configured `memcache_port` is not wired through.) None of this affects
the correctness of exported/imported data.
