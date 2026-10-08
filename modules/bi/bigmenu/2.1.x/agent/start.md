<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Big Menu (bigmenu) — agent index

Big Menu overrides core's menu edit form so very large menus stay editable: it renders the
menu tree only to a configurable depth and lets you drill into child branches on demand.
Depends on core `menu_ui`. No permissions, plugins, services, or Drush of its own.

- **Configure it** (the one setting, `max_depth`, and the route it overrides): [configure/bigmenu.md](configure/bigmenu.md)
- **Use / extend it programmatically** (read the config, the `BigMenuForm` override mechanism): [api/bigmenu.md](api/bigmenu.md)