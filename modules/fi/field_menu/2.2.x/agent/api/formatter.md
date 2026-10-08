<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How the formatter renders the tree

`field_menu_tree_formatter` (`Drupal\field_menu\Plugin\Field\FieldFormatter\MenuTreeFormatter`)
turns each stored value into a rendered menu tree. Injected services:
`menu.link_tree` (`MenuLinkTreeInterface`) and `menu.active_trail` (`MenuActiveTrailInterface`).

Per value, `viewElements()`:

1. Splits `menu_item_key` on `:` into `[menu_name, parent, link]`.
2. Builds `MenuTreeParameters`:
   - `setActiveTrail(active_trail_ids)` for the menu,
   - `setRoot($parent)` (for `menu_link_content` links the root becomes `menu_link_content:<link>`),
   - `onlyEnabledLinks()` — disabled links are never rendered,
   - `setMaxDepth($max_depth)` only when `max_depth > 0`,
   - `excludeRoot()` unless `include_root` is set.
3. Loads the tree (`$menuLinkTree->load($menu_name, $parameters)`), applies the standard
   manipulators (`checkNodeAccess`, `checkAccess`, `generateIndexAndSort`), and builds it.
4. Sets `#field_menu_configuration` on the built tree (providing entity, view mode, label) and
   forces `#theme = 'menu'`, then wraps it in a `field_menu_item` render element with `#title`
   (the trimmed `menu_title`) and a `languages:language_interface` cache context.

The wrapper template `templates/field-menu-item.html.twig` prints the title as
`<h2 class="menu-title">` (when set) followed by the rendered tree.

This module implements a field formatter/widget/type; it **defines no plugin type** of its own
(`provides_plugin_types: []`).
