# Programmatic API — access checks

The one public service is `administerusersbyrole.access`
(`Drupal\administerusersbyrole\Services\AccessManager`, interface `AccessManagerInterface`).
Use it to reproduce the module's access logic or list which roles a sub-admin may act on.

```php
/** @var \Drupal\administerusersbyrole\Services\AccessManagerInterface $access */
$access = \Drupal::service('administerusersbyrole.access');
```

## Methods

```php
// Can $account perform $operation on a user holding exactly these roles?
// $operation: 'edit'|'update', 'cancel'|'delete', 'view', 'role-assign'.
// Returns AccessResult (allowed only if EVERY role passes; else neutral).
$result = $access->access($user->getRoles(TRUE), 'edit', $account);

// Which role ids may $account act on for $operation (always includes 'authenticated').
$rids = $access->listRoles('role-assign', $account);   // e.g. for the role <select>

// All roles this module can manage (excludes anon/auth and any role with 'administer users').
$roles = $access->managedRoles();                       // [rid => RoleInterface]

// Dynamic permission definitions (used by the permission_callbacks provider).
$perms = $access->permissions();

// Re-sync the roles config after roles change (called from hook_user_role_*).
$access->rolesChanged();

// Build a permission machine name.
$access->buildPermString('edit');            // "edit users by role"
$access->buildPermString('edit', 'editor');  // "edit users with role editor"
```

Constants on `AccessManagerInterface`: `SAFE='safe'`, `UNSAFE='unsafe'`, `PERM='perm'`.

## Access entry points (hooks, not usually called directly)

Enforcement lives in `administerusersbyrole.module`:

- `administerusersbyrole_user_access($user, $op, $account)` — the main `hook_user_access()`;
  wraps `AccessManager::access()`, denies uid ≤ 1, and treats "view a blocked user" as
  needing `update`.
- `administerusersbyrole_user_assign_role($user, $account, $rids)` — allow if the sub-admin
  can edit the user OR can assign all roles the user already holds, AND can assign every role
  in `$rids`.
- `administerusersbyrole_entity_create_access()` — `create users` permission.
- `administerusersbyrole_entity_field_access()` — gates `name`/`status`/`mail`
  (+ `roles`/`access` on view) on the user entity.
- `hook_query_administerusersbyrole_edit_access_alter()` — filters the People view to hide
  users the current account cannot edit or assign roles to.

The core "Add/Remove role" bulk actions are subclassed (`AddRoleUser`, `RemoveRoleUser` via
`ChangeUserRoleTrait`) so their access and role `#options` respect `role-assign` grants.
There is no `{name}.api.php` — this module exposes no hooks of its own for others to implement.
