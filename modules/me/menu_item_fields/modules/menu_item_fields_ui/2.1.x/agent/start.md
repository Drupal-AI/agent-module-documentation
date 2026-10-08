<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu Item Fields UI — agent index

Submodule of **menu_item_fields**. Adds the **Field UI** (Manage fields / form &amp; view
displays) for the `menu_link_content` entity so you can build the fields the parent module
renders. Enable it to build; disable in production. No config, permission, Drush, or plugin.

- **Parent module (fields on menu links, view modes, the "Menu with fields" block)** →
  [../../../../2.1.x/agent/start.md](../../../../2.1.x/agent/start.md)

Key facts:
- `hook_entity_type_alter()` sets `menu_link_content`'s **`field_ui_base_route`** to
  **`entity.menu.collection`**, attaching Field UI under the Menus admin area.
- A `RouteSubscriber` (after `field_group`, weight -220) defaults the `bundle` route param to
  **`menu_link_content`** on the Field UI / display / field-group routes (single-bundle entity).
- Depends on `menu_item_fields` + `field_ui`. Enable: `drush en menu_item_fields_ui -y`.
- Build fields programmatically on entity_type `menu_link_content`, bundle `menu_link_content`.
