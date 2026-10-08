# tb_megamenu — agent start

TB Mega Menu turns a Drupal core menu into a multi-column mega menu built in a drag-and-drop
back-end. Each menu+theme pairing is stored in a `tb_megamenu` config entity
(`config_prefix: menu_config`, id `{menu}__{theme}`) and exposed as a derivative of the
`tb_megamenu_menu_block` block plugin. Admin UI: **Structure → TB Mega Menu**
(`/admin/structure/tb-megamenu`, configure route `entity.tb_megamenu.collection`). Sole
permission: `administer tb_megamenu`. No contrib dependencies.

- Create a mega menu, place its block, per-item/block/column options → [configure/tb_megamenu.md](configure/tb_megamenu.md)
- Override templates, theme hooks, preprocess, libraries/styles → [theming/tb_megamenu.md](theming/tb_megamenu.md)
- Config entity + `tb_megamenu.menu_builder` service API → [api/tb_megamenu.md](api/tb_megamenu.md)
