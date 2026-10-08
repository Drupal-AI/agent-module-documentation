# layout_builder_perms_block_operations_per_layout — agent index

Submodule of [layout_builder_perms](../../../../2.2.x/agent/start.md). Adds **per-layout block**
permissions (block add/config/remove/reorder, per layout id). No config UI, no Drush.

- Plugin: `LayoutPermission` (id `layout`, contexts `layout` + `operation`) via deriver
  `LayoutLayoutBuilderPermissions`. `applies()` requires the section's layout id to match.
- Derivatives: one per (layout × {block_reorder, block_add, block_config, block_remove}).
- Permission pattern: `{action} {component}s in {layout_id} layouts` (e.g. `add blocks in layout_twocol layouts`).
- Block operations only. AND-combined by the parent `AccessManager`. See parent
  [permissions](../../../../2.2.x/agent/permissions/permissions.md) /
  [access model](../../../../2.2.x/agent/extend/access-model.md).
