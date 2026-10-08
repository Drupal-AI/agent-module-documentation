# Page Cache Query Ignore — agent index

Makes Drupal's anonymous **Internal Page Cache** ignore chosen query parameters when computing
the cache key, so `?gclid=…` / `?utm_*=…` variants of a URL share one cache entry. It replaces
core's `http_middleware.page_cache` service with a `PageCacheIgnore` subclass. No permissions of
its own (the form uses core's `administer site configuration`), no Drush, no plugins.

- **Configure the ignore list, exclude-vs-include action, and redirect handling (form + config keys + drush config)** →
  [configure/settings.md](configure/settings.md)
- **Extend the parameter list / query normalization at runtime (alter hook + 2 events)** →
  [api/events-hooks.md](api/events-hooks.md)

Key facts:
- Config object: `page_cache_query_ignore.settings` with keys `query_parameters` (sequence of
  strings), `ignore_action` (`exclude` | `include`), `ignore_redirects` (bool).
- Config form route: `page_cache_query_ignore.admin` →
  `/admin/config/development/performance/page_cache_query_ignore`.
- Only affects the anonymous page cache; requires core `page_cache`. Not a CDN replacement.
