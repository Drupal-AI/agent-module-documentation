# Permissions

`onlyone.permissions.yml` defines a single permission:

| Permission | Gates |
|---|---|
| `administer onlyone` | Access to both admin forms — the *Only One* content-types page (`onlyone.config_content_types`) and the *Settings* page (`onlyone.admin_settings`). |

Both routes require `_permission: 'administer onlyone'`. There is no per-content-type
permission; enforcement of the "one node" rule itself is a validation constraint that applies
to everyone (it is not permission-gated).

```bash
drush role:perm:add editor 'administer onlyone'
```
