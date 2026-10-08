# Menu-tree manipulators & hook (superfish.api.php)

When the Superfish block builds its menu (`SuperfishBlock::build()`) it transforms the loaded tree
with this manipulator chain, in order:

1. `superfish.menu_tree_manipulator:filterDisabledLinks` — removes disabled menu links **and their
   descendants** from the tree (Superfish's own `Menu\MenuTreeManipulator`).
2. `menu.default_tree_manipulators:checkAccess` — core access check.
3. `menu.default_tree_manipulators:generateIndexAndSort` — core index/sort.
4. `superfish.translatable_menu_link_manipulator:transform` — added **only if** the
   `translatable_menu_link_uri` module is enabled (handles translated menu link titles;
   `Menu\TranslatableMenuLinkManipulator`, constructed with `@menu_link.static.overrides`).
5. `menu_manipulator.menu_tree_manipulators:filterTreeByCurrentLanguage` — added **only if** the
   `menu_manipulator` module is enabled.

Between steps 3 and 4 the module fires an alter hook so custom code can add to or reorder the list:

- `hook_superfish_tree_manipulators_alter(array &$manipulators, $menu_name = NULL, array &$tree = [])` —

  ```php
  function mymodule_superfish_tree_manipulators_alter(&$manipulators, $menu_name = NULL, &$tree = []) {
    $manipulators[] = ['callable' => 'mymodule.tree_manipulator:checkAccess'];
  }
  ```

Implement in `mymodule.module`. The module ships two manipulator services, declared in
`superfish.services.yml`: `superfish.menu_tree_manipulator` (`Menu\MenuTreeManipulator`) and
`superfish.translatable_menu_link_manipulator` (`Menu\TranslatableMenuLinkManipulator`).
