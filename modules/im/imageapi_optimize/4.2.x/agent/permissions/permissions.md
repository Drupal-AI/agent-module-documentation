# Permissions

Defined in `imageapi_optimize.permissions.yml`.

| Permission | Gates |
|---|---|
| `administer imageapi optimize pipelines` | Create, edit, delete and flush Image Optimize pipelines and configure their processors (the whole `/admin/config/media/imageapi-optimize-pipelines` UI). |

Grant via drush:
```
drush role:perm:add site_admin 'administer imageapi optimize pipelines'
```
