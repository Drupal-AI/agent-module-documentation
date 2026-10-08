# layout_builder_perms_block_types_per_layout — agent index

Submodule of [layout_builder_perms](../../../../2.2.x/agent/start.md). Adds the **finest-grained**
block permissions: block operations scoped by inline **block content type** AND layout id. No
config UI, no Drush.

- Plugin: `InlineBlockTypeInLayoutPermission` (id `inline_block_type_in_layout`, contexts `block`
  + `layout` + `operation`) via deriver `InlineBlockTypeInLayoutPermissions`. `applies()`
  requires both the section layout id and the block content bundle to match.
- Derivatives: one per (layout × block_content_type × {block_reorder, block_add, block_config,
  block_remove}).
- Permission pattern: `{action} {block_type} {component}s in {layout_id} layouts`
  (e.g. `add basic blocks in layout_twocol layouts`).
- The `block` context on `add_block` comes from the parent's `ContentBlockTypePluginContext`
  subscriber. AND-combined by the parent `AccessManager`. See parent
  [permissions](../../../../2.2.x/agent/permissions/permissions.md) /
  [access model](../../../../2.2.x/agent/extend/access-model.md).
