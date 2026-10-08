<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# pfdp permissions

`pfdp.permissions.yml` defines three, all with `restrict access: FALSE`:

| Permission | Title | Effect |
|---|---|---|
| `bypass pfdp` | Bypass Private files download permission | Checked **before** any directory lookup: the user may download from any private directory regardless of the configured users/roles. |
| `bypass pfdp for temporary files` | Bypass Private files download permission for temporary files | Same, but only for URIs starting with `temporary://` (image-style derivatives, in-progress uploads). |
| `administer pfdp` | Administer Private files download permission | Access to the directory list / add / edit / delete forms and the settings form. Also the `admin_permission` of the `pfdp_directory` entity type. |

```bash
drush role:perm:add file_admin 'administer pfdp'
drush role:perm:add support 'bypass pfdp for temporary files'
drush config:get user.role.support permissions
```

Notes:

- User 1 and any role with `is_admin: true` (e.g. `administrator`) already pass
  `hasPermission()` for all three.
- These permissions are the **only** unconditional escape hatch; everything else goes through the
  per-directory `users` / `roles` / `grant_file_owners` / `bypass` configuration.
- Granting `bypass pfdp` to `authenticated` effectively disables the module for logged-in users.
