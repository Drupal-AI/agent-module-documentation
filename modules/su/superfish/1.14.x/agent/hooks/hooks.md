# Hooks (superfish.api.php)

- `hook_superfish_tree_manipulators_alter(array &$manipulators, $menu_name = NULL, array &$tree = [])` —
  add to or change the list of menu-tree manipulators Superfish applies when building a menu
  (e.g. inject a custom access-check or reordering manipulator):
  ```php
  function mymodule_superfish_tree_manipulators_alter(&$manipulators, $menu_name = NULL, &$tree = []) {
    $manipulators[] = ['callable' => 'mymodule.tree_manipulator:checkAccess'];
  }
  ```

Implement in `mymodule.module`. The module itself ships one manipulator service,
`superfish.translatable_menu_link_manipulator` (`Menu\TranslatableMenuLinkManipulator`), which
handles translated menu link titles.
