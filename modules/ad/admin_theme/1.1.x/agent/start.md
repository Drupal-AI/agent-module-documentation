<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Admin Theme — agent index

Forces Drupal's administration theme onto an arbitrary include/exclude path list, beyond
core's node-edit-only behaviour. Configured on `/admin/appearance` (the `configure` route is
`system.themes_page`). No dedicated settings page, no permissions, no Drush, no plugins.

- **The two config keys, path syntax, the decorator mechanism, drush/config recipes** →
  [configure/paths.md](configure/paths.md)

Key facts:
- Config object `admin_theme.settings`, keys `paths` (Include) and `exclude_paths` (Exclude),
  each a newline-separated list of `request_path` patterns (`*` wildcards, `<front>`).
- Ships a placeholder default for both: `/dummy-path-needed-until-core-issue-2930364-is-fixed`.
- Mechanism: service `admin_theme.admin_context` **decorates** `router.admin_context` so
  `isAdminRoute()` is TRUE on matching paths → admin theme applies.
