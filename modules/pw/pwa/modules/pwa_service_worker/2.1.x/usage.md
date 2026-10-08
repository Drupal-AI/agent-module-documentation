PWA Service Worker adds an (experimental) service worker to a Drupal PWA so pages and assets can be cached and an offline fallback page is shown when the network is unavailable.

---

This submodule registers a service worker that gives the base PWA an offline experience. It serves the service-worker registration/data at `/service-worker-data`, an offline fallback page at `/offline`, and a `/pwa/phone-home` endpoint used to detect that the module is active; a `ResponseSubscriber` event subscriber injects the registration into responses and it attaches its JS on page load and user login. Behaviour is configured in the `pwa_service_worker.config` config object (form at `/admin/config/services/pwa/service-worker`, route `pwa_service_worker.config`, permission `administer pwa`): `urls_to_cache` (paths/patterns to pre-cache on install), `urls_to_exclude` (paths never cached — default excludes `admin/.*` and `user/.*`), `offline_page` (the fallback path, default `/offline`), `cache_version` (bump to invalidate the cache), and `skip_waiting` (activate a new service worker immediately). Four alter hooks (`hook_pwa_service_worker_cache_urls_alter`, `_exclude_urls_alter`, `_cache_urls_assets_alter`, `_cache_urls_assets_page_alter`) let modules programmatically shape the cached URL and asset lists. The module is marked **experimental** and depends on the base `pwa` module.

---

- Cache key pages and assets so a PWA keeps working offline or on flaky networks.
- Show a friendly offline fallback page (`/offline`) when the network is down.
- Pre-cache a curated list of URLs on service-worker install (`urls_to_cache`).
- Exclude admin and user paths from caching (default `admin/.*`, `user/.*`).
- Invalidate all cached content by bumping the `cache_version`.
- Force an updated service worker to activate immediately with `skip_waiting`.
- Programmatically add node URLs to the cache list via hook_pwa_service_worker_cache_urls_alter().
- Exclude additional path patterns from caching via hook_pwa_service_worker_exclude_urls_alter().
- Cache extra asset URLs (e.g. lazy-loaded images) via the assets alter hooks.
- Provide app-like reliability on mobile for a Drupal PWA.
- Detect whether the service worker module is active via the /pwa/phone-home endpoint.
- Customize the offline page path to a themed maintenance page.
- Reduce repeat load times by serving cached assets from the service worker.
- Combine with the base manifest and pwa_a2hs for an installable, offline-capable app.
- Roll out cache changes safely by versioning the service-worker cache.
- Serve a bundled offline image/template when content is unavailable.
