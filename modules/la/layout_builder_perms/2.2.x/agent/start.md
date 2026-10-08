# Layout Builder Advanced Permissions — agent index

Fine-grained, pluggable permissions for core Layout Builder. Depends on `layout_builder`.
No config UI (`configure` null), no Drush — everything is role permissions on
`/admin/people/permissions`. Base module provides the `access layout builder page` permission
and the `LayoutBuilderPermission` plugin type; **granular permissions come from the six
submodules** (enable the ones you need).

Docs:
- **Every permission, the dynamic per-bundle "configure own editable …" perms, and how granular
  perms combine** → [permissions/permissions.md](permissions/permissions.md)
- **The `LayoutBuilderPermission` plugin type + deriver base — how to add your own gate** →
  [plugins/layout-builder-permission.md](plugins/layout-builder-permission.md)
- **Runtime access model: route ops, AdvancedAccessCheck, AccessManager, the OverridesSectionStorage
  override, and the default-allow behavior** → [extend/access-model.md](extend/access-model.md)

Submodules (own docs):
- Global perms → [../../modules/layout_builder_perms_global/2.2.x/agent/start.md](../../modules/layout_builder_perms_global/2.2.x/agent/start.md)
- Per content type → [../../modules/layout_builder_perms_node/2.2.x/agent/start.md](../../modules/layout_builder_perms_node/2.2.x/agent/start.md)
- Per layout type (sections) → [../../modules/layout_builder_perms_layout_type/2.2.x/agent/start.md](../../modules/layout_builder_perms_layout_type/2.2.x/agent/start.md)
- Per entity type + bundle (sections) → [../../modules/layout_builder_perms_layout_per_bundle/2.2.x/agent/start.md](../../modules/layout_builder_perms_layout_per_bundle/2.2.x/agent/start.md)
- Block operations per layout → [../../modules/layout_builder_perms_block_operations_per_layout/2.2.x/agent/start.md](../../modules/layout_builder_perms_block_operations_per_layout/2.2.x/agent/start.md)
- Block types per layout → [../../modules/layout_builder_perms_block_types_per_layout/2.2.x/agent/start.md](../../modules/layout_builder_perms_block_types_per_layout/2.2.x/agent/start.md)

Key facts:
- Seven operations (`AccessManagerInterface::LAYOUT_BUILDER_OPERATIONS`): `block_reorder`,
  `block_add`, `block_config`, `block_remove`, `section_add`, `section_edit`, `section_remove`.
- `RouteSubscriber` maps each core `layout_builder.*` route to one operation via a
  `_layout_builder_perms_access` requirement (core's own `_layout_builder_access` stays too).
- `access layout builder page` alone satisfies the base per-entity override gate (OR'd, no
  ownership check).
