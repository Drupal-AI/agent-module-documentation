# allowed_menus service

Service id **`menu_admin_per_menu.allowed_menus`**
(`Drupal\menu_admin_per_menu\Access\MenuAdminPerMenuAccess`), implementing
`MenuAdminPerMenuAccessInterface`. Use it to check per-menu access in custom
code, form alters, or access handlers.

```php
/** @var \Drupal\menu_admin_per_menu\MenuAdminPerMenuAccessInterface $svc */
$svc = \Drupal::service('menu_admin_per_menu.allowed_menus');
```

Methods:
- `getPerMenuPermissions(AccountInterface $account): array` — map of
  `permission name => menu machine name` for menus the user may administer
  (statically cached per user; runs the alter hook — see hooks doc).
- `menusOverviewAccess(AccountInterface): AccessResult` — allowed if the user
  has `administer menu` or any per-menu permission.
- `menuAccess(AccountInterface, Menu $menu): AccessResult` — access to a menu.
- `menuItemAccess(AccountInterface, ?MenuLinkContent): AccessResult` — access to
  a menu link content entity (used by `hook_ENTITY_TYPE_access`).
- `menuLinkAccess(AccountInterface, ?MenuLinkInterface): AccessResult` — access
  to a menu link plugin.

Each returns `AccessResult::allowed()` when the account has `administer menu` or
the matching `administer <menu> menu items` permission, else `neutral()`.

The module also ships a `MenuSelection` EntityReferenceSelection plugin
(`src/Plugin/EntityReferenceSelection/MenuSelection.php`) so `menu` entity
reference fields only offer menus the user is allowed to administer.
