<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permission sync model (config entity + manager + subscriber)

How `features_permissions` turns role permissions into exportable config and back.
Cites `src/Entity/Permission.php`, `src/PermissionManager.php`,
`src/EventSubscriber/ConfigEventsSubscriber.php`, `features_permissions.module`,
`features_permissions.install`, `features_permissions.services.yml`,
`config/schema/features_permissions.schema.yml`.

## The `user_permission` config entity

`Drupal\features_permissions\Entity\Permission extends ConfigEntityBase`
(`@ConfigEntityType id = "user_permission"`, `config_prefix = "permission"`), so each
entity is stored as config named **`features_permissions.permission.<id>`**. `config_export`
= `id`, `label`, `roles`. Schema `features_permissions.permission.*` (type `config_entity`)
declares `id` (string), `label` (string), `roles` (sequence of strings).

- `id` — sanitized machine name (storage key only).
- `label` — the **real Drupal permission key** (e.g. `access checkout`); used as the key
  passed to core's role permission system.
- `roles` — array of role machine names that hold this permission.

Helper methods: `getRoles()`, `permissionHasRole($role)`, `addRoleToPermission($role)`
(appends then `sort()`), `removeRoleFromPermission($role)` (unset + `array_values()`).
`calculateDependencies()` copies the permission's own dependencies from
`user.permissions`→`getPermissions()[$label]['dependencies']` so the config entity carries
the same module/config deps core assigns the permission.

## PermissionManager service

Service `features_permissions.permission_manager`
(`arguments: ['@entity_type.manager', '@config.factory']`), implements
`PermissionManagerInterface`. In the constructor `configPrefix` is read from the
`user_permission` entity definition's `getConfigPrefix()` (= `features_permissions.permission`).

- **`syncRoleToPermissions(RoleInterface $role, string $op)`** — the role→entity direction.
  - `op = insert`: every `$role->getPermissions()` is treated as *added* (original = `[]`).
  - `op = update`: diffs `$role->original->getPermissions()` vs current; added perms and
    removed perms handled separately.
  - `op = delete`: all of the role's permissions treated as *removed*.
  - Added: load `user_permission` by `getPermissionMachineNameFromKey($perm)`; if missing,
    `Permission::create(['id'=>…, 'label'=>$perm, 'roles'=>[$role_id]])->save()`; if present
    and lacking the role, `addRoleToPermission()` + save.
  - Removed: load the entity, `removeRoleFromPermission($role_id)`; if `getRoles()` is now
    empty the **entity is deleted**, else saved.
- **`syncPermissionToRoles(string $permission)`** — the entity→role direction. Reads the
  config's `label` + `roles`, then loops **all** roles: `grantPermission($label)` +save for a
  role listed but lacking it, `revokePermission($label)` +save for a role holding it but not
  listed. Net effect: the entity's `roles` becomes authoritative for that permission.
- **`getPermissionMachineNameFromKey($name)`** — `preg_replace('/[^a-z0-9_]+/', '_', $name)`
  then `strtolower()` (permission key → entity id).
- **`getPermissionKeyFromMachineName($machine_name)`** — reads `label` back from the config.

## Triggers

- **Role writes** (`features_permissions.module`): `hook_entity_insert` / `_update` /
  `_delete` call `syncRoleToPermissions($entity, 'insert'|'update'|'delete')` when
  `$entity instanceof RoleInterface`.
- **hook_install** (`features_permissions.install`): iterates `Role::loadMultiple()` and runs
  each through `syncRoleToPermissions($role, 'insert')` to seed entities from existing roles.
- **Config import/revert** (`ConfigEventsSubscriber`, tagged `event_subscriber`): subscribes to
  the `config_update` module's `ConfigRevertInterface::IMPORT` and `::REVERT` events. For a
  `user_permission`-typed event it resolves the permission key via
  `getPermissionKeyFromMachineName()` and calls `syncPermissionToRoles()`.
  **Delete is intentionally NOT subscribed** — dropping a permission entity from a Feature
  stops managing that permission; it does not revoke it from roles (see the class docblock).

## How it fits Features export

`hook_requirements` (`features_permissions.install`) reads each `features_bundle`'s `alter`
assignment (`getAssignmentSettings('alter')`) and raises a `REQUIREMENT_ERROR` on the status
report unless **"Strip out user permissions"** (`user_permissions`) is enabled, linking to
`features.assignment_alter`. With that on, Features exports roles *without* their permissions,
and the standalone `features_permissions.permission.*` entities become the portable,
per-permission unit a Feature can carry. On deploy, `config_update` import/revert of those
entities re-applies the grants to roles via `syncPermissionToRoles()`.

`config_update` is available because it is a dependency of `features` (declared dep
`features:features`; composer `drupal/features:^3.0|^5.0`).
