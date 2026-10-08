# Permissions

Defined in `block_class.permissions.yml`.

| Permission | Gates |
|---|---|
| `administer block classes` | Everything: the class/ID/attribute fields on the block config form, the settings form, all admin list pages, bulk operations, and the autocomplete endpoints. Marked `restrict access: true` (trusted permission). |

All routes in `block_class.routing.yml` require this single permission. Grant via drush:
```
drush role:perm:add site_admin 'administer block classes'
```
