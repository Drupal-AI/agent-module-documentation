<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dynamic Menu Item (dynamic_menu_item) — agent index

Maintains ONE admin-configured `menu_link_content` link and repoints it to a node when an editor ticks a checkbox on that node's edit form. The link always points at `internal:/node/<nid>` of the most recently flagged node.

## Facts
- **Version dir:** 2.0.x (installed 2.0.0). Core `^10.3 || ^11.0`. Package: Menu. License GPL-2.0-or-later.
- **Dependencies:** `menu_ui`, `menu_link_content` (both core). No composer requirements, no libraries, no PHP constraint.
- **Provides:** 1 config object, 1 admin form/route, 2 permissions, 1 node-form hook. No entities, plugins, services, or Drush commands. **No config schema shipped.**

## Config
- `dynamic_menu_item.settings` (default in `config/install/dynamic_menu_item.settings.yml`): `menu_item_title`, `menu_item_description`, `menu_item_parent` (`menu_name:parent_id` string), `menu_item_node_id_link`, `menu_item_weight`, `node_edit_option_title`, `enabled_content_types` (array of node-type ids).
- Note: `config/install` also seeds a `menu_item_node_id_link` default `0`. No `config/schema/` directory exists.

## Routes & permissions
- Route `dynamic_menu_item.settings` → `/admin/structure/menu/dynamic_menu_item`, form `Drupal\dynamic_menu_item\Form\DynamicMenuItemAdminForm`, requires `administer dynamic menu item` (admin route). Menu link declared in `dynamic_menu_item.links.menu.yml` under `entity.menu.collection`.
- Permissions (`dynamic_menu_item.permissions.yml`, both `restrict access: true`): `administer dynamic menu item`, `edit dynamic menu item`.

## Behaviour (`dynamic_menu_item.module`)
- `dynamic_menu_item_form_node_form_alter()` — adds a `checkboxes` element (`$form['promote']['dynamic_menu_item']`) labelled by `node_edit_option_title` to node forms whose type is in `enabled_content_types`, and appends `dynamic_menu_item_form_node_form_submit` to each non-preview submit button.
- `dynamic_menu_item_form_node_form_submit()` — if the box is ticked, calls the updater with the node id.
- `dynamic_menu_item_update_dynamic_menu_item($nid)` — loads (by title+weight) or creates a `menu_link_content`, sets title/description/weight from config, link `internal:/node/$nid`, and menu_name/parent from `menu_item_parent` (exploded on `:`).

## Solution docs
- [config/settings.md](config/settings.md) — the settings form, config keys, and the (unused) legacy `AdminForm`.
- [api/node-integration.md](api/node-integration.md) — the node-form hook, submit handler, and menu-link updater.
