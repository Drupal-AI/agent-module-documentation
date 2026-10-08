# Submodule: cache_utility_admin_toolbar

Optional submodule "Cache Utility Admin Toolbar Extras". Adds one-click flush links under the
toolbar's **Drupal icon → Flush all caches** menu (parent `admin_toolbar_tools.flush`).

Dependencies: `cache_utility:cache_utility`, `admin_toolbar:admin_toolbar`,
`admin_toolbar:admin_toolbar_tools`.

## Menu links (`*.links.menu.yml`)

`Flush OPCache`, `Flush APCu`, `Flush database cachetags table`, `Flush database cache_* tables` —
all children of `admin_toolbar_tools.flush`. `hook_admin_toolbar_menu_links_discovered_alter()`
(`cache_utility_admin_toolbar.module`) removes a link when its target is unavailable: OPCache link if
OPcache is disabled, APCu link if APCu is disabled, cachetags link if the `cachetags` table is
absent.

## Routes (`Controller\CU_FlushCaches`)

Each route requires `_permission: 'administer cache utility configuration'` **and**
`_csrf_token: 'TRUE'` (the menu links carry the CSRF token). The controller performs the flush, adds
a status message, then `RedirectResponse`s back to `HTTP_REFERER` (or `/`).

| Route name | Path | Method | Action |
|---|---|---|---|
| `cache_utility_admin_toolbar.flush_cache.opcache` | `/admin/cache_utility/flush/opcache` | `flushOPCache` | `CU_OPCache_Clear::resetOPCache()` if OPcache enabled |
| `cache_utility_admin_toolbar.flush_cache.apcu` | `/admin/cache_utility/flush/apcu` | `flushAPCuCache` | `CU_APCu_Clear::clearAPCuCache()` if APCu enabled |
| `cache_utility_admin_toolbar.flush_cache.drupal_cachetags` | `/admin/cache_utility/flush/drupal/cachetags` | `flushDrupalCachetags` | truncate `cachetags` if it exists |
| `cache_utility_admin_toolbar.flush_cache.drupal_cachetables` | `/admin/cache_utility/flush/drupal/cachetables` | `flushDrupalCachetables` | `CU_DrupalCache::truncateAllDrupalCacheTables()` |

Unlike the main module's JSON API, these routes use the Drupal permission + CSRF token (they are
UI actions for a logged-in administrator), not the `CU-ACCESS-KEY` header.
