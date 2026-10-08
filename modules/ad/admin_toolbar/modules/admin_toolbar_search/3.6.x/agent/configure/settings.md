# Settings

Config object `admin_toolbar_search.settings` (schema
`config/schema/admin_toolbar_search.schema.yml`). UI at
`/admin/config/user-interface/admin-toolbar-search` (route `admin_toolbar_search.settings`,
permission `administer site configuration`).

| Key | Type | Default | Meaning |
|---|---|---|---|
| `display_menu_item` | bool | FALSE | Render the search input as a menu item instead of inline in the toolbar. |
| `enable_keyboard_shortcut` | bool | TRUE | Enable the Alt + a shortcut to focus the search field. |

```
drush config:set admin_toolbar_search.settings display_menu_item true -y
```
