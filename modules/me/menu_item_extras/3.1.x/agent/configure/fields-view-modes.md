# Fields & view modes on menu links

Enabling the module converts `menu_link_content` into a fully fieldable entity and adds:
- a default **body** field, and
- a `view_mode` base field (widget `menu_item_extras_view_mode_selector_select`) on the
  menu-link edit form.

## Add custom fields
Use the standard Field UI at **Structure → Menu link content**
(`/admin/structure/menu/menu_link_content/…`): Manage fields / form display / display,
exactly like nodes. Add images, text, entity references, etc. to menu links.

## Per-menu view modes
Each menu exposes a view-modes settings form:
`/admin/structure/menu/manage/{menu}/view_modes_settings/default`
(route `entity.menu.view_modes_settings`, link template `view-modes-settings`; gated by
`menu.update` access, i.e. core `administer menu`). Enable which view modes a menu (and its
levels) may use, so different menus render their links differently. Set a per-item view mode
from the menu link edit form's `view_mode` selector.

## Clearing extra data
When uninstalling, remove the stored field/extra data:
- UI: `/admin/modules/uninstall/extra_data/menu_item_extras`
  (route `menu_item_extras.clear_all_extra_data`, permission `administer menu`), or a
  per-menu clear at `/admin/structure/menu/manage/{menu}/clear`.
- Drush: see [../drush/commands.md](../drush/commands.md).
An uninstall validator blocks uninstall until extra data is cleared.

Config: `menu_item_extras.utility` (`config_object`, tracks `entity_type_build_status`).
