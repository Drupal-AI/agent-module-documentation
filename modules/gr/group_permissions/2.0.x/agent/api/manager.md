# API: manager service, calculators, runtime application

## Service `group_permissions.group_permissions_manager`

Class `Drupal\group_permissions\GroupPermissionsManager` implements
`GroupPermissionsManagerInterface`. Constructor args: `@cache.default`, `@entity_type.manager`.
This is the entry point for reading a group's overrides.

| Method | Returns | Purpose |
|---|---|---|
| `getGroupPermission(GroupInterface $group)` | `GroupPermission|null` | Load the (single) override entity for a group; statically cached. |
| `getCustomPermissions(GroupInterface $group)` | `array` | `[role_id => [perms]]` from a **published** override entity; cached under `custom_group_permissions:{gid}` (tags `group:{gid}`, `group_permission:{bundle}:{id}`). Empty array if none/unpublished. |
| `getAll()` | `GroupPermission[]` | All active (published) override entities (`status = 1`). |
| `getNonAdminRoles(GroupInterface $group)` | `GroupRole[]` | The group type's non-admin roles (`admin = 0`) — the editable columns. |
| `grantPermission($group, $role_id, $permission)` | void | Add one permission to a role in the group's override set (validates + saves). Throws if the group has no override entity. |
| `revokePermission($group, $role_id, $permission)` | void | Remove one permission from a role. Throws if the group has no override entity. |
| `getGroupRelationshipEntityType()` | string | `'group_relationship'` (Group 3.x) or `'group_content'` (Group 2.x) — version-agnostic helper. |

`loadByGroup()` also exists but is **deprecated** as of 2.0.0-alpha13 (use `getGroupPermission()`).

```php
$manager = \Drupal::service('group_permissions.group_permissions_manager');
$manager->grantPermission($group, 'my_type-member', 'edit group');
$manager->revokePermission($group, 'my_type-member', 'delete group');
$perms = $manager->getCustomPermissions($group); // ['my_type-member' => ['edit group', …]]
```

## How overrides reach an access decision

The module decorates Group's permission checker and adds two calculators, so overrides flow
through Group's normal `flexible_permissions` pipeline rather than a side channel.

- **`group_permissions.checker`** decorates `group_permission.checker`
  (`Access\GroupPermissionChecker` extends Group's checker). In `hasPermissionInGroup()`, when the
  group has an override entity it looks up calculated items under the identifier
  `group_permission:{bundle}:{gid}` (Individual scope first, then Insider/Outsider depending on
  membership); otherwise it falls back to Group's default identifiers (`{gid}` / `{bundle}`).
  Because every override identifier embeds the specific group id, overrides never leak between
  groups.
- **`IndividualGroupPermissionCalculator`** (`group_permissions.individual_calculator`, tag
  `flexible_permission_calculator`, priority -250) — for the INDIVIDUAL scope. Iterates the
  account's memberships; for each group whose type has the feature enabled and that has an
  override entity, emits a `CalculatedPermissionsItem` per membership role with that role's
  overridden permission list.
- **`SynchronizedGroupPermissionCalculator`** (`group_permissions.synchronized_calculator`,
  priority -150) — for OUTSIDER / INSIDER scopes. Iterates all active override entities and the
  account's global-role-mapped group roles, emitting overridden items keyed by the same
  `group_permission:{bundle}:{gid}` identifier.
- **`GroupPermissionsChainPermissionCalculator`** merges calculator output with `overwrite = TRUE`
  for these two calculators, so an override **replaces** (not unions with) the group type default
  for that role+group. Admin roles are never overridden.

The override items are also honoured in listing/query context: `group_permissions.module`
implements `hook_query_entity_query_alter` / `hook_query_views_entity_query_alter`, dispatching to
`src/QueryAccess/GroupPermissionsGroupQueryAlter`, `…GroupRelationshipQueryAlter`, or
`…EntityQueryAlter`. These mirror Group's own query-access SQL but add per-group override
conditions (via `processIds()`, which strips the `group_permission:{bundle}:` prefix back to a
group id). `hook_module_implements_alter` forces these alters to run last and disables Group's
own equivalents.

## Cache invalidation

Saving a `group_permission` (`GroupPermission::postSave()`) invalidates tags `group_permissions`
and `custom_group_permissions:{gid}`. Calculators add `group_permission_list` (and per group
role / membership dependencies) so calculated permissions rebuild when overrides, roles or
memberships change.

## Hooks implemented (integrator-relevant)

- `hook_group_delete` — deletes a group's override entity with the group.
- `hook_user_cancel` (reassign) — batch-reassigns override revisions authored by the cancelled
  user to the super user (uid 1).
- `hook_form_group_type_form_alter` — adds the per-type "Enable group permissions" checkbox.
- `hook_menu_local_tasks_alter` — hides Revisions/Delete tabs when no override entity exists.
