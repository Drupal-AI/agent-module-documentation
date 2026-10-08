# Group Content Menu — agent index

Per-group menus for the **Group** module, stored as **content** entities (not config) so they
scale with group count. Depends on `group`, `block`, `menu_link_content`, `menu_ui`.

- **Create menu types, enable on a group type, place the block, auto-create options** →
  [configure/setup.md](configure/setup.md)
- **Permissions (global + per-group)** → [permissions/permissions.md](permissions/permissions.md)
- **Entity model + plugins (relation, block, condition, parent selector) for developers** →
  [api/model.md](api/model.md)

Key facts:
- Config UI / configure route: `entity.group_content_menu_type.collection`
  (`/admin/structure/group_content_menu_types`).
- Two entities: **`group_content_menu`** (content, revisionable, translatable) and its bundle
  **`group_content_menu_type`** (config entity, config prefix `group_content_menu.group_content_menu_type.*`).
- Group relation plugin id `group_content_menu` (derived per type by `GroupMenuDeriver`).
- Block plugin id `group_content_menu` (derived per type; settings: `level`, `depth`,
  `expand_all_items`, `relative_visibility`).
- Global permission `administer group content menu types`; group permissions: `access group
  content menu overview`, `manage group_content_menu`, `manage group_content_menu menu items`.
- Per-group menus managed at `/group/{group}/menus`.
