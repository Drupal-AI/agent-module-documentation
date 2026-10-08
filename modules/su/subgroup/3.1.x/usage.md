Subgroup extends the Group module so group types can be arranged into a hierarchical tree, letting a member's role in one group grant a configurable role in ancestor or descendant groups (role inheritance up or down the tree).

---

Subgroup builds on `group:group` (v3). You first define a **group type tree** on the settings form: pick a parent and child group type to create a tree, then add further group types as leaves. Tree position is stored as nested-set bounds (`subgroup_depth`, `subgroup_left`, `subgroup_right`, `subgroup_tree`) in third-party settings on each group type and in matching bundle fields on groups (managed by `SubgroupFieldManager`). Actual parent/child links between individual groups are created through a per-child `subgroup:<child_type>` Group relation plugin (added automatically when a group type joins the tree). On top of the structure you configure **role inheritances**: a `subgroup_role_inheritance` config entity says "holders of source group-role X also get target group-role Y" between two vertically related group types. At runtime `InheritedGroupPermissionCalculator` (a `flexible_permissions` calculator) walks each membership's tree and adds the inherited role's permissions into the individual permission scope for every affected ancestor/descendant group. The module enforces strong structural integrity: you cannot delete a leaf that still has descendants, cannot delete the subgroup relationship directly, cannot delete a group whose relationship still points at a live group, and cannot globally create a group whose type is a non-root leaf. Inheritances do not chain and are ancestor/descendant-only (siblings excluded), with correct cache-tag invalidation via a tree cache-tag invalidator. All configuration is behind the restricted `administer subgroup` permission.

---

- Nest Group-module groups into a parent/child hierarchy (e.g. Organisation → Department → Team).
- Define which group types may act as ancestors/descendants of one another via a tree.
- Add a new group type as a leaf under an existing node in the tree.
- Remove a leaf group type from a tree (only when it has no groups and no descendants).
- Grant members of a parent group a role in all its subgroups (permissions inherit downward).
- Grant members of a child group a role in ancestor groups (permissions inherit upward).
- Give a project lead admin rights across every descendant team automatically.
- Let regional managers inherit membership in all sub-region groups beneath them.
- Map the "member" (insider/authenticated) role of one group type to a role in a related type.
- Set up multiple independent inheritance links within the same tree.
- Allow circular inheritance links between two group types (A↔B) since inheritances do not chain.
- Prevent accidental deletion of a group type that still has child group types in the tree.
- Prevent deletion of a group that still has live subgroups attached.
- Forbid creating a subgroup-typed group at the site root (must be created as a subgroup).
- Configure the auto-generated `subgroup:<child>` Group relation plugin (e.g. cardinality) per child type.
- Add subgroups to a group through the group's own relationship UI.
- React to a group/group type being added to or removed from a tree via Leaf events.
- Model franchise/affiliate site structures where access flows down the corporate tree.
- Build course → module → cohort access hierarchies for e-learning.
- Keep inherited permissions cache-correct as memberships, roles, and tree structure change.
- Programmatically query ancestors, descendants, children, and parents via the `subgroup` entity handler.
- Enforce that only tree extremities (leaves) can be manipulated, preserving tree integrity.
- Provide multi-tenant access control where each tenant is a subtree with inherited staff roles.
