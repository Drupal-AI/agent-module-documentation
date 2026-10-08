<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Menu Item Fields UI adds the Field UI (Manage fields, Manage form/display) for the `menu_link_content` entity, so you can build the fields that its parent module, Menu Item Fields, renders.

---

This submodule of `menu_item_fields` is the build-time UI. On enable it makes core Field UI operate on menu links: `hook_entity_type_alter()` sets `menu_link_content`'s `field_ui_base_route` to `entity.menu.collection` (so the Field UI local tasks attach under the Menus admin area), and a `RouteSubscriber` (running after `field_group`, weight -220) defaults the `bundle` parameter to `menu_link_content` on all the Field UI, display, and field-group routes for that entity — because `menu_link_content` is a single-bundle entity whose bundle isn't in the URL. It also tweaks the "Menu with fields" block form to link its view-mode setting to the view-modes admin page. Like core Field UI, you enable it to create fields, form modes, and view modes for menu links, then can disable it in production (the fields and configuration remain). It depends on `menu_item_fields` and `field_ui`, adds no config, permission, Drush command, or plugin of its own.

---

- Turn on Field UI for menu links so "Manage fields" appears under Menus.
- Add an image, description, or options field to `menu_link_content` via the UI.
- Configure the Manage form display for menu links (order/hide fields on the edit form).
- Configure view modes / Manage display for menu links to control rendering.
- Create a per-menu form mode for `menu_link_content` from the Display modes UI.
- Reuse existing fields on menu links through the Field UI "re-use" flow.
- Edit field storage and instance settings for menu-link fields.
- Delete menu-link fields through the standard Field UI delete form.
- Access field-group configuration for menu links (bundle defaulted correctly).
- Enable it temporarily to build menu fields, then disable it in production.
- Link the "Menu with fields" block's view-mode setting to the view-modes admin page.
- Provide site builders a familiar Field UI experience for menu items.
- Add a taxonomy reference field to menu links via the UI.
- Set up a "mega menu" content structure by adding fields in the UI.
- Manage the display of base fields (link, title, description) exposed by the parent module.
- Give the Main and Footer menus different editable fields via form modes.
- Build menu-item fields without writing FieldStorageConfig/FieldConfig code by hand.
- Keep the field-building UI out of production while retaining the fields.
- Attach the Field UI local tasks to the correct Menus admin route.
- Ensure field-group routes resolve the menu_link_content bundle automatically.
