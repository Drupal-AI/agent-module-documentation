# Collapsible Drag 'n Drop — agent index

Adds collapse/expand toggles (and optional expand-all / collapse-all / search toolbar) to Drupal's
draggable `tabledrag` tables, auto-applied everywhere via a library dependency on
`drupal.tabledrag`. Provides one permission and a config form; no Drush, no plugin types.

- **Settings form, config keys, route-pattern matching logic, the JS settings bridge and hooks** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Settings route `collapsible_dnd.settings` at `/admin/config/user-interface/collapsible-dnd`,
  form `CollapsibleDndConfigForm`, permission **`administer collapsible dnd settings`**
  (info.yml declares no `configure`, so `data.json.configure` is null).
- Config object `collapsible_dnd.settings`: `route_patterns` (string, newline-separated, `*`
  wildcards), `negate_route_patterns` (bool), `expand_all` / `collapse_all` / `search` (bool, all
  default FALSE); `route_patterns` default `''`.
- Service `collapsible_dnd.settings` = `CollapsibleDndSettings` (arg `@config.factory`):
  `getJavascriptSettings()`, `isRouteEnabled()` (empty patterns = everywhere; otherwise exclusion
  list, or allow list when `negate_route_patterns`).
- Library `collapsible_dnd/collapsible_draggables` is added as a dependency of core
  `drupal.tabledrag` in `hook_library_info_alter`; `hook_page_attachments` sets
  `drupalSettings.collapsibleDnd`; `hook_preprocess_html` adds a `theme-<admin_theme>` body class.
- (`tests/modules/collapsible_dnd_test` is a test-only helper module — not documented.)
