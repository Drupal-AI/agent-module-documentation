<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions — Menu Per Role

Defined in `menu_per_role.permissions.yml` (none granted by default; none flagged
`restrict access`):

| Permission | Gates |
|---|---|
| `administer menu_per_role` | Access to the settings form (`menu_per_role.settings`, `/admin/config/system/menu_per_role`). |
| `bypass menu_per_role access front` | Non-admin user sees all menu links regardless of role restrictions **in the front context**. |
| `bypass menu_per_role access admin` | Non-admin user sees all menu links regardless of role restrictions **in the admin context**. |

## Bypass logic

Access enforcement lives in `MenuPerRoleLinkTreeManipulator::menuLinkCheckAccess()`; it is
skipped when `bypassAccessCheck()` returns TRUE:

- **Admin users** (UID 1, or a role flagged `is_admin`): governed by config, NOT by the
  bypass permissions — `admin_bypass_access_front` / `admin_bypass_access_admin` in
  `menu_per_role.settings` decide per context (`isUserAdmin()` branch).
- **Non-admin users**: governed by the two `bypass menu_per_role access {front,admin}`
  permissions, checked against the current context (admin route vs front).

So the front/admin bypass permissions only affect users who are not already admins. Admin
detection: UID 1, or any of the account's roles is in the set of roles whose `is_admin`
flag is TRUE (queried once and cached in `$adminRoles`).

## Grant via Drush

```
drush role:perm:add editor 'administer menu_per_role'
drush role:perm:add support 'bypass menu_per_role access front'
```

## Update-hook history (context)

`menu_per_role.install` migrated older config-based bypass to permissions: a single
`bypass menu_per_role access` was split into the separate front/admin permissions
(update 8103), and the old `admin_see_all`/`uid1_see_all` config was removed in favour of
the current permission + `admin_bypass_access_*` settings model (updates 8101, 8102, 8104).
