<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Force Password Change

**Admin UI:** `/admin/config/people/force_password_change` (route `force_password_change.admin`,
permission `administer force password change`). Also linked from the People admin index and each
role's detail page `/admin/config/people/force_password_change/list/{rid}`.

## Config object: `force_password_change.settings`

| Key | Type | Default | Meaning |
|---|---|---|---|
| `enabled` | bool | `true` | Master switch. Set FALSE in `settings.php` to disable all enforcement without uninstalling. |
| `check_login_only` | bool | `false` | FALSE = check for a pending force on **every page load** (redirect immediately, most secure). TRUE = check only in `hook_user_login()`. Shown on the form as radios "On every page load" (0) / "On login only" (1). |
| `first_time_login_password_change` | bool | `false` | Force **all new users** to change their admin-set password on first login. |
| `expire_password` | bool | `false` | Enable timed password expiry using the per-role expiry rules. |
| `installation_date` | int (UNIX ts) | set at install | Used to decide whether an account predates the module (for first-login logic). |
| `expiry_data` | sequence | — | Per-role `{rid, expiry (seconds), weight}`; also mirrored in the `force_password_change_expiry` table. |
| `roles_change_password` | sequence | — | Per-role `{rid, last_force}`. |

Read/write with drush:
```bash
drush cget force_password_change.settings
drush cset force_password_change.settings first_time_login_password_change 1 -y
drush cset force_password_change.settings check_login_only 1 -y   # login-only checking
drush cset force_password_change.settings expire_password 1 -y
```

## Emergency disable (locked out)

Add to `settings.php`, do your work, then remove it:
```php
$config['force_password_change.settings']['enabled'] = FALSE;
```

## Triggering a force (these are triggers, not persisted checkboxes)

- **Per role:** tick the role's checkbox in the "Force users in the following roles…" section of the
  settings form and submit; forces every user in that role on their next page load/login.
- **Per role via role edit form** (`user_role_form`): a "Force users in this role to change their
  password" checkbox is injected by `hook_form_alter`.
- **Per user:** on the user edit form (`user_form`), a "Force this user to change their password"
  checkbox (needs `administer force password change`); the same form shows password stats.
- **New user:** the user register form gets a "Force password change on first-time login" checkbox
  (only when the site-wide `first_time_login_password_change` is off).

## Where per-user/role state actually lives

- **Individual pending force:** core `user.data`, module `force_password_change` →
  `pending_force` (1 = pending), `last_force`, `last_change` (all keyed by uid).
- **Custom DB tables:** `force_password_change_roles` (rid, last_force),
  `force_password_change_expiry` (rid, expiry, weight), `force_password_change_uids` (category, uid;
  category e.g. first-time-login list).

The module ships **no Drush commands** and defines **no plugins**; config schema lives in
`config/schema/force_password_change.schema.yml`.
