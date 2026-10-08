# Toolbar Visibility — agent index

Hides the core admin toolbar on selected themes (and, with the `domain` module, selected
domains). One `hook_page_top` that `unset()`s `$page_top['toolbar']`, plus one settings form.
Depends on core `toolbar`. No config schema, no plugins, no Drush, no services.

- **The settings form, config keys, and the page_top logic** →
  [configure/settings.md](configure/settings.md)
- **The `administer toolbar visibility` permission** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Config UI: `/admin/config/toolbar-visibility` (route `toolbar_visibility.settings`, perm
  `administer toolbar visibility`).
- Config object `toolbar_visibility.settings`: `themes` (map `theme_name => bool`) and, if
  `domain` is enabled, `domains` (array of active domain ids). No schema file ships.
- `hook_page_top` removes the toolbar when the active theme is flagged, or (with `domain`) when the
  active domain id is in `domains`.
