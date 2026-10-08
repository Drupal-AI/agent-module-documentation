# Configure Cache Utility

Settings form `Drupal\cache_utility\Form\SettingsForm` at route `cache_utility.settings` →
`/admin/config/development/cache_utility` (permission `administer cache utility configuration`).
All settings live in the config object **`cache_utility.settings`**. No config schema ships (only
`config/install/cache_utility.settings.yml`).

## Config keys

| Key | Type | Default | Purpose |
|---|---|---|---|
| `security.accessKey` | string | random `Crypt::randomBytesBase64(32)` set by `hook_install()` (`""` in `config/install`) | Shared secret required in the `CU-ACCESS-KEY` header on every JSON API route (see [../api/http-endpoints.md](../api/http-endpoints.md)) and used by the Drush commands. |
| `flushCaches.opcache` | bool | `FALSE` | Also `opcache_reset()` on every `drupal_flush_all_caches()`. |
| `flushCaches.apcu` | bool | `FALSE` | Also `apcu_clear_cache()` on flush. |
| `flushCaches.drupal_cachetags` | bool | `FALSE` | Also truncate the `cachetags` table on flush. |
| `flushCaches.drupal_cachetables` | bool | `FALSE` | Also truncate all `cache_*` tables on flush. |
| `skip_ssl_verification` | bool | `FALSE` | Makes the Drush commands' internal curl skip SSL cert verification (`CURLOPT_SSL_VERIFYPEER/HOST => 0`) and renders the settings page's example curl commands as `curl --insecure`. |

The form's `showHTTPSHosts` checkbox is display-only (toggles `http`/`https` in the example
commands); it is **not** persisted to config.

## Set it via Drush or PHP

```bash
drush config:set cache_utility.settings security.accessKey 'LONG_RANDOM_SECRET'
drush config:set cache_utility.settings flushCaches.opcache true
```

```php
\Drupal::configFactory()->getEditable('cache_utility.settings')
  ->set('security.accessKey', 'LONG_RANDOM_SECRET')
  ->set('flushCaches.opcache', TRUE)
  ->set('flushCaches.apcu', TRUE)
  ->save();
```

## Runtime behavior — `hook_cache_flush()`

`cache_utility.module` implements `hook_cache_flush()`. On every `drupal_flush_all_caches()` (e.g.
`drush cr`, or a "Clear all caches" click) it additionally, for each enabled flag whose target is
available: `CU_OPCache_Clear::resetOPCache()`, `CU_APCu_Clear::clearAPCuCache()`,
`CU_Cachetags::clearCachetagsTable()`, `CU_DrupalCache::truncateAllDrupalCacheTables()`. So enabling
`flushCaches.opcache` is how you make a normal Drupal cache clear also reset OPcache on that node.

## In-form action buttons

The settings form also renders AJAX buttons (handled by `SettingsForm` callbacks, gated by the
form's permission — no access key needed here) to, on the current node: clear OPcache / APCu, show
OPcache / APCu status and config, truncate the `cachetags` table, truncate all `cache_*` tables, and
clear Drupal's cache. Collapsible "Usage" panels show live OPcache/APCu memory + hit-rate readouts.
Each cache section also prints ready-to-copy `drush` and `curl` commands (site-host and localhost
variants) with the configured access key filled in.
