<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Page Expiration (APE) — agent index

Fine-grained `Cache-Control: max-age` control for external caches (Varnish/CDN): different
page cache lifetimes by **path** and by **HTTP status code**. All state lives in the
`ape.settings` config object; behaviour is applied by an event subscriber + a page-cache
response policy.

- **Config keys, the admin form/route/permission, system.performance interplay** →
  [configure/settings.md](configure/settings.md)
- **How the header is computed (subscriber, status overrides, exclusions, `ape_cache_set`,
  `hook_ape_cache_alter`)** → [api/behavior-and-hook.md](api/behavior-and-hook.md)

Key facts:
- Config object **`ape.settings`**: `alternatives` (path list, string), `exclusions` (path
  list, string), `lifetime.alternatives`, `lifetime.301`, `lifetime.302`, `lifetime.404` (ints).
  The **default** lifetime is core's `system.performance` → `cache.page.max_age`.
- Admin UI: **`/admin/config/development/performance/ape`** (route `ape.admin`,
  permission `administer ape`, form id `ape_settings`).
- A **403** response is always forced to `max-age=0`; **excluded** paths are denied caching.
- Extend via `ape_cache_set($age)` (pre-set, e.g. Rules) or `hook_ape_cache_alter(&$max_age, $original)`.
- Submodule **`ape_test`** = test-only redirect/landing endpoints (documented separately).
