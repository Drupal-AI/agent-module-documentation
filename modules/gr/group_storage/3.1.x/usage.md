<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Group Storage lets Storage entities be added to a Group as group content, so each group owns its Storage records and access to them is decided by that group's permissions and roles.

---

Two modules meet here. **Group** models sets of users with their own membership, roles and permissions — departments, teams, courses, clubs — and provides an access system in which content belongs to a group and a group role decides who may do what with it. **Storage Entities** provides a lightweight, bundleable content entity for data that should be stored but not browsed or managed directly by site users: it has its own bundles ("storage types") and fields, but no front-end listing of its own. Group Storage is the thin bridge between them. It registers a single Group relation plugin, `group_storage`, whose deriver (`GroupStorageDeriver`) emits one relation per Storage type on the site, so an administrator can enable, per group type, exactly which Storage types a group may hold. The relation is declared with `entity_access: TRUE` and a forced entity cardinality of 1, meaning each relationship links a group to one Storage entity and the group's permissions participate in that entity's access decision. On top of the relation the module adds convenience routes and UI: a route subscriber rewrites Group's generic add/create-content pages to friendly paths `group/{group}/storage/add` and `group/{group}/storage/create` (with `base_plugin_id` pinned to `group_storage`), action links "Add existing storage" and "Add new storage", an `access group_storage overview` group permission, a `hook_entity_operation` that puts a "Storages" operation on each group, and an optional Views display (`view.group_storages.page_1`) at `group/%group/storages` that lists a group's storage, gated by that overview permission and scoped by the group-id argument. A `GroupStoragePermissionProvider` handler decorates Group's default provider only to keep a backwards-compatible permission name for the legacy "view unpublished … any" case; all other permission names come straight from Group. Version **3.1.0**, core `^11` (Drupal 11 only), requiring `group` (^3.0) and `storage` (^1.2), optionally combined with Subgroup or Subgroup (Graph). The important thing to understand before relying on it: group permissions here **grant** access to storage that belongs to a group; they do not, on their own, **revoke** access that the Storage module's own site-wide permissions already grant — so who can reach a group's storage is a product of both permission systems, not the group's alone.

---

- Give each group its own set of Storage records.
- Scope structured, non-node data to a group by membership.
- Let group roles decide who may view/edit/delete a group's storage.
- Store a department's asset register inside its group.
- Keep a team's contact list private to that team's group.
- Hold per-course records (e.g. grades) on a course group.
- Manage a club's equipment inventory as group content.
- Choose per group type which Storage types a group may hold.
- Add an existing Storage entity to a group via group/{group}/storage/add.
- Create a new Storage entity directly in a group via .../storage/create.
- List a group's storage at group/{group}/storages behind a group permission.
- Put a "Storages" operation link on each group in the groups admin list.
- Replace a hand-built group-reference field plus custom access hook.
- Apply membership-based access to reusable structured records.
- Enforce a cardinality-1 link between a group and a storage item.
- Combine with Subgroup / Subgroup (Graph) to scope storage across a hierarchy.
- Keep bulk structured data out of the node system while still group-scoping it.
- Grant "access group_storage overview" to let a role see the group's storage list.
- Model an editorial team's shared reference data per group.
- Store per-group metadata or configuration-like records as entities.
