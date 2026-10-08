<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Critical CSS — agent index

Inlines a page-specific critical CSS file into the `<head>` and loads the rest of the CSS
asynchronously. You pre-generate the files and drop them in a theme directory; the module
picks the most specific match per request. Config-only, no plugins, no Drush, no permission
of its own (settings form uses core `administer site configuration`).

- **Settings keys, the config form, and how a file is matched** →
  [configure/settings.md](configure/settings.md)
- **The runtime services (provider + CSS renderer decorator) and when it is disabled** →
  [api/provider.md](api/provider.md)
- **Adding/reordering candidate file paths via hook** →
  [hooks/file-paths.md](hooks/file-paths.md)

Key facts: config object `critical_css.settings` (`enabled`, `dir_path`, `excluded_ids`,
`enabled_for_logged_in_users`, `preload_non_critical_css`); form at
`/admin/config/development/performance/critical-css` (route `critical_css.settings`).
Match order ends in `default-critical.css`. Ships **no** config/install defaults — inert
until enabled with a `dir_path` set. Always disabled on admin routes and AJAX.
