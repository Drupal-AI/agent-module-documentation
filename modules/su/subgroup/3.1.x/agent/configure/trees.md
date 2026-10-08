# Configure trees & role inheritance

Everything is on one settings form: `/admin/group/subgroup` (`SubgroupSettingsForm`, route
`subgroup.settings`, permission `administer subgroup`). There is no exported settings config object;
state is held in group-type third-party settings + the `subgroup_role_inheritance` config entities.

## 1. Create / grow a tree (group types)

- **Create a new tree** — choose a *Parent* and *Child* group type (needs ≥2 group types not already in
  a tree). Runs `initTree(parent)` then `addLeaf(parent, child)` via the `group_type`/`subgroup` handler.
- **Add another group type** — pick an existing tree node as parent and a free group type as child.
- **Remove** a leaf group type — only shown for extremities (no descendants) and only succeeds if that
  group type has **no groups** (validated).
- Rules enforced: a group type belongs to at most one tree; can't leave a tree while it has groups; only
  extremities can be removed; removing the last leaf removes the root/tree.

Tree position for group types is stored in third-party settings (schema
`group.type.*.third_party.subgroup`): `depth`, `left`, `right`, `tree` (nested-set model, root depth 0).
When a group type joins a tree, `GroupTypeLeafSubscriber` + `SubgroupFieldManager` install the bundle
fields on groups and register the `subgroup:<child_type>` Group relation plugin on the parent type.

## 2. Link actual groups

Individual parent→child group links are **not** made on this form. When the child group type joined the
tree, a `subgroup:<child>` Group relation plugin was created on the parent group type; add a subgroup
through the parent group's normal relationship UI (or the "Configure plugin" link on the tree overview).
The `subgroup_group_relationship_insert` hook then wires the child into the nested set (`addLeaf`).
Group bundle fields carry the per-group bounds: `subgroup_depth`, `subgroup_left`, `subgroup_right`,
`subgroup_tree` (see `config/install/field.storage.group.subgroup_*`).

## 3. Role inheritances

Per root tree, "Set up a new inheritance": pick a **source** group role and a **target** group role.
Valid roles = individual (scope `individual`) roles plus the classic member role (scope `insider`,
global role `authenticated`) of any group type in that tree. Validation requires source ≠ target and
that the two roles' group types are `areVerticallyRelated` (ancestor/descendant). Saved as a
`subgroup_role_inheritance` config entity:

```yaml
# subgroup.subgroup_role_inheritance.<source>-<target>  (schema subgroup.subgroup_role_inheritance.*)
id: <source>-<target>     # md5-hashed if too long
source: <source group_role id>
target: <target group_role id>
tree: <root group_type id>
```

Semantics (from the form's help): a user holding *source* in a group inherits *target* in that group's
ancestors/descendants of the target role's group type. Inheritances **do not chain**; siblings/cousins
are excluded; circular links (A→B and B→A) are allowed precisely because they don't chain.

## How inheritance is applied at runtime

`InheritedGroupPermissionCalculator` (service `subgroup.group_permission.inherited_calculator`, tagged
`flexible_permission_calculator`) runs for the `individual` scope: for each of the user's memberships it
finds inheritances whose source matches the membership's roles, locates the ancestor/descendant groups of
the target group type via the nested-set fields, and adds a `CalculatedPermissionsItem` (the target
role's permissions, honoring its `isAdmin`) per affected group — with full cache-tag/dependency tracking.
The internal `accessCheck(FALSE)` group queries here are tree bookkeeping, not an access decision.
