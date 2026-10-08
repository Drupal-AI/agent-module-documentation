# Permissions

The module declares two kinds of permission: three **site** permissions (in
`group_permissions.permissions.yml`) that gate the standalone `group_permission` entity
CRUD/revision routes, and one **in-group** permission (in `group_permissions.group.permissions.yml`)
that gates the per-group override editing UI.

## Site permissions

| Permission | Machine name | Grants |
|---|---|---|
| Create new Group permission entities | `add group permission entities` | Pass the `entity.group_permission.add-form` access check. |
| Edit Group permission entities | `edit group permission entities` | `update` access on a `group_permission` entity (edit-form). |
| Delete Group permission entities | `delete group permission entities` | `delete` access on a `group_permission` entity (delete-form). |

These are checked by `GroupPermissionAccessControlHandler::checkAccess()` /
`checkCreateAccess()` and surfaced on routes through the `_group_permission_entity_access`
requirement (`GroupPermissionEntityAccessCheck`). The `group_permission` entity type also
declares `admin_permission = "administer group permission entities"` (an entity-admin bypass
handled by core's `EntityAccessControlHandler`); that string is not defined in a
`*.permissions.yml`, so only accounts with all permissions satisfy it.

## In-group permission

| Permission | Machine name | Notes |
|---|---|---|
| Override group permissions | `override group permissions` | `restrict access: TRUE`. Group-scoped (granted through a group role, checked inside a specific group), not a site permission. |

`override group permissions` is the requirement (`_group_permission`) on the whole per-group
UI: canonical/view, add, edit, delete and all revision routes carry
`_group_permission: 'override group permissions'` **and** `_group_permissions_enabled: 'TRUE'`
(the group type must have the feature switched on — see [../configure/overrides.md](../configure/overrides.md)).

## Granting

- Site permissions: normal `/admin/people/permissions` (or `user_role`/config).
- `override group permissions` is assigned to a **group role** like any other group permission
  (group type role settings, or a per-group override once the feature is enabled).
