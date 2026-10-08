<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu Item Fields — agent index

Makes the **`menu_link_content`** entity type fieldable and renderable with **view modes**.
Menus are rendered through a block, **"Menu with fields"** (block plugin `menu_item_fields`,
derived per menu). No configure route, permission, config schema, or Drush command.

- **Add fields to menu links, view modes, per-menu form modes, and place/configure the block** →
  [configure/menu-fields.md](configure/menu-fields.md)
- **How menus are rendered (preprocess_menu, templates, view-mode override field) & 1.x→2.x** →
  [theming/templates.md](theming/templates.md)

Key facts:
- Field UI for menu links lives in the **`menu_item_fields_ui`** submodule (enable it to build
  fields); it sets `menu_link_content`'s `field_ui_base_route` to `entity.menu.collection`.
- The block **"Menu with fields"** (id `menu_item_fields`, e.g. `menu_item_fields:main`) has two
  settings: `view_mode` and `view_mode_override_field`.
- A **form mode** on `menu_link_content` whose machine name matches a menu (dashes→underscores)
  is auto-used when editing that menu's links (`hook_entity_form_mode_alter`).
- Submodule docs: [modules/menu_item_fields_ui/2.1.x/](../../modules/menu_item_fields_ui/2.1.x/agent/start.md)
