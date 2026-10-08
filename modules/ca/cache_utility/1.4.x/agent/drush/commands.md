# Drush commands

Class `Drupal\cache_utility\Commands\CuCommands` (registered via `drush.services.yml` as
`cu.commands`). Ten commands, all under the `cache_utility:` / `cu:` prefix. Every command accepts a
`--host` option and returns exit `1` on failure.

How they work: each command reads `security.accessKey` from `cache_utility.settings`, then makes an
**internal HTTP curl request** to the corresponding JSON route on `--host`, sending the
`CU-ACCESS-KEY` header. This is why OPcache/APCu can be flushed from Drush at all — the request is
served by the webserver's PHP (PHP-FPM), whereas `drush` itself runs under PHP-CLI with a separate
OPcache/APCu. If `skip_ssl_verification` is set, the request skips SSL certificate verification.

`--host` resolution (`getHost()` / `validateHost()`): use the given `--host`, else the global
`$base_url`, else default `http://localhost`. A supplied host is validated — it must resolve via a
DNS `A` record, use scheme `http`/`https`, and is rejected if it is a raw IP literal.

| Command | Aliases | Action |
|---|---|---|
| `cache_utility:opcache-status` | `cache_utility:opcache`, `cu:opcache`, `cu:opcache-status` | Print OPcache status (`opcache_get_status()`) as grouped rows. |
| `cache_utility:opcache-config` | `cu:opcache-config` | Print OPcache directives + version (`opcache_get_configuration()`). |
| `cache_utility:opcache-clear` | `cu:opcache-clear` | `opcache_reset()` on the host. |
| `cache_utility:apcu-status` | `cache_utility:apcu`, `cu:apcu`, `cu:apcu-status` | Print APCu status (`apcu_cache_info(TRUE)`). |
| `cache_utility:apcu-config` | `cu:apcu-config` | Print APCu SMA info (`apcu_sma_info(TRUE)`). |
| `cache_utility:apcu-clear` | `cu:apcu-clear` | `apcu_clear_cache()` on the host. |
| `cache_utility:cachetags-status` | `cache_utility:cachetags`, `cu:cachetags`, `cu:cachetags-status` | Report row count of the `cachetags` table. |
| `cache_utility:cachetags-truncate` | `cu:cachetags-truncate` | Truncate the `cachetags` table (reports rows deleted). |
| `cache_utility:cachetables-status` | `cache_utility:cachetables`, `cu:cachetables`, `cu:cachetables-status` | Report total rows across all `cache_*` tables. |
| `cache_utility:cachetables-truncate` | `cu:cachetables-truncate` | Truncate all `cache_*` tables (reports rows deleted). |

```bash
drush cu:opcache-clear --host https://example.com
drush cu:cachetables-status --host https://example.com
```

There is no dedicated command to clear Drupal's own cache — use core `drush cr` (the settings page
lists it in that slot).
