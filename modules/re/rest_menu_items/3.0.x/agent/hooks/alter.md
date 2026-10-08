<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alter hooks

Declared in `rest_menu_items.api.php`. Both let you customise the REST output without
subclassing the resource.

## `hook_rest_menu_items_resource_manipulators_alter(array &$manipulators, string &$menu_name)`

Add (or change) the menu-tree manipulators applied before the tree is built, per menu. Invoked
as `$this->moduleHandler->alter('rest_menu_items_resource_manipulators', $manipulators, $menu_name)`.

```php
function MYMODULE_rest_menu_items_resource_manipulators_alter(array &$manipulators, &$menu_name) {
  if ($menu_name === 'main') {
    $manipulators[] = ['callable' => 'my_service:manipulate'];
  }
}
```

## `hook_rest_menu_items_output_alter(array &$menu_items)`

Alter the final array of menu items just before it is returned. Invoked as
`$this->moduleHandler->alter('rest_menu_items_output', $this->menuItems)`.

```php
function MYMODULE_rest_menu_items_output_alter(array &$menu_items) {
  foreach ($menu_items as &$item) {
    if (array_key_exists('below', $item)) {
      $item['child'] = $item['below'];
      unset($item['below']);
    }
  }
}
```

## Bonus: change the endpoint path

Not a module hook, but the README documents using core's
`hook_rest_resource_alter()` to repoint the resource's canonical URI:

```php
function MYMODULE_rest_resource_alter(&$definitions) {
  if (!empty($definitions['rest_menu_item'])) {
    $definitions['rest_menu_item']['uri_paths']['canonical'] = '/api/v2/menu-items/{menu_name}';
  }
}
```
