<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & admin form

## Install / enable
`drush en dynamic_menu_item -y` (pulls core `menu_ui` + `menu_link_content`). The install profile writes `dynamic_menu_item.settings` from `config/install/dynamic_menu_item.settings.yml`.

## Config object: `dynamic_menu_item.settings`
Defaults (`config/install/dynamic_menu_item.settings.yml`):

| Key | Default | Meaning |
|-----|---------|---------|
| `menu_item_title` | `''` | Title given to the managed menu link; also the key used to find the existing link. |
| `menu_item_description` | `''` | Menu link description. |
| `menu_item_parent` | `''` | Combined `menu_name:parent_plugin_id` string from the parent selector; split on `:` (first part = menu, second = parent). |
| `menu_item_node_id_link` | `0` | Optional node id; if `> 0` on settings save, the link is (re)pointed to that node immediately. |
| `menu_item_weight` | `0` | Menu link weight; also part of the lookup key. |
| `node_edit_option_title` | `''` | Label for the checkbox added to node edit forms. |
| `enabled_content_types` | `[]` | Node-type ids on which the checkbox appears. |

There is **no `config/schema/`** directory in this project, so these keys are unschematized (relevant for config export typing and translation).

## Admin form — `DynamicMenuItemAdminForm`
`src/Form/DynamicMenuItemAdminForm.php` (extends `ConfigFormBase`, form id `dynamic_menu_item_admin_form`, editable config `dynamic_menu_item.settings`). Route `dynamic_menu_item.settings` at `/admin/structure/menu/dynamic_menu_item`, permission `administer dynamic menu item`.

- Constructor injects `config.factory`, `config.typed`, `entity_type.manager`, `menu.parent_form_selector`, `messenger`, `menu.link_tree`.
- `buildForm()` builds the parent selector via `MenuParentFormSelectorInterface::parentSelectElement()` over all menus (`menu.link_tree`→`loadMultiple()`, labels `asort`ed). **If no parent items are found it shows a warning and returns an empty form** (no fields render). Fields: `menu_item_parent` (parent selector), `menu_item_title`, `menu_item_description`, `menu_item_node_id_link` (Node ID textfield), `menu_item_weight`, `node_edit_option_title`, and `enabled_content_types` (`checkboxes` of all `node_type` labels).
- `submitForm()` saves all keys, then if the entered `menu_item_node_id_link` `> 0` calls `dynamic_menu_item_update_dynamic_menu_item($nid)` to point the link at that node immediately.

## Legacy / dead code — `AdminForm`
`src/Form/AdminForm.php` is a second `ConfigFormBase` (same form id `dynamic_menu_item_admin_form`) targeting a **different** config object `dynamic_menu_item.adminsettings` with different keys (`menu_parent`, `option_title`, `menu_title`, `menu_weight`, `enabled_content_types`). **No route references it** (routing.yml only wires `DynamicMenuItemAdminForm`), so it is unused legacy code; `dynamic_menu_item.adminsettings` is never read by the runtime path. Ignore it when configuring the module.
