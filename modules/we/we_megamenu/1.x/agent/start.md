<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# We Mega Menu — agent index

Turns an existing core menu into a multi-column **mega menu** with a drag-and-drop builder at
`/admin/structure/we-mega-menu`. Per-menu layout is stored as a **JSON blob in the custom DB
table `we_megamenu`**, keyed by `(menu_name, theme)` in the `data_config` column — NOT a config
entity, NOT config schema, NO Drush. The front end is a derived block `we_megamenu_block:<menu>`
placed in a region. One permission: `administer we_megamenu`.

- **How layout is stored, the builder UI, `block_config` settings, seeding config in code** →
  [configure/megamenus.md](configure/megamenus.md)
- **The per-menu Mega Menu block (`we_megamenu_block`, derivative-per-menu) and how to place it** →
  [plugins/megamenu-block.md](plugins/megamenu-block.md)
- **`WeMegaMenuBuilder` API (loadConfig / saveConfig / initMegamenu…) + the `data_config` JSON model** →
  [api/builder.md](api/builder.md)
- **`hook_megamenu_manipulators_alter()` — alter the menu-tree manipulators** →
  [hooks/megamenu-manipulators-alter.md](hooks/megamenu-manipulators-alter.md)
- **The `administer we_megamenu` permission and what it gates** →
  [permissions/permissions.md](permissions/permissions.md)
- **Theme hooks + Twig templates + libraries that render the menu** →
  [theming/theming.md](theming/theming.md)

Key fact: a menu is "active" as a mega menu once a row exists in the `we_megamenu` table for
`(menu_name, theme)` — created via the builder UI or `WeMegaMenuBuilder::initMegamenu()`. Render
behavior (hover vs click, animation, mobile collapse) lives in `data_config.block_config`.
