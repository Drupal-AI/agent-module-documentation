# Permissions

Some permissions are static (`administerusersbyrole.permissions.yml`); the rest are generated
at runtime by `AdministerusersbyrolePermissions::permissions()` →
`AccessManager::permissions()` (`permission_callbacks`).

## Static permissions

| Machine name | Title | Gates |
|---|---|---|
| `create users` | Create new users | Creating new user accounts (`hook_entity_create_access` for `user`; unlocks `user.admin_create`). |
| `access users overview` | Access the users overview page | The People list (`entity.user.collection`) and multi-cancel confirm, added to their route requirements; also lets non-admins see role names / user columns. List is filtered to only editable users. |
| `allow empty user mail` | Allow empty user mail when managing users | Creating/editing users with no email (relaxes the `UserMailRequired` constraint and the mail field `#required`). |

## Dynamic base permissions (always present)

Built by `buildPermString($op)` = `"{op} users by role"`. Grant access to **all roles
classified "Allowed"** (`safe`):

| Machine name | Title | Operation |
|---|---|---|
| `edit users by role` | Edit users with allowed roles | edit / update |
| `cancel users by role` | Cancel users with allowed roles | cancel / delete |
| `view users by role` | View users with allowed roles | view (single user only, not Views) |
| `role-assign users by role` | Assign allowed roles | assign roles |

Operation aliases (`AccessManager::CONVERT_OP`): `delete`→`cancel`, `update`→`edit`;
`edit`, `cancel`, `view`, `role-assign` map to themselves.

## Dynamic per-role permissions (only for "Custom" roles)

For every role classified **Custom** (`perm`) on the settings form, four extra permissions are
generated via `buildPermString($op, $rid)` = `"{op} users with role {rid}"`:

| Machine name pattern | Title |
|---|---|
| `edit users with role {rid}` | Edit users includes role {label} |
| `cancel users with role {rid}` | Cancel users includes role {label} |
| `view users with role {rid}` | View users includes role {label} |
| `role-assign users with role {rid}` | Assign roles includes role {label} |

Each per-role permission only works **combined with** the matching base permission above
(its description says so). Example machine name: `edit users with role editor`.

## Access rules

- A sub-admin can act on a target user only if they pass the check for **every** role that
  user holds (`AccessManager::access()` loops over all roles; any failing role → neutral).
- Role classification decides the outcome per role: **Allowed** (`safe`) → base permission
  suffices; **Forbidden** (`unsafe`) → never; **Custom** (`perm`) → requires the per-role
  permission. The implicit `authenticated` role is always treated as safe.
- uid 0 (anonymous) and uid 1 (root) are never grantable.
- Holding core `administer users` (or `administer permissions`) **bypasses** this module
  entirely — do **not** give sub-admins those.
- Assigning a role is allowed if the sub-admin can edit the target user OR can assign all
  roles the user already has, AND can assign every role being changed
  (`administerusersbyrole_user_assign_role()`).

```
drush role:perm:add support 'access users overview'
drush role:perm:add support 'edit users by role'
drush role:perm:add support 'role-assign users by role'
```
