<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Parser service & alter hook

## Service `menu_firstchild.menu_item_parser`

Class `Drupal\menu_firstchild\MenuItemParser` (args: `@menu.link_tree`, `@module_handler`).
`hook_preprocess_menu()` calls `->parse($item, $menu_name)` on every menu item. For an item with
`options['menu_firstchild']['enabled']` it:

1. Loads the child menu tree under the item (`MenuTreeParameters` with `excludeRoot`,
   `maxDepth 9`, `onlyEnabledLinks`), then applies the `checkAccess` and
   `generateIndexAndSort` manipulators.
2. Picks the first child via `getFirstChildRecursively()` — if that first child is itself a
   first-child link with a subtree, it descends into it.
3. Rebuilds `$item['url']` from the child's routed or unrouted URL, adds the `menu-firstchild`
   class, and re-applies the parent's title attribute.
4. Falls back to `Url::fromRoute('<none>')` when there is no viewable child.

You normally consume this indirectly (just render a menu); call the service directly only if
you preprocess menu items yourself.

## `hook_menu_firstchild_item_alter(array &$menu_item, $child)`

Invoked (via `module_handler->alter('menu_firstchild_item', …)`) after an enabled item's URL has
been rewritten. `$menu_item` is the item render array (with `url`, `attributes`, …); `$child` is
the resolved first-child menu link element (or `NULL` when none was found).

```php
/**
 * Implements hook_menu_firstchild_item_alter().
 */
function mymodule_menu_firstchild_item_alter(array &$menu_item, $child) {
  $menu_item['attributes']->addClass('custom-class');
}
```
