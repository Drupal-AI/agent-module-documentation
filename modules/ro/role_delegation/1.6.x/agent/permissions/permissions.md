# Role Delegation permissions

From `role_delegation.permissions.yml` + dynamic callback
`permission_generator.role_delegation::rolePermissions` (`PermissionGenerator`).

| Permission | Gates |
|---|---|
| `assign all roles` | Assign/revoke **any** role (marked `restrict access: TRUE` — security-sensitive). |
| `assign {role} role` | One generated per role except the locked anonymous/authenticated roles — lets the holder grant/remove just that role. |

## How access is enforced
- The per-user **Roles** form (`/user/{user}/roles`) is guarded by the access check service
  `access_check.role_delegation` (tag `_role_delegation_access_check`), which passes if the
  current user has `assign all roles` or at least one `assign {role} role`.
- On that form and on the standard user add/edit form, the role checkboxes are filtered to only
  the roles the current user may assign (via the `delegatable_roles` service).
- The bulk **Action** plugins (`RoleDelegationAddRoleUser` / `RoleDelegationRemoveRoleUser`) and
  the Views bulk-form field apply the same per-role checks.

Grant `assign {role} role` to delegate exactly one role; reserve `assign all roles` for trusted
user-managers who should still **not** get `administer permissions`.
