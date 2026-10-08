<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu tree (menu_tree) — agent index

Replaces the flat **Parent link** `<select>` with a browsable, filterable, drag-and-drop
menu tree. In 3.x it **decorates the core `menu.parent_form_selector` service**, so the tree
can appear anywhere `parentSelectElement()` is called: node add/edit forms (opt-in per content
type), the Views UI menu-link display, and the menu-link content form. Menu link storage is
unchanged — it is a widget substitution plus a weight-recalculation submit handler, reversible.

- Dependencies: **`drupal:menu_ui`** (new in 3.x). Core requirement **`>= 11.4`** (D10 dropped).
- Configure route: **none** — there is no settings page. On node types it is turned on per
  content type via a checkbox on the node type form's *Menu settings* tab (a node-type
  third-party setting); on Views and menu-link forms the tree is always used.
- Provides: config schema (two third-party settings), a decorator + 2 plain services, a
  `menu_tree` `FormElement`, an SDC component, and OOP form-alter hooks. **No** permissions,
  routes, drush commands, or plugin types of its own. No `.module` file (pure attribute hooks).

Solution docs:
- **Turn the tree widget on for a content type; set per-menu weight (drush/PHP/UI)** → [configure/enable-widget.md](configure/enable-widget.md)
- **Services, the decorator, and the `menu_tree` form element** → [api/services.md](api/services.md)
- **What it alters on which forms, submit handlers, load order** → [forms/form-integration.md](forms/form-integration.md)
- **Render or override the tree UI (SDC component)** → [theme/component.md](theme/component.md)

Key facts:
- Node-type third-party setting: entity `node_type`, provider `menu_tree`, key `use_tree_widget`
  (boolean, default FALSE). Config schema `node.type.*.third_party.menu_tree`.
- Menu third-party setting: entity `menu` (`system.menu.*`), provider `menu_tree`, key `weight`
  (integer, default 0) — orders the menus shown in the widget. Config schema
  `system.menu.*.third_party.menu_tree`.
- Services: `menu_tree.parent_form_selector` (decorates `menu.parent_form_selector`,
  `MenuTreeParentFormSelector`), `Drupal\menu_tree\MenuTreeItems`,
  `Drupal\menu_tree\FormSubmitHandler`. All autowired.
- Render element: `#type => 'menu_tree'` (`src/Element/MenuTree.php`).
- SDC component id: `menu_tree:menu-tree` (under `components/menu-tree/`).
- Hooks (OOP, `src/Hook/MenuTreeHooks.php`): `help`, `form_node_form_alter`,
  `form_views_ui_edit_display_form_alter`, `form_menu_link_content_form_alter`,
  `form_menu_form_alter`, `form_node_type_form_alter`, `preprocess_form_element_label`.
  The three form-alters that add submit handlers run `OrderAfter(['menu_ui'])`.
- Uninstall (`menu_tree.uninstall`) removes `menu_tree` third-party settings from every
  `node_type` and every `menu`. Menu link data is untouched.
