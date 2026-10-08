# block_visibility_groups — agent start

Defines a reusable `block_visibility_group` config entity that bundles core/contrib **Condition**
plugins under one AND/OR rule set; many blocks attach to a group and share its conditions. Adds a
`condition_group` visibility plugin to every block. Depends only on core `block` (CTools is
*recommended*, not required — it just ships extra conditions). Admin UI:
**Admin → Structure → Block Layout → Block Visibility Groups**
(`/admin/structure/block/block-visibility-group`), route `entity.block_visibility_group.collection`.

- Create groups, add conditions, set AND/OR logic, assign blocks → [configure/config.md](configure/config.md)
- The `condition_group` plugin + how core/CTools conditions plug in → [plugins/plugins.md](plugins/plugins.md)
- Evaluate a group / manage the entity in code → [api/api.md](api/api.md)
- Permissions gating the UI → [permissions/permissions.md](permissions/permissions.md)
