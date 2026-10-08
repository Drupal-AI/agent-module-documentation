<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Provus Mega Menu — agent index

A thin **theming** module for the Provus base theme: renders the main menu as a full-width,
multi-column mega menu with optional callout image/link panels and per-item icons. No
settings form, no permissions, no Drush, no plugins, no config schema. Requires
`menu_item_extras` (and, at runtime, the Provus base theme).

- **The template/theme hook, library, form_alter, and the callout/icon fields it reads** →
  [theming/mega-menu.md](theming/mega-menu.md)

Key facts:
- Theme hook `menu__extras` → template `menu--extras.html.twig` (base hook
  `menu_item_extras`); library `provus_mega_menu/main-nav`.
- `hook_form_alter()` on `menu_link_content_main_form` toggles, via `#states`:
  `field_provus_menu_callout_image` + `field_provus_menu_callout_link` (top-level items only)
  and `field_provus_menu_icon` (child items only).
- Those fields are provided by the Provus recipe (attached to menu link content), **not** by
  this module; the template renders them.
