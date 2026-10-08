# layout_builder_perms_global — agent index

Submodule of [layout_builder_perms](../../../../2.2.x/agent/start.md). Adds seven **global**
Layout Builder operation permissions. No config UI, no Drush.

- Plugin: `GlobalPermission` (id `global`, only `operation` context) via deriver
  `GlobalLayoutBuilderPermissions`; base behavior = `allowedIfHasPermission($permission)`.
- Permissions (on `/admin/people/permissions`): `create/edit/remove layout builder sections`,
  `create/config/remove/reorder layout builder blocks`.
- Combined by the parent's `AccessManager` with AND semantics — global perms plus any scoped
  submodule perms are all required. See parent [permissions](../../../../2.2.x/agent/permissions/permissions.md)
  and [access model](../../../../2.2.x/agent/extend/access-model.md).
- Auto-enabled on update from 1.x for backward compatibility (`layout_builder_perms_update_9101`).
