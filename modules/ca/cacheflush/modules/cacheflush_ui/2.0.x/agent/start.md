# CacheFlush UI — agent index

The admin UI for CacheFlush presets: collection, add/edit/delete forms, the granular own/any
permission model, and the option to expose a preset in the admin menu. Depends on `cacheflush` +
`views_ui`. No configure route of its own, no Drush. Ships config schema for its Action plugins.

Core facts:
- Turns the bare `cacheflush` entity into a manageable one via `hook_entity_type_alter()` (access
  handler, list builder, forms, views_data, link templates).
- Collection: `/admin/structure/cacheflush` (`entity.cacheflush.collection`); add:
  `/admin/structure/cacheflush/add`; edit/delete/view under `/cacheflush/{cacheflush}`; settings tab
  `/admin/structure/cacheflush/settings`.
- Adds a **`menu`** base field: a published preset with `menu = 1` appears under the Cacheflush admin
  menu (via `hook_menu_links_discovered_alter()` → clear-by-id route).
- Preset form groups the option catalog into **vertical tabs** (`hook_cacheflush_ui_tabs()`).

Docs:
- **Routes, the preset form/tabs, the `menu` field, actions** → [configure/ui.md](configure/ui.md)
- **The ten permissions and the own/any access handler** →
  [permissions/permissions.md](permissions/permissions.md)
