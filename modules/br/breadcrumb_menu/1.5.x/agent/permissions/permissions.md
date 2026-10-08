<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `breadcrumb_menu.permissions.yml`.

| Permission                   | Title                                    | Gates                                                                 |
|------------------------------|------------------------------------------|----------------------------------------------------------------------|
| `administer breadcrumb_menu` | Administer Breadcrumb Menu settings      | The settings form/route `breadcrumb_menu.settings` (`/admin/config/system/breadcrumb-menu`). |

This is the only permission the module defines. It is a dedicated permission (not
`administer site configuration`), so choosing which menus drive the breadcrumb can be
delegated to a role without granting broader config access.

Grant via drush:

```bash
drush role:perm:add site_manager 'administer breadcrumb_menu'
```
