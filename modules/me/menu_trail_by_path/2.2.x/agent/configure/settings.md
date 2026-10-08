# Configure Menu Trail By Path

Form `MenuTrailByPathSettingsForm` at `/admin/config/system/menu_trail_by_path/settings`
(route `menu_trail_by_path.settings`). Simple config `menu_trail_by_path.settings`
(schema `config/schema/menu_trail_by_path.schema.yml`).

Keys (defaults from `config/install/menu_trail_by_path.settings.yml`):
```yaml
trail_source: 'path'   # 'path' | 'core' | 'disabled'
max_path_parts: 0      # 0 = unlimited depth; N limits how many path segments are resolved
```

**Trail source** options (`MenuTrailByPathActiveTrail` constants):
- `path` (**By Path**) — find a matching parent menu link by walking the URL path structure.
  Slower with many path parts.
- `core` (**Drupal Core Behavior**) — active trail only for pages that have a direct menu link
  (as if the module were off).
- `disabled` (**Disabled**) — no active trail at all; zero overhead (good for footer/special menus).

**Maximum path parts** — caps how deep the path walk goes; only applies to the `path` source.
Restrict it (and which menus use `path`) to avoid unnecessary performance overhead.

## Per-menu override
`menu_trail_by_path_form_menu_form_alter()` adds a **Menu Trail Source** select to each menu's
edit form, stored as third-party settings `system.menu.{id}.third_party.menu_trail_by_path.trail_source`.
Leave it empty to use the global default, or pick a source for that one menu.
