# http_cache_control — agent index

Adds fine-grained `Cache-Control` / `Surrogate-Control` / targeted CDN cache headers on top
of Drupal core's single page-cache max-age. No own admin page: it **alters the core
Performance form** and stores everything in one config object, `http_cache_control.settings`.
No dependencies, permissions, plugins, services (beyond one event subscriber) or Drush commands.

- **[configure/http_cache_control.md](configure/http_cache_control.md)** — where the UI lives
  (`/admin/config/development/performance`, route `system.performance_settings`), every
  `http_cache_control.settings` key, and `drush config:set` recipes (s-maxage, stale-*,
  Surrogate-Control, targeted `CDN-Cache-Control`).
- **[api/headers.md](api/headers.md)** — how `CacheControlEventSubscriber` maps config to
  outgoing headers: which directives, per-status-code max-age (404/301/302), the cacheability
  gate, and the targeted-header value builder.
