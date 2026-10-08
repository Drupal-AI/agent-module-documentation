Group lets you bundle users, content and other entities into "groups" (spaces, teams, communities, sections) that each have their own members, roles and permissions, independent of the sitewide role/permission system.

---

Group models a group as a fielded content entity (`group`) of a configurable `group_type`. Anything a group "contains" — members, nodes, other entities — is attached through a `group_relationship` content entity whose behaviour is defined by a `GroupRelationType` plugin (the `group_membership` plugin relates users; the `gnode` submodule's `group_node` plugin relates nodes). To relate an entity type you install its relation plugin onto a group type, which creates a `group_relationship_type` config entity. Access is governed per-group by `group_role` config entities scoped as **outsider**, **insider** or **individual**; the outsider/insider scopes synchronize with sitewide roles while individual roles are assigned to specific memberships. Permission calculation is delegated to the `flexible_permissions` module: `IndividualGroupPermissionCalculator` and `SynchronizedGroupPermissionCalculator` feed a chain that the `group_permission.checker` service consults via `$group->hasPermission()`. Members are loaded through static methods on `Drupal\group\Entity\GroupMembership` (the old `group.membership_loader` service is deprecated). Note the v3 rename: the v1/v2 `GroupContent` entity, `GroupContentType`, and `GroupContentEnabler` plugin type are now `GroupRelationship`, `GroupRelationshipType` and the `GroupRelationType` plugin. Group ships submodules `gnode` (relate nodes) and `group_support_revisions` (per-group revision access).

---

- Build private team/workspace areas where each group has its own members and content.
- Model a community platform where users create and join groups.
- Give departments or clients isolated content sections on one Drupal site.
- Add users to a group as members with `$group->addMember($user)`.
- Relate a node (or any entity) to a group with `$group->addRelationship($entity, $plugin_id)`.
- Define distinct `group_type`s (e.g. "Team", "Club", "Course") with different enabled content.
- Install a `GroupRelationType` plugin onto a group type to allow relating that entity type.
- Grant per-group permissions via `group_role` entities instead of sitewide roles.
- Synchronize a sitewide role into every group as an outsider/insider role.
- Assign individual per-member roles (e.g. make one member a group admin).
- Check a per-group permission with `$group->hasPermission('edit group', $account)`.
- Let users join/leave groups through the `join group` / `leave group` permissions.
- Restrict who can view a group with published/unpublished group permissions.
- Give each group its own revision history and gate revision access per group (group_support_revisions).
- Relate nodes to groups publicly or privately per node type (gnode submodule).
- Expose group-scoped Views using the Group permission Views access plugin and group relationship relationships.
- Add group operations (join/leave/manage) to a group via the Group Operations block.
- Enforce cardinality limits on how many groups an entity may belong to (entity/group cardinality).
- Build a group content overview listing all entities related to a group.
- Create a custom `GroupRelationType` plugin to make any entity type groupable.
- Decorate a relation's permission/access/operation handler to alter group behaviour.
- Load all of a user's memberships with `GroupMembership::loadByUser($account)`.
- Load all members of a group, optionally filtered by role, with `GroupMembership::loadByGroup($group)`.
- Have the group creator automatically become a member (creator membership / creator wizard).
- Use group permission cache contexts to vary rendered output per group membership.
- Migrate from Organic Groups to a structured group/relationship model.
- Deploy group types, roles and enabled content plugins as exportable configuration.
