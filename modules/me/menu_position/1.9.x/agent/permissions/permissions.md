<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu Position permissions

`menu_position.permissions.yml` defines exactly one permission:

| Permission | Title | Gates |
|---|---|---|
| `administer menu positions` | Administer menu position rules | The rule list/order form, and the add / edit / delete rule forms. It is also the `admin_permission` of the `menu_position_rule` config entity type. |

The settings form is **not** covered by it — `menu_position.settings`
(`/admin/structure/menu-position/settings`) requires the core permission
`administer site configuration`.

```bash
drush role:perm:add editor 'administer menu positions'
drush config:get user.role.editor permissions
```

Granting `administer menu positions` alone lets a role manage which content lands where in the
menus without granting `administer menu` (core menu administration) or
`administer site configuration`.
