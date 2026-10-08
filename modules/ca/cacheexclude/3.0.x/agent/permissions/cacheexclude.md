# Permissions

Cache Exclude defines **no permissions of its own** (there is no `cacheexclude.permissions.yml`).

The settings form route `cacheexclude.settings`
(`/admin/config/system/cacheexclude`) is protected by the core permission:

- `administer site configuration` — required to view and save the exclusion settings.

Grant it as you would any core permission, e.g.:

```bash
drush role:perm:add administrator 'administer site configuration'
```
