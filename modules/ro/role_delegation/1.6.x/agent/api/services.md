# Role Delegation services

From `role_delegation.services.yml`:

## `delegatable_roles` — `Drupal\role_delegation\DelegatableRoles`
The core service. Returns the roles a given account may assign (honouring `assign all roles`,
per-role permissions, and `hook_role_delegation_assignable_roles_alter()`).
Implements `DelegatableRolesInterface`.
```php
$roles = \Drupal::service('delegatable_roles')->getAssignableRoles(\Drupal::currentUser());
// $roles: [role_id => label] the current user is allowed to grant/revoke.
```
Use it in custom forms/flows to present or validate a scoped role list.

## `permission_generator.role_delegation` — `PermissionGenerator`
Generates the dynamic `assign {role} role` permissions (its `rolePermissions()` is the
`permission_callbacks` entry).

## `access_check.role_delegation` — `RoleDelegationAccessCheck`
Route access check tagged `applies_to: _role_delegation_access_check`; used by the
`role_delegation.edit_form` route to allow users who can assign at least one role.

Other integration points: Action plugins `RoleDelegationAddRoleUser` /
`RoleDelegationRemoveRoleUser` (bulk role add/remove), a `RoleChangeSelection`
EntityReferenceSelection plugin, and a `RoleDelegationUserBulkForm` Views field.
