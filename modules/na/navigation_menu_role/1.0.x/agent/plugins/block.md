<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `navigation_menu_role` block plugin

The module does **not** define a new plugin type. It provides one core-`Block` plugin,
derived per menu.

## Plugin

`Drupal\navigation_menu_role\Plugin\Block\NavigationMenuRoleBlock` (declared `final`):

```php
#[Block(
  id: "navigation_menu_role",
  admin_label: "Navigation menu (role visibility)",
  category: "Menus per role (Navigation)",
  deriver: SystemMenuNavigationBlockDeriver::class,   // from core navigation module
)]
```

- Extends core `SystemMenuBlock`; the deriver is core Navigation's
  `SystemMenuNavigationBlock` deriver, so there is one derivative per menu
  (`navigation_menu_role:<menu>`).
- `const NAVIGATION_MAX_DEPTH = 3` — `blockForm()` limits the depth options to 1–3 and
  removes the `expand_all_items` control.
- `defaultConfiguration()` → `['level' => 1, 'depth' => 0, 'roles' => []]`.
- `blockForm()` adds a **Roles** checkboxes element (options = all `user_role` entities);
  `blockSubmit()` saves `level`, `depth`, and the filtered `roles` array.
- `blockAccess(AccountInterface $account)`:
  `AccessResult::allowedIf(empty($roles) || array_intersect($account->getRoles(), $roles))`.
- `build()` loads the menu tree (min depth = `level`, max depth = `level + depth`, capped at
  the tree max), applies `checkAccess` + `generateIndexAndSort`, and builds it.
- `getCacheContexts()` strips `route.menu_active_trails` contexts (the block does not use the
  active trail).

## `hook_block_alter()`

`Drupal\navigation_menu_role\Hook\NavigationMenuRoleHooks::blockAlter()` walks all block
definitions and, for base id `navigation_menu_role`, sets
`allow_in_navigation = TRUE` (so the block may be placed in the Navigation region) and
`_block_ui_hidden = TRUE` (so it does not appear in the generic Block layout UI).

## Extending

To place/read blocks, use `block.block` config entities (see
[../configure/role-block.md](../configure/role-block.md)). There are no services, hooks, or
plugin managers exposed for reuse; the only extension point is standard block configuration.
