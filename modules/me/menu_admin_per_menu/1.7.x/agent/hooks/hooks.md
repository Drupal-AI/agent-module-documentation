# Hook (menu_admin_per_menu.api.php)

## `hook_menu_admin_per_menu_get_permissions_alter(array &$perm_menus, AccountInterface $account)`
Alter the set of menus a given user may administer. `$perm_menus` is the array
returned by `getPerMenuPermissions()` — values are menu machine names, keys are
the corresponding permission strings. Invoked (via `moduleHandler->alter`) inside
`MenuAdminPerMenuAccess::getPerMenuPermissions()`.

```php
function mymodule_menu_admin_per_menu_get_permissions_alter(array &$perm_menus, AccountInterface $account) {
  // Grant an extra menu to any authenticated user.
  if ($account->id()) {
    $perm_menus['administer custom-menu menu items'] = 'custom-menu';
  }
  // Or revoke one:
  // unset($perm_menus['administer footer menu items']);
}
```
Use this to add or remove menu access based on custom logic (group membership,
domain, workflow, etc.) beyond the assigned role permissions.
