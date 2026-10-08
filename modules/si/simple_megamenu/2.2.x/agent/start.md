# Simple Mega Menu — agent index

Adds a fieldable, revisionable, translatable **`simple_mega_menu`** content entity (bundle =
config entity **`simple_mega_menu_type`**) that you attach to individual **menu link content** items
to render a mega-menu panel. No global settings page (`configure: null`), no Drush. Rendering is via
two Twig functions. Ships a `simple_megamenu_example` submodule with a ready-made bundle.

- **Create a bundle, set its target menus, add fields/view modes, attach to a menu link** →
  [configure/megamenu-types.md](configure/megamenu-types.md)
- **The two entity types, the `data-simple-mega-menu` attribute mechanism, helper service, Twig
  functions** → [api/entities-and-twig.md](api/entities-and-twig.md)
- **Templates, theme hooks and suggestions** → [theming/templates.md](theming/templates.md)
- **The permission set** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Content entity `simple_mega_menu` (base fields incl. `name`, `status`; base_table `simple_mega_menu`);
  admin collection at `/admin/content/simple_mega_menu`.
- Bundle config entity `simple_mega_menu_type` (config prefix `simple_megamenu.simple_mega_menu_type`),
  key field **`targetMenu`** = list of menu machine names it applies to; UI at
  `/admin/structure/simple_mega_menu_type`.
- A menu link "belongs to" a mega menu when its `options.attributes['data-simple-mega-menu']` holds
  the entity id (set by the autocomplete added to the menu link content form).
- Twig: `has_megamenu(url)` and `view_megamenu(url, view_mode)`; shipped view modes **before** / **after**.
- The autocomplete only appears on menu links whose menu is targeted by at least one bundle.
