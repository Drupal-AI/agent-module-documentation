# Permissions

Defined in `view_password.permissions.yml`.

| Permission | Gates |
|---|---|
| `administer view password` | Access to the View Password settings form (`password.route`, `/admin/config/system/view-password-settings`) — choosing which form IDs get the toggle, custom classes, and custom icons. |

This is the only permission the module defines, and it is the `_permission` requirement on
the settings route. It gates configuration only; the show/hide toggle itself is rendered
client-side to any end user who reaches a configured form (no permission needed to *use*
the toggle).

```
drush role:perm:add site_manager 'administer view password'
```
