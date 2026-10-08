# Menu Condition — agent index

Provides ONE core Condition plugin, **`menu_position`** ("Menu position"), and nothing else:
no config entity, no settings form, no configure route, no services, no permissions, no Drush,
no config schema of its own. It shows a block (or any condition consumer) when a chosen menu
link — and its children — is in the current page's active menu trail.

- **The `menu_position` plugin: the `menu_parent` value format, evaluate/summary logic, how it
  sits in block visibility config, cacheability** →
  [plugins/menu-position.md](plugins/menu-position.md)

Key fact: the stored value is a single string `menu_parent` = `"<menu_name>:<link_plugin_id>"`
(e.g. `main:standard.front_page`) or `"<menu_name>:"` for a whole menu. In a block it lives at
`block.block.<id>` → `visibility.menu_position.menu_parent`. Empty value → condition is TRUE
(no restriction).
