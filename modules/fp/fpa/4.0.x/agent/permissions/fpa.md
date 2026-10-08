# fpa — permissions

FPA defines exactly one permission (`fpa.permissions.yml`).

| Permission | Machine string | Gates |
|---|---|---|
| Manage fast permissions administration settings | `manage fast permissions administration settings` | Access to the FPA settings form (`fpa.settings`, `/admin/config/people/fpa-settings`) where UI sections are enabled/disabled. |

This permission is **not** restricted (`restrict access` is not set), but it only controls
the small settings form — not the permissions page itself.

## Who can see the enhanced permissions page

The enhanced page at `/admin/people/permissions` is still the core `user.admin_permissions`
route; FPA only swaps its controller. So the page is gated by core's own requirement
(`administer permissions`), unchanged. Granting `manage fast permissions administration
settings` lets a user tweak which FPA sections show, but they still need `administer
permissions` to actually view and edit role permissions.

Grant via drush:

```bash
drush role:perm:add administrator 'manage fast permissions administration settings'
```
