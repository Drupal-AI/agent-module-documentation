# Configure Role Expire

## Settings form

Route `role_expire.config` → `/admin/config/people/role-expire` (permission
`administer role expire`). It edits the `role_expire.config` config object:

| Key | Type | Meaning |
|---|---|---|
| `role_expire_disabled_roles` | string (JSON map rid→0/1) | Which roles have expiration enabled (0) or disabled (1). Empty ⇒ all non-anonymous/authenticated roles are enabled. |
| `role_expire_default_duration_roles` | sequence (map rid→string) | Default duration per role, a strtotime string (`1 day`, `3 months`, `1 year`). |
| `role_expire_default_roles` | string (JSON map rid→rid) | When a role expires, the role to assign instead (a "downgrade" role). |
| `role_expire_expiration_details_expanded` | boolean | Whether the per-role expiration `<details>` on the user form start open. |

Read/write the default-duration map directly:

```bash
drush php:eval 'var_export(\Drupal::config("role_expire.config")->get("role_expire_default_duration_roles"));'
```

## Per-role default duration (role edit form)

On *People › Roles › Edit role* (`/admin/people/roles/manage/<rid>`), with permission
`edit role expire default duration` (or `administer users`), a **"Default duration for the role"**
textfield appears. Enter a **relative future** strtotime string (validated: must be relative,
future, positive). New grants of that role then auto-expire after this span. Backed by
`RoleExpireApiService::setDefaultDuration()` / `deleteDefaultDuration()`.

## Per-user expiry (user edit form)

On a user's edit form (`/user/<uid>/edit`), with `edit users role expire` (or `administer users`),
each expiration-enabled role the user holds gets a **"Role expiration"** details group with a
date/time field. Accepts:
- blank → use the role's default duration, or never expire if none;
- absolute `YYYY-MM-DD HH:MM:SS`;
- relative, e.g. `1 day`, `2 months`, `1 year` (must be in the future).

This writes to the `role_expire` table (see [../api/service.md](../api/service.md)), not to config.

## Permissions

| Permission | Gates |
|---|---|
| `administer role expire` | The settings form at `/admin/config/people/role-expire`. |
| `edit users role expire` | Editing other users' role expiration dates on the user form. |
| `edit role expire default duration` | Editing a role's default duration on the role form. |

All three are marked `restrict access: TRUE`.

## Replacement-role-on-expiry

Populate `role_expire_default_roles` (rid → replacement rid) so that when a role expires on
cron, the user is additionally granted the replacement role (which itself then picks up its own
default duration, if any). Configured on the settings form.
