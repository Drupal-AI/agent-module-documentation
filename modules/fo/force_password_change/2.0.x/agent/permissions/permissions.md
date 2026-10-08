<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Force Password Change — permissions

One permission, defined in `force_password_change.permissions.yml`:

| Permission | Machine name | Gates |
|---|---|---|
| Administer force changing of passwords | `administer force password change` | Access to the settings form and role detail pages (routes `force_password_change.admin`, `force_password_change.admin.role.list`), the per-user "Force this user to change their password" checkbox and password stats on the user edit form, and the "force on first-time login" checkbox on the user register form. |

Grant it:
```bash
drush role:perm:add administrator 'administer force password change'
```

There is no separate "view stats" permission — the single permission controls the whole admin surface.
Ordinary users never see any of this; they simply get redirected to their own edit form when a force
is pending.
