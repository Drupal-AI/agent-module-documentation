# PWA Service Worker config, routes & hooks

Config object **`pwa_service_worker.config`**; form route `pwa_service_worker.config` →
`/admin/config/services/pwa/service-worker` (permission `administer pwa`).

| Key | Type | Default | Meaning |
|---|---|---|---|
| `urls_to_cache` | string (newline patterns) | `''` | Paths to pre-cache on service-worker install |
| `urls_to_exclude` | string (newline patterns) | `admin/.*`, `user/.*` | Paths never cached (JS regex) |
| `offline_page` | string | `/offline` | Path of the offline fallback page |
| `cache_version` | string | `1` | Bump to invalidate the cache |
| `skip_waiting` | bool | false | Activate an updated service worker immediately after install |

```bash
drush cget pwa_service_worker.config offline_page
drush cset pwa_service_worker.config offline_page /sorry-offline -y
drush cset pwa_service_worker.config cache_version 2 -y
drush cset pwa_service_worker.config skip_waiting true -y
```

## Routes

| Route | Path | Purpose |
|---|---|---|
| `pwa_service_worker.registration` | `/service-worker-data` | Service-worker registration/data (permission `access pwa`) |
| `pwa_service_worker.offline_page` | `/offline` | Offline fallback page |
| `pwa_service_worker.phone_home` | `/pwa/phone-home` | Detect the module is active |

A `ResponseSubscriber` injects the SW registration; `pwa_service_worker_page_attachments()` and
`_user_login()` attach the JS.

## Alter hooks (from `pwa_service_worker.api.php`)

| Hook | Use |
|---|---|
| `hook_pwa_service_worker_cache_urls_alter(&$cacheUrls, &$cacheableMetadata)` | Add/remove URLs to pre-cache (same as the "URLs to cache" list). |
| `hook_pwa_service_worker_exclude_urls_alter(&$excludeUrls, &$cacheableMetadata)` | Add/remove excluded URL patterns (JS regex). |
| `hook_pwa_service_worker_cache_urls_assets_alter(&$resources)` | Add asset URLs to cache on install. |
| `hook_pwa_service_worker_cache_urls_assets_page_alter(&$resources, $page, $xpath)` | Add per-page asset URLs (e.g. lazy-loaded images) — called once per cached page. |

```php
function mymodule_pwa_service_worker_exclude_urls_alter(&$excludeUrls, &$cacheableMetadata) {
  $excludeUrls[] = 'checkout/.*';
}
```
