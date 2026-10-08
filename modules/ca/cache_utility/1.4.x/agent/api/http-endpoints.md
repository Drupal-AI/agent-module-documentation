# HTTP JSON API

The module's signature surface: 11 GET routes under `/admin/cache_utility/…`, each returning
`application/json`. They are declared `_access: 'TRUE'` with `_maintenance_access: 'TRUE'` (so they
still answer while the site is in maintenance mode — the point is to flush caches during a deploy).

## Authentication

Every request must carry the header `CU-ACCESS-KEY: <value>` where `<value>` equals
`cache_utility.settings` → `security.accessKey`. A missing header, or a mismatch, returns:

```json
{"success": false, "error": "Access denied."}
```

```bash
curl -H 'Content-Type: application/json' -H 'CU-ACCESS-KEY: <key>' \
  https://example.com/admin/cache_utility/opcache/clear
```

## Routes

| Route name | Path | Controller::method | Success payload |
|---|---|---|---|
| `cache_utility.drupalcache.clear` | `/admin/cache_utility/drupalcache/clear` | `CU_DrupalCache::clearDrupalCache` | runs `drupal_flush_all_caches()`; `{success, num_deleted_cache_table_rows}` |
| `cache_utility.drupalcache.status` | `/admin/cache_utility/drupalcache/status` | `CU_DrupalCache::getCacheTablesStatus` | `{success, num_cache_table_rows}` |
| `cache_utility.drupalcachetables.clear` | `/admin/cache_utility/drupalcachetables/clear` | `CU_DrupalCache::truncateDrupalCacheTables` | truncates every `cache_*` table; `{success, num_deleted_cache_table_rows}` |
| `cache_utility.cachetags.clear` | `/admin/cache_utility/cachetags/clear` | `CU_Cachetags::clearCachetags` | truncates `cachetags`; `{success, num_cachetag_rows_cleared}` |
| `cache_utility.cachetags.status` | `/admin/cache_utility/cachetags/status` | `CU_Cachetags::getCachetagsStatus` | `{success, num_cachetag_rows}` |
| `cache_utility.opcache.clear` | `/admin/cache_utility/opcache/clear` | `CU_OPCache_Clear::clearOPCache` | `opcache_reset()`; `{success, opcache_cleared}` |
| `cache_utility.opcache.config` | `/admin/cache_utility/opcache/config` | `CU_OPCache_Config::getOPCacheConfig` | `opcache_get_configuration()`; `{success, opcache_config}` |
| `cache_utility.opcache.status` | `/admin/cache_utility/opcache/status` | `CU_OPCache_Status::getOPCacheStatus` | `opcache_get_status()` (`scripts` stripped); `{success, opcache_status}` |
| `cache_utility.apcu.clear` | `/admin/cache_utility/apcu/clear` | `CU_APCu_Clear::clearCache` | `apcu_clear_cache()`; `{success, apcu_cleared}` |
| `cache_utility.apcu.config` | `/admin/cache_utility/apcu/config` | `CU_APCu_Config::getCacheConfig` | `apcu_sma_info(TRUE)`; `{success, apcu_config}` |
| `cache_utility.apcu.status` | `/admin/cache_utility/apcu/status` | `CU_APCu_Status::getCacheStatus` | `apcu_cache_info(TRUE)`; `{success, apcu_status}` |

The OPcache/APCu endpoints first check the extension is enabled; if not, they return
`{"success": false, "error": "OPCache is not enabled."}` (resp. APCu). The cachetags endpoints
return `{"success": false}` if the `cachetags` table does not exist.

## Operational notes

- `opcache_reset()` resets OPcache for the **entire PHP-FPM pool**, i.e. every site sharing that
  pool, not just this Drupal install.
- Truncating `cache_*` tables does not work on SQLite (`findTables()` core limitation, issue 2949229).
- These are the exact routes the Drush commands ([../drush/commands.md](../drush/commands.md)) call
  internally, and the ones the settings page prints copy-paste `curl` examples for.
