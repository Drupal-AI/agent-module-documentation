<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu Manipulator — agent index

Filters menu links by the current interface language and renders per-link icons, driven by a
single settings object. Depends on core Language. No permissions of its own (admin form uses
`administer site configuration`), no plugins, no Drush.

- **All settings (`menu_manipulator.settings`), the admin route, which menus are filtered/iconed** →
  [configure/settings.md](configure/settings.md)
- **The tree-manipulator service, the `menu_link_content` language field, helper function, hooks** →
  [api/service.md](api/service.md)

Key facts:
- Config object: `menu_manipulator.settings`. Admin form:
  `/admin/config/user-interface/menu-manipulator` (route `menu_manipulator.settings`).
- Language filtering keys: `preprocess_menus_language` (bool on/off),
  `preprocess_menus_language_use_entity` (bool), `preprocess_menus_language_list`
  (map of `menu_name: menu_name` for menus to filter — empty string = not filtered).
- Icon keys: `preprocess_menus_icon` (bool), `preprocess_menus_icon_list` (map like above),
  `menu_link_icon_list` (string list of available icons).
- Service: `menu_manipulator.menu_tree_manipulators`
  (`MenuLinkTreeManipulators::filterTreeByCurrentLanguage`).
