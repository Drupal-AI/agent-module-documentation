# Permissions

Defined in `node_revision_delete.permissions.yml`.

| Permission | Gates |
|---|---|
| `administer node_revision_delete` | Access all module config, the reset form, and the queue form (`/admin/config/content/node_revision_delete*`). Trusted admin permission. |

Grant via drush:
```
drush role:perm:add site_admin 'administer node_revision_delete'
```
This single permission controls every admin route the module exposes.
