# Subgroup — agent index

Arranges Group (`group:group` v3) group types into a hierarchical **tree** and inherits group roles up
or down that tree. Config UI at `/admin/group/subgroup` (route `subgroup.settings`, permission
`administer subgroup`, restricted). Provides config schema and a `subgroup_role_inheritance` config
entity; no Drush; no new plugin *type* (it adds a `subgroup:<child>` Group **relation** plugin per child
type). Runtime inheritance is a `flexible_permissions` calculator.

- **Build trees, add/remove leaves, and set up role inheritances (settings form, config entity, storage schema)** →
  [configure/trees.md](configure/trees.md)
- **The `subgroup` entity handler API, GroupLeaf/GroupTypeLeaf wrappers, the permission calculator, and Leaf events** →
  [api/handlers.md](api/handlers.md)

Key facts:
- Tree position = nested-set fields `subgroup_depth/left/right/tree` (group bundle fields + group_type
  third-party settings). Root has depth 0.
- Structural guards are all fail-closed in `subgroup.module`: cannot delete a leaf with descendants,
  cannot delete the `subgroup` relationship directly, cannot delete a group whose relationship still
  points at a live group, cannot create a non-root-leaf group type globally.
- Inheritances are ancestor/descendant-only, **do not chain**, and are set per `subgroup_role_inheritance`
  entity (source role → target role, bound to a tree).
- Single restricted permission `administer subgroup`.
