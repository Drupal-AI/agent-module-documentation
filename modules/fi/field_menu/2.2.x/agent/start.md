<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Menu — agent index

Provides a `field_menu` ("Menu item") field type that stores a pointer into a Drupal menu
and renders the menu tree rooted there (e.g. a custom sitemap). Widget:
`field_menu_tree_widget`; formatter: `field_menu_tree_formatter`. **No** configure route,
**no** permissions, **no** Drush, and it defines **no** plugin types of its own.

- **Add the field, its columns, and the field-level menu restrictions** →
  [configure/field.md](configure/field.md)
- **How the formatter builds and renders the tree (services, parameters)** →
  [api/formatter.md](api/formatter.md)
- **Theme-hook suggestions the module adds for the rendered menu** →
  [theming/suggestions.md](theming/suggestions.md)

Key facts:
- Field type id `field_menu`, class `MenuItemId`. Columns: `menu_title`, `menu_item_key`
  (a `menu_name:parent:link` string), `max_depth` (int, 0 = unlimited), `include_root` (bool).
- Field-level settings (in `field.field.<entity>.<bundle>.<field>` → `settings`):
  `menu_type_checkbox` (menus offered in the Root selector) and `menu_type_checkbox_negate`.
- The Root selector reuses core's `menu.parent_form_selector` service.
