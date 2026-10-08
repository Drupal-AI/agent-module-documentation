# Layout Options UI (layout_options_ui) — agent index

Submodule of **Layout Options** that swaps existing layouts' plugin class to
`LayoutOptions` (so the parent module's YAML options apply) via an admin form + config +
`hook_layout_alter`. Depends on `layout_options` + `layout_discovery`.

- **The settings form, the `layout_options.settings` / `layout_overrides` config, the key
  format, and how the class swap happens** → [configure/overrides.md](configure/overrides.md)

Key facts:
- Config route `layout_options_ui.settings` → `/admin/config/system/layout_options/config`
  (permission `administer site configuration`).
- Config object **`layout_options.settings`**, key **`layout_overrides`**: a map keyed by
  **`{provider}__{layout_id}`** → boolean (e.g. `layout_discovery__layout_onecol: 1`).
- `layout_options_ui_layout_alter()` sets each enabled layout's class to
  `\Drupal\layout_options\Plugin\Layout\LayoutOptions`.
- Rebuild the layout plugin cache (`drush cr` / `plugin.cache_clearer`) after changing
  overrides. No plugins/permissions/Drush of its own.
