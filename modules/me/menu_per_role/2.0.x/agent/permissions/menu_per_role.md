# Permissions — Menu Per Role

Defined in `menu_per_role.permissions.yml` (all non-restricted):

| Permission | Gates |
|---|---|
| `administer menu_per_role settings` | Access to the settings form (`menu_per_role.settings`, `/admin/config/system/menu_per_role`). |
| `assign menu role visibility` | Whether the `show_role`/`hide_role` checkbox fields **render** on the menu-link form. Without it, both fields are hidden and the editor cannot set per-role visibility. |
| `bypass menu_per_role access front` | Non-admin user sees all menu links regardless of role restrictions **in the front context**. |
| `bypass menu_per_role access admin` | Non-admin user sees all menu links regardless of role restrictions **in the admin context**. |

Note (2.0 change): the old single `administer menu_per_role` permission was split into
`administer menu_per_role settings` (the form) and `assign menu role visibility` (the fields);
`menu_per_role_update_10001` migrates roles that held the old permission to both new ones.

## Bypass logic (`bypassAccessCheck()` in the tree manipulator)

Enforcement in `menuLinkCheckAccess()` is skipped when `bypassAccessCheck()` returns TRUE:

- **Admin-role users** (an account with any role flagged `is_admin`, detected via
  `isUserAdmin()` — a role-storage query on `is_admin`, NOT a UID-1 check): governed by
  config, not the bypass permissions — `admin_bypass_access_front` /
  `admin_bypass_access_admin` decide per context. UID 1 still bypasses because it passes every
  `hasPermission()` check on the non-admin branch below.
- **Non-admin users**: governed by the two `bypass menu_per_role access {front,admin}`
  permissions, checked against the current context (admin route vs front).

So the front/admin bypass permissions only affect users who are not already admin-role users.

## Grant via Drush

```
drush role:perm:add editor 'administer menu_per_role settings'
drush role:perm:add editor 'assign menu role visibility'
drush role:perm:add support 'bypass menu_per_role access front'
```

## Update-hook history (context)

`menu_per_role.install`: `8101`/`8102` migrated the old `admin_see_all`/`uid1_see_all` config
to permissions/settings; `8103` split a single `bypass menu_per_role access` into the separate
front/admin permissions; `8104` seeded `admin_bypass_access_*`; `10001` replaced
`administer menu_per_role` with `administer menu_per_role settings` + `assign menu role visibility`.
