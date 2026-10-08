# Display settings

Admin Toolbar turns core's classic Toolbar into fully expandable drop-down menus — hovering a
top-level item reveals the whole admin tree without a page load (here **Structure** expanded):
![Admin Toolbar drop-down menu](../../../../../../../screenshots/admin_toolbar/3.6.x/toolbar-dropdown.png)

Config object `admin_toolbar.settings` (schema `config/schema/admin_toolbar.schema.yml`).
UI at `/admin/config/user-interface/admin-toolbar` (route `admin_toolbar.settings`, form
`AdminToolbarSettingsForm`, permission `administer site configuration`):
![Admin Toolbar settings form](../../../../../../../screenshots/admin_toolbar/3.6.x/settings-form.png)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `menu_depth` | int | 4 | How many levels of the admin menu the drop-downs render. |
| `sticky_behavior` | string | `enabled` | `enabled`, `disabled`, or `hide_on_scroll_down` (hide on scroll-down, show on scroll-up). |
| `enable_toggle_shortcut` | bool | FALSE | Enable a keyboard shortcut to toggle the toolbar. |
| `hoverintent_behavior.enabled` | bool | TRUE | Use hoverIntent so submenus don't flicker on quick passes. |
| `hoverintent_behavior.timeout` | int | 500 | hoverIntent delay in ms before opening/closing a submenu. |

Example:
```
drush config:set admin_toolbar.settings menu_depth 6 -y
drush config:set admin_toolbar.settings sticky_behavior hide_on_scroll_down -y
```
