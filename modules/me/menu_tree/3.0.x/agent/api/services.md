<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services, the decorator & the `menu_tree` form element

Declared in `menu_tree.services.yml` with `_defaults: { autowire: true, autoconfigure: true }`.

| Service id | Class | Role |
| --- | --- | --- |
| `menu_tree.parent_form_selector` | `Drupal\menu_tree\MenuTreeParentFormSelector` | **Decorates** core `menu.parent_form_selector`. |
| `Drupal\menu_tree\MenuTreeItems` | `MenuTreeItems` | Builds a plain nested array of a menu's links. |
| `Drupal\menu_tree\FormSubmitHandler` | `FormSubmitHandler` | Repositions a link and rewrites branch weights on submit. |

The hook object `Drupal\menu_tree\Hook\MenuTreeHooks` is a `ContainerInjectionInterface` service
(not listed here; see [../forms/form-integration.md](../forms/form-integration.md)).

## `menu_tree.parent_form_selector` — MenuTreeParentFormSelector

Extends core `MenuParentFormSelector` and decorates `menu.parent_form_selector` (inner service
injected as `@menu_tree.parent_form_selector.inner`). It overrides **`parentSelectElement()`**:

1. Calls the inner `parentSelectElement()` first (so inner side-effects still run).
2. Resolves the node / node_type from the current route.
3. **On node routes** (`node` or `node_type` route param present): returns the inner element
   unchanged unless the node type resolves and has `use_tree_widget` enabled.
4. **On any other route** (Views UI, menu-link forms, …): always switches to the tree.
5. When switching, it drops `#options`, sets `#type => 'menu_tree'`, `#default_value =>
   $menu_parent`, and `#menu_link_id => $id`.

This is why enabling the widget per content type only affects node forms — other forms get the
tree because they are not node routes.

## Render element `#type => 'menu_tree'` (`src/Element/MenuTree.php`)

A `#[FormElement(id: 'menu_tree')]` extending `FormElementBase`. It is a `#tree` element whose
value collapses to the single chosen parent string. Sub-elements:

- `menu_tree` — `#type => 'component'`, `#component => 'menu_tree:menu-tree'`, `#cache max-age 0`.
- `menu_parent` — hidden input (`js-menu-tree-menu-parent`), holds the selected parent id.
- `prev_sibling` / `next_sibling` — hidden inputs the JS writes with drop position.

`processElement()` does the heavy lifting:

- **Node form:** reads `use_tree_widget` (returns early if off), reads menu_ui's
  `available_menus` (returns early if none), loads those `menu` entities and **sorts them by the
  `menu_tree:weight` third-party setting**, computes `exclude` and `expanded_menu` from
  `MenuUiUtility::getMenuLinkDefaults($node)`, and hides `menu.link.weight`.
- **Other forms:** loads **all** menus, derives `exclude`/`expanded_menu` from the current menu
  link (via `plugin.manager.menu.link`) or `#default_value`, and hides `options.menu.weight`.
- For each menu it calls `MenuTreeItems::getLinks()`, assigns the component `#props`
  (`menus`, `exclude`, `expanded_menu`, `attributes`), and attaches
  `drupalSettings.menu_tree.elementName` = the element `#name`.

`valueCallback()` returns `$input ?: FALSE`; `validateMenuTree()` sets the element's form-state
value to the inner `menu_parent` so the element yields a single scalar, not an array.

## `Drupal\menu_tree\MenuTreeItems`

Builds a plain nested array of a menu's links, ready for the SDC component.

```php
/** @var \Drupal\menu_tree\MenuTreeItems $items */
$items = \Drupal::service(\Drupal\menu_tree\MenuTreeItems::class);
$data = $items->getLinks('main');
// => ['label' => 'Main navigation', 'id' => 'main',
//     'menu_tree' => [ ['text','weight','url','id','submenu'=>[...]], ... ]]
```

`getLinks(string $menu_id = 'main'): array`

- Loads the tree with `MenuTreeParameters::onlyEnabledLinks()`.
- Runs core manipulators `menu.default_tree_manipulators:checkAccess` then `:generateIndexAndSort`.
- `transform()` flattens each `MenuLinkTreeElement` to `text` / `weight` / `url` / `id`
  (`id` = `<menu_name>:<plugin_id>`), recursing into `submenu`.
- **Access-aware:** links whose `$element->access` is not `isAllowed()` are skipped (mirrors
  core `MenuLinkTree::build()`); disabled links are skipped; a non-`AccessResultInterface`
  access value throws `\DomainException`. Returns `[]` if the menu entity does not exist.

Constructor deps: `@menu.link_tree`, `@entity_type.manager` (autowired).

## `Drupal\menu_tree\FormSubmitHandler`

Appended as a submit handler by the form alters (see
[../forms/form-integration.md](../forms/form-integration.md)). Three public entry points —
`handleNodeFormSubmit()`, `handleViewsFormSubmit()`, `handleMenuLinkFormSubmit()` — each reads
the chosen parent plus the hidden `prev_sibling` / `next_sibling` markers (locations differ per
form), resolves the `MenuLinkInterface` being placed, and delegates to the protected
`repositionAndSaveBranch($parent, $menu_link, $prev_sibling, $next_sibling)`:

- Splits `$parent` into `<menu>:<parent_id>`; loads that branch via `@menu.link_tree`
  (rooted + root-excluded unless `$parent` is `<menu>:`).
- Sorts the branch, keys siblings by `<menu>:<plugin_id>`, inserts the link after
  `prev_sibling` (first if none; last if the sibling is absent).
- Rewrites every link's weight in the branch starting at `-50` via
  `MenuLinkManagerInterface::updateDefinition()`, returning the updated target instance.

`handleViewsFormSubmit()` additionally writes the new weight back into the view display's `menu`
options and calls `$view->cacheSet()`. Node handler no-ops when the menu item is not enabled.

Constructor deps: `@entity_type.manager`, `@menu.link_tree`, `@plugin.manager.menu.link`,
`@Drupal\menu_ui\MenuUiUtility` (autowired). Uses `DependencySerializationTrait` so the handler
object survives form-state serialization.
