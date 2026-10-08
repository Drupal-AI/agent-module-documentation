<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# hook_megamenu_manipulators_alter()

The only hook We Mega Menu invites (`we_megamenu.api.php`). It lets any module or theme alter the
list of **menu link tree manipulators** applied while We Mega Menu builds a menu's tree in
`WeMegaMenuBuilder::getMenuTree()`. Typical use: filter menu items by the current user's language.

```php
/**
 * Implements hook_megamenu_manipulators_alter().
 *
 * @param array $manipulators
 *   The manipulators to apply. Each: [
 *     'callable' => 'service_id:method' | callable,   // resolved via ControllerResolver
 *     'args' => [ ... ],                               // optional, passed after $tree
 *   ]
 * @param string $menu_name
 *   The menu being built — check this yourself to scope your change.
 */
function mymodule_megamenu_manipulators_alter(array &$manipulators, $menu_name) {
  if ($menu_name === 'main') {
    $manipulators[] = [
      'callable' => 'menu.default_tree_manipulators:generateIndexAndSort',
    ];
  }
}
```

The default manipulator list We Mega Menu starts from is just
`[['callable' => 'menu.default_tree_manipulators:checkAccess']]`; your alter runs before
`$menu_tree->transform()` is applied. Because the hook fires for **every** menu render, always
gate on `$menu_name` (or the manipulator will run on all menus). Manipulators must match core's
menu-tree manipulator contract (they receive the `$tree` array plus any `args`).
