# Meta Position — agent index

Moves the node form's advanced metadata panel below the main form as vertical tabs, optionally per content type.
CSS-only, depends on core `node`. No permissions file, no Drush, no plugins.

- **The two config keys, the settings form, and how the node form is altered** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Config object `meta_position.settings`: `enabled` (int 0/1, default 0), `node_types` (sequence of bundle
  machine names; empty = all).
- Settings form route `meta_position.settings` at `/admin/config/content/meta`; requires permission
  `administer site` (non-standard — effectively user 1 only unless a custom role grants it).
- Logic: `hook_form_node_form_alter` + `#process` callback `meta_position_form_node_form_process` in
  `meta_position.module`; attaches library `meta_position/node_meta`.
