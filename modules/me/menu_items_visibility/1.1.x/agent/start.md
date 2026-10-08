# Menu Item Visibility — agent index

Adds a per-menu-link "Visibility settings" fieldset (roles + optional node Path Access) to custom
menu-link edit forms. Procedural `.module`, no config UI route (`configure` null), no permissions of
its own, no Drush. Depends on core `menu_ui`. Config object: `menu_items_visibility.settings`.

- **The visibility fieldset, how settings are stored, the render-time role filter, and the node
  Path-Access check** → [configure/visibility.md](configure/visibility.md)

Key facts:
- Config keyed by menu link **plugin ID**: `mlid.<plugin_id>.roles` (array) and
  `mlid.<plugin_id>.access_check` (bool). Schema: `config/schema/menu_items_visibility.schema.yml`.
- `hook_preprocess_menu()` hides links whose roles don't intersect the current user's roles
  (empty roles = visible to all). This is display-only filtering, not route protection.
- `hook_node_access()` returns `forbidden()` for a node when a link with `access_check` on points at
  it and the role check fails — the only part that actually blocks content access.
