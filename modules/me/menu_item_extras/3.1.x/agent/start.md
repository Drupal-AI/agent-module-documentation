# menu_item_extras — agent start

Makes `menu_link_content` fieldable: adds a `body` field + `view_mode` base field, per-menu
view modes, and rich templates — for mega menus. Depends on core `block`,
`menu_link_content`, `text`. Manage menu link fields at **Structure → Menu link content**
(Field UI). No global config route (`configure: null`).

- Add fields to menu links & per-menu view modes → [configure/fields-view-modes.md](configure/fields-view-modes.md)
- Templates & theme-hook suggestions → [theming/theming.md](theming/theming.md)
- Drush: clear extra data (uninstall) → [drush/commands.md](drush/commands.md)
- Services (menu tree with rendered content) → [api/services.md](api/services.md)

Submodule (not documented separately): `mie_demo_base` — demo mega-menu example content.
