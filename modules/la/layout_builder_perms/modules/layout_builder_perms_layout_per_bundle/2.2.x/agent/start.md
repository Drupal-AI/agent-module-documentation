# layout_builder_perms_layout_per_bundle — agent index

Submodule of [layout_builder_perms](../../../../2.2.x/agent/start.md). Adds **section**
permissions scoped by entity type + bundle **and** layout id (any entity type, not only nodes).
No config UI, no Drush.

- Plugin: `EntityPermission` (id `entity`, contexts `entity` + `layout` + `operation`) via
  deriver `EntityLayoutBuilderPermissions`. `applies()` requires matching layout id, entity type,
  and bundle; `section_edit` split into add/edit via `layout_builder_perms.action` third-party
  setting.
- Derivatives generated for every display with `layout_builder.allow_custom = TRUE`.
- Permission pattern: `{action} {layout_id} layouts on {bundle} {entity_type} entities`.
- Section operations only. AND-combined by the parent `AccessManager`. See parent
  [permissions](../../../../2.2.x/agent/permissions/permissions.md) /
  [access model](../../../../2.2.x/agent/extend/access-model.md).
