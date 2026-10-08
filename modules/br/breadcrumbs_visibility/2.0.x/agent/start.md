# Breadcrumbs Visibility — agent index

Adds a per-node `display_breadcrumbs` boolean (plus a per-content-type default) that suppresses
the core `system_breadcrumb_block` on individual nodes via `hook_block_access`. No settings
page (`configure` null). Depends on `block`, `node`, `system`.

- **The field, the per-type default config, the block-access logic, and the permission** →
  [configure/settings.md](configure/settings.md)
- **The `administer breadcrumbs visibility config` permission** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Base field `display_breadcrumbs` (boolean, revisionable, translatable, default TRUE) on nodes
  (`hook_entity_base_field_info`); shown in a "Page display options" group on the node form.
- Per-type default stored in config `breadcrumbs_visibility.content_type.<bundle>` key
  `display_breadcrumbs`; used for new nodes when the node value is NULL.
- `hook_block_access`: for `system_breadcrumb_block` + `view`, returns `forbidden` when the
  resolved value `== "0"`, else `neutral`.
