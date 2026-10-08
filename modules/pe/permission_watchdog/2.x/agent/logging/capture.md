<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How permission changes are captured

All capture happens on the **core permissions form**, not on role save. There is no custom
database query — changes are written as content entities via the entity API.

## The two-phase form hook

`Drupal\permission_watchdog\Hook\PermissionWatchdogHooks` (autowired service; the `.module` file
exposes `#[LegacyHook]` shims that delegate to it). Constructor injects `config.factory`,
`entity_type.manager`, `current_user`.

### Phase 1 — snapshot (`formUserAdminPermissionsAlter`)

`#[Hook('form_user_admin_permissions_alter')]`. Runs for the core `user_admin_permissions` form and
its subclasses (`EntityPermissionsForm`, `UserPermissionsModuleSpecificForm`,
`UserPermissionsRoleSpecificForm`).

1. Loads the tracked roles: all roles when `all_roles` is set, else `loadMultiple(config->get('roles'))`.
2. Filters out admin roles (`!$role->isAdmin()`); returns early if none remain.
3. Reflectively calls the form object's `permissionsByProvider()` method (all three form variants
   share it) to get the exact permission set the form renders.
4. Builds `$rolePermissions[$roleName][$permission] = 1|0` mirroring the form's checkbox submission
   shape, and stashes it plus the role list in two `#type => value` elements
   (`permissions_watchdog_permissions`, `permissions_watchdog_roles`).
5. Appends `formUserAdminPermissionsSubmit` to `$form['#submit']`.

### Phase 2 — diff & store (`doFormUserAdminPermissionsSubmit`)

The static `formUserAdminPermissionsSubmit` callback re-resolves the service and calls
`doFormUserAdminPermissionsSubmit()`:

1. Intersects the stashed roles with `role_names` actually submitted (handles the role-specific form).
2. For each role: `array_diff_assoc($newPermissions, $oldPermissions)` → only the changed checkboxes.
3. Skips roles with no change; otherwise `create()` a `role_change_log` entity with `uid` =
   `currentUser->id()`, `role` = role id, and for each changed permission appends an `actions` item
   `{action: added|removed, permission: <id>}` (status `1` → added, `0` → removed). Then `save()`.

One entity is written per changed role per form save.

## The entity

`Drupal\permission_watchdog\Entity\RoleChangeLog` — `@ContentEntityType id="role_change_log"`,
base table `role_change_log`, only key `id`. Base fields (`baseFieldDefinitions`):
- `role` — entity_reference → `user_role` (required, NotBlank).
- `uid` — entity_reference → `user` (required).
- `timestamp` — timestamp, default via `getDefaultTimestamp()` (`\time()`).
- `actions` — `permission_action`, `CARDINALITY_UNLIMITED`, required.

Constants: `PERMISSION_ADDED = 'added'`, `PERMISSION_REMOVED = 'removed'`.
Interface `RoleChangeLogInterface` (empty marker extending `ContentEntityInterface`).

## The `permission_action` field type

`src/Plugin/Field/FieldType/PermissionActionItem.php` — `@FieldType id="permission_action"`,
`no_ui = TRUE`, `list_class = MapFieldItemList`. Two string properties/columns:
`permission` (varchar 255) and `action` (varchar 25), both indexed, both NotBlank; `action` is
constrained by `AllowedValues` to `added`/`removed` (`allowedActionValues()`). No main property.
`generateSampleValue()` produces random data for Devel Generate.
