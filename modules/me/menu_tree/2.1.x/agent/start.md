<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu tree (menu_tree) — agent index

Replaces the flat **Parent link** `<select>` on node add/edit forms with a browsable,
drag-and-drop menu tree. Enabled per content type. Menu link storage is unchanged —
it is a widget substitution plus a weight-recalculation submit handler, fully reversible.

- Dependencies: none (Drupal core only). Core requirement `^10.3 || ^11`.
- Configure route: **none** — there is no settings page. It is turned on per content type
  via a checkbox on the node type form's *Menu settings* tab (a node-type third-party setting).
- Provides: config schema (a node-type third-party setting), 4 services, an SDC component,
  form-alter hooks. **No** permissions, routes, drush commands, or plugin types of its own.

Solution docs:
- **Turn the tree widget on for a content type (drush/PHP/UI)** → [configure/enable-widget.md](configure/enable-widget.md)
- **Build an access-filtered nested menu array / reuse the services** → [api/services.md](api/services.md)
- **Render or override the tree UI (SDC component)** → [theme/component.md](theme/component.md)
- **What it alters on the node & node-type forms, load order, install weight** → [hooks/form-integration.md](hooks/form-integration.md)

Key facts:
- Third-party setting: entity `node_type`, provider `menu_tree`, key `use_tree_widget` (boolean).
- Config schema key: `node.type.*.third_party.menu_tree` → `use_tree_widget`.
- Services: `menu_tree.items` (`MenuTreeItems`), `menu_tree.menu_tree_manipulators`
  (`MenuTreeManipulator`), `menu_tree.node_form_submit_handler` (`NodeFormSubmitHandler`),
  `Drupal\menu_tree\Hook\Hooks` (autowired hook object).
- SDC component id: `menu_tree:menu-tree` (under `components/menu-tree/`).
- Hooks: `help`, `module_implements_alter`, `form_node_form_alter`, `form_node_type_form_alter`,
  `preprocess_form_element_label`. Form alters run `OrderAfter(['menu_ui'])`.
- `hook_install` sets the module weight to 1 (so it alters after menu_ui). Uninstall removes the
  third-party settings from every node type.
- Optional integration: detects `menu_ui_async_widget` and targets its `container` element.
