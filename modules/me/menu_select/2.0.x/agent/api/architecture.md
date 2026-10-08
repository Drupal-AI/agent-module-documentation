<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu Select — architecture / API

How the parent selector gets replaced, and the reusable pieces.

## Service decorator (the entry point)

`menu_select.services.yml` decorates the core service `menu.parent_form_selector`:

```yaml
menu_select.parent_form_selector:
  decorates: menu.parent_form_selector
  class: Drupal\menu_select\MenuSelectParentFormSelector   # extends core MenuParentFormSelector
```

`MenuSelectParentFormSelector::parentSelectElement($menu_parent, $id, $menus)` calls the inner
service (so any core side effects still run), then rewrites the returned element:

- `#type` → `menu_select_tree` (the custom element below)
- `#default_value` / `#menu_parent` → the current parent (`menu_name:plugin_id`)
- `#options` → menu options (`getMenuOptions()`)
- `#max_depth` → `getParentDepthLimit($id)` (core's existing per-link depth cap)
- `#current_link_id` → `$id` (the link being edited, excluded from becoming its own parent)

Because core calls this service everywhere it needs a parent picker (node edit form's menu
settings, `menu_ui` link forms), the tree appears in all of those places automatically.

## The `menu_select_tree` render element

`src/Element/MenuSelectTree.php` (`@FormElement("menu_select_tree")`) — a core
`FormElement`, **not** a new plugin type. Its `processElement()`:

1. Stores the default value in a hidden `tree[menu_parent_id]` field (this is what submits).
2. Adds a "Menu link position preview" item.
3. If `menu_select.settings:search_enabled` AND the user has `use menu select search`, adds a
   `parent_menu_item_search` autocomplete textfield wired to route
   `menu_select.menu_select_autocomplete` with parameters `menus` (colon-joined machine names)
   and `max_depth`.
4. For each offered menu, calls `menu_select.tree_builder` to render the nested tree.

`valueCallback()` + `validateMenuSelectTree()` collapse the element's array input back to the
single hidden `menu_parent_id` string, so the submitted value is exactly
`menu_name:menu_link_plugin_id` — identical to core's `<select>`. Attaches library
`menu_select/menu_select` (JS/CSS that drive expand/collapse and selection).

## Tree-builder service — `menu_select.tree_builder`

`MenuSelectTreeBuilder` implements `MenuSelectTreeBuilderInterface`
(`Drupal\menu_select\MenuSelectTreeBuilderInterface`). Reusable in custom code:

```php
/** @var \Drupal\menu_select\MenuSelectTreeBuilderInterface $tb */
$tb = \Drupal::service('menu_select.tree_builder');
$tree = $tb->loadMenuTree('main', $max_depth);           // MenuLinkTreeElement[]
$render = $tb->buildRenderedMenu($tree, 'main', 'Main navigation', $current_link_id);
```

- `loadMenuTree($menu_name, $max_depth)` — loads the menu tree and applies the **same**
  manipulators core's default parent select uses: `checkNodeAccess`, `checkAccess`,
  `generateIndexAndSort`.
- `buildRenderedMenu($menu_tree, $menu_id, $menu_label, $current_link_id)` — returns an
  `item_list` render array; links are emitted as plain `<a data-mkey="menu:plugin_id">` markup
  (a `FormattableMarkup`, not link objects) for speed on large menus, and `$current_link_id`
  is skipped so a link can't parent itself.

## Autocomplete controller

Route `menu_select.menu_select_autocomplete`
(`/menu-select/autocomplete/{menus}/{max_depth}`, permission `use menu select search`) →
`MenuSelectAutocompleteController::autocomplete()`. It loads each menu's tree via the
tree-builder, flattens it, and returns JSON `[{value: "menu:plugin_id", label: title}, …]` for
titles that `stripos`-match the `q` query. Depth is bounded by the `{max_depth}` parameter.
