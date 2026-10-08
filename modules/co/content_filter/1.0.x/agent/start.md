<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content filter (content_filter) — agent index

**Per-content-type admin listing pages under Content, each embedding the core `content` view locked to one node type.**

- **Version:** 1.0.x  **Core:** ^10.2 || ^11
- **Config route:** `content_filter.settings` → `/admin/config/user-interface/content-filter` (perm `administer content_filter`)
- **Pages:** `content_filter.main` `/admin/content/filtered` and `content_filter.filtered` `/admin/content/filtered/{node_type}` (perm `access administration pages`, `_admin_route`)
- **Requires:** the default `content` view enabled.
- **Mechanics:** `hook_views_pre_view` injects an *Add* button + locks the bundle filter; `hook_menu_links_discovered_alter` adds/removes Content submenu links; `CFService` builds filter/header config.
- **Security:** admin routes gated by `administer content_filter` / `access administration pages`; embedded `content` view enforces its own access. Header link built via Link API + renderer, titles via `t()` placeholders — no raw markup concatenation, so no XSS-bypass. No mutating public endpoints.

See [configure/settings.md](configure/settings.md).
