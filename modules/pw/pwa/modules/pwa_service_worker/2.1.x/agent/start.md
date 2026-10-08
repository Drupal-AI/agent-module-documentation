# PWA Service Worker — agent index

Adds an (experimental) service worker to a Drupal PWA for offline caching + an offline fallback page.
Configured via `pwa_service_worker.config`. Depends on `pwa`. No permissions of its own.

- **Config keys, the form, the routes, and the cache-list alter hooks** →
  [configure/service-worker.md](configure/service-worker.md)

Key facts:
- Config object `pwa_service_worker.config`; form route `pwa_service_worker.config` →
  `/admin/config/services/pwa/service-worker` (permission `administer pwa`).
- Keys: `urls_to_cache`, `urls_to_exclude` (default `admin/.*`, `user/.*`), `offline_page`
  (default `/offline`), `cache_version` (default `1`), `skip_waiting` (bool, default false).
- Routes: `/service-worker-data` (registration), `/offline` (fallback page), `/pwa/phone-home` (active check).
- Alter hooks: `hook_pwa_service_worker_cache_urls_alter`, `_exclude_urls_alter`,
  `_cache_urls_assets_alter`, `_cache_urls_assets_page_alter`.
- **Experimental** lifecycle.
