# layout_builder_perms_node — agent index

Submodule of [layout_builder_perms](../../../../2.2.x/agent/start.md). Adds **per-content-type**
Layout Builder permissions (all seven operations, per node bundle). No config UI, no Drush.

- Plugin: `NodePermission` (id `content_type`, contexts `entity` + `operation`) via deriver
  `NodeLayoutBuilderPermissions`. `applies()` requires the context entity be a node of the
  plugin's bundle.
- Derivatives are generated for every node bundle whose view display has
  `layout_builder.allow_custom = TRUE`.
- Permission pattern: `{action} {component}s on {bundle} nodes` (e.g. `add blocks on article nodes`).
- AND-combined with other submodules by the parent `AccessManager`. See parent
  [permissions](../../../../2.2.x/agent/permissions/permissions.md) /
  [access model](../../../../2.2.x/agent/extend/access-model.md).
