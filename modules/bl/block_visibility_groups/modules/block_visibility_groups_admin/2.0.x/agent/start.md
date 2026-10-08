# block_visibility_groups_admin — agent start

Optional UI-helper ("development helper") submodule of **block_visibility_groups**. Depends only on
its parent (`block_visibility_groups:block_visibility_groups`); defines no permissions, config or
config schema. Its job: a **ConditionCreator** plugin type + a "create a group from the current page"
form. Group collection lives under **Structure → Block layout → Block visibility groups** (menu link
`block_visibility_groups_admin.settings` → route `entity.block_visibility_group.collection`, owned by
the parent module).

- Create-group-from-page form, routes & menu link → [configure/config.md](configure/config.md)
- The `ConditionCreator` plugin type (manager, annotation, how to add one) → [plugins/plugins.md](plugins/plugins.md)
- Which permissions gate the routes (all core, none defined here) → [permissions/permissions.md](permissions/permissions.md)
