# Configure which roles are assignable

## Admin form — `roleassign.settings`

| Route | Path | Access | Form |
|---|---|---|---|
| `roleassign.settings` | `/admin/people/roleassign` | `administer permissions` | `RoleAssignAdminForm` |

Reachable from the People collection (menu link "Role assign"). The form shows a **Roles**
checkbox set of every role except `anonymous` and `authenticated`; tick the ones that
restricted admins are allowed to assign. Only a user with **Administer permissions** can open
this form and decide the assignable set.

## Config object — `roleassign.settings`

Single config object (schema `config/schema/roleassign.schema.yml`), one key:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `roleassign_roles` | sequence of strings (role IDs) | `[]` | The role machine names available for assignment by users with "Assign roles". |

The submit handler filters the checkboxes to the checked role IDs and `sort()`s them before
saving. Set it from the CLI instead of the UI:

```bash
drush cset roleassign.settings roleassign_roles.0 editor
drush cset roleassign.settings roleassign_roles.1 moderator
```

Because it is a config object it exports/deploys with `drush config:export` /
`config:import`.

## How the restriction is applied

Once configured, RoleAssign only acts on users who are "restricted" (see
[permissions/roleassign.md](../permissions/roleassign.md)):

- **`hook_form_alter()`** replaces the roles field on user forms (`user_form` and any user
  form mode, plus the CAS `bulk_add_cas_users` form) with an **Assignable roles** checkbox set
  whose options are exactly `roleassign_roles`. Roles the account already has that are *not*
  in that set are shown as "sticky" (kept but not editable); `authenticated` is always sticky.
- **`hook_user_presave()`** re-applies the limit server-side: for existing accounts it merges
  the restricted user's chosen assignable roles with the original account's unassignable roles,
  so a restricted admin can neither add nor remove roles outside the configured set.

`anonymous` and `authenticated` are always excluded from the assignable list. RoleAssign also
protects user 1's name, email, and password fields.
