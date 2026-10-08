# Nice Menus — agent index

Superfish-style CSS/jQuery drop-down / flyout menus, exposed as a `nice_menus_block` Block plugin plus a
small global settings form. Depends on core `menu_link_content`. No Drush, no plugin types, no API hooks.

- **Global settings form (`nice_menus.settings`) and the per-block configuration (menu, depth, style, expand)** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Config route `nice_menus.admin` = `admin/config/user-interface/nice_menus`, permission
  `manage nice menu settings` (NOT `restrict access: true` — it only toggles JS/CSS loading and hover
  delay/speed; no injection, values are cast to bool/int/enum on save).
- Block plugin id `nice_menus_block` (category *Menus*); place it in a region via Block layout.
- Menu tree is built with core `menu.link_tree` + `checkAccess`/`generateIndexAndSort` manipulators, so
  link access is enforced; theme hook `nice_menus` / template `templates/nice_menus.html.twig` prints the
  render array (`{{ menu_output }}`).
- Libraries in `nice_menus.libraries.yml`: `superfish`, `jquery.hoverIntent`, `nice_menus` (JS),
  `nice_menus_css`, `nice_menus_default` (CSS).
