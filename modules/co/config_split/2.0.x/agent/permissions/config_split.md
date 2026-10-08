# Permissions

Defined in `config_split.permissions.yml`.

| Permission | Gates |
|---|---|
| `administer configuration split` | Full access: the split collection/list, add/edit/delete split entities, enable/disable, and the activate/deactivate/import/export/diff operations. Marked `restrict access: true` (trusted — grants control over what config deploys). |

Grant via drush:
```
drush role:perm:add administrator 'administer configuration split'
```
