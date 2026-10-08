# Page Cache Exclusion — agent index

Skips core anonymous Internal Page Cache writes for chosen paths / query-param requests / 4xx
responses. Works by decorating `http_middleware.page_cache` with `PageCacheAlter` (overrides `set()`).
Depends on core `page_cache`. `configure` = `page_cache_exclusion.admin`
(`/admin/config/development/performance/page_cache_exclusion`, permission `administer site
configuration`). No permissions/plugins/Drush/services of its own.

- **The 3 settings, path-matching rules, config keys, and how the middleware decides** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Only affects the write path, so it *prevents* caching new responses; it does not purge already-cached
  pages. Only the anonymous page cache — not Dynamic Page Cache / render cache.
- Paths use core `PathMatcher` patterns (`*`, `<front>`) and must begin with `/`. Matched against both
  the internal path and the lowercased alias.
