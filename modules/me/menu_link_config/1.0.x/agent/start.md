<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu Link Config (menu_link_config) — agent index

Lets you create custom menu links as **config entities** (`menu_link_config`) instead of
`menu_link_content` content entities, so links live in `config/sync` and deploy with
`drush cim` / config import. A drop-in replacement for core's Custom Menu Links for small,
structural menus. No hard dependencies declared; needs `menu_ui` in practice, integrates
optionally with `config_translation`. No settings page (`configure` null). No `*.permissions.yml`.
No Drush commands. Long-standing alpha (newest release `8.x-1.0-alpha9`).

- **Create / edit / delete a config menu link, its config object + schema, export & deploy, drush/PHP, runtime sync** → [configure/menu-links.md](configure/menu-links.md)

Key facts:
- Config entity type `menu_link_config` (`src/Entity/MenuLinkConfig.php`), one config object per link named
  `menu_link_config.menu_link_config.{id}`. Exported keys: `id`, `title`, `route_name`, `route_parameters`,
  `options`, `expanded`, `menu_name`, `enabled`, `parent`, `weight`, `description`.
- Each entity becomes a core menu link plugin via a deriver (`Plugin\Derivative\MenuLinkConfig`), plugin id
  `menu_link_config:{id}`, class `Plugin\Menu\MenuLinkConfig` (extends `MenuLinkBase`). `postSave()`/`preDelete()`
  keep the core menu tree (`plugin.manager.menu.link`) in sync.
- Routes: `menu_link_config.link_add` (`/admin/structure/menu/manage/{menu}/add_config_link`, req
  `_entity_create_access: 'menu_link_config'`); `entity.menu_link_config.edit_form` and
  `entity.menu_link_config.delete_form` (both req `_permission: 'administer menu'`).
- Action link "Add config link" (`menu_link_config.link_add`) appears on `entity.menu.edit_form`.
- Entity `admin_permission = "administer menu link config"` is referenced but **not declared** in any
  permissions.yml — so `_entity_create_access` effectively passes only for user 1; edit/delete use core
  `administer menu`.
- Config schema: `config/schema/menu_link_config.schema.yml`. Config-translation mapper
  `MenuLinkConfigMapper`; per-link translation goes through `config_translation`, not content translation.
