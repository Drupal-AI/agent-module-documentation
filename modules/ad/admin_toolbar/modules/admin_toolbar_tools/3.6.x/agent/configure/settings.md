# Settings

Config object `admin_toolbar_tools.settings` (schema
`config/schema/admin_toolbar_tools.schema.yml`). UI at
`/admin/config/user-interface/admin-toolbar-tools` (route `admin_toolbar_tools.settings`,
permission `administer site configuration`).

| Key | Type | Default | Meaning |
|---|---|---|---|
| `max_bundle_number` | int | 20 | Max bundles per entity type listed in the drop-down (keeps the menu manageable on sites with many bundles). |
| `show_local_tasks` | bool | FALSE | Show local task tabs inside the toolbar menu. |

```
drush config:set admin_toolbar_tools.settings max_bundle_number 10 -y
```
