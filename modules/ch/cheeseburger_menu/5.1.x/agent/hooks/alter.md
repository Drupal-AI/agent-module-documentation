<!-- SPDX-License-Identifier: GPL-2.0+ -->
# Hooks (from `cheeseburger_menu.api.php`)

These three alter hooks fire **only when the menu block's `invoke_hooks` setting is TRUE**
(off by default for performance). The block's `createHooks()` / `createMenuItemHooks()` invoke
them during `build()`.

## `hook_cheeseburger_menu_item_alter(CheeseburgerMenuItem $item)`
Alter a single menu item. `CheeseburgerMenuItem` exposes:
- `getOriginalEntityTypeId()` / `getOriginalEntityId()` (e.g. `menu_link_content`, `taxonomy_term`).
- Public attribute bags: `$item->attribute`, `$item->labelAttribute`, `$item->triggerAttribute`
  (Drupal `Attribute` objects — `addClass()`, `setAttribute()`).
```php
function my_module_cheeseburger_menu_item_alter(CheeseburgerMenuItem $item) {
  if ($item->getOriginalEntityTypeId() === 'taxonomy_term' && $item->getOriginalEntityId() == '12') {
    $item->triggerAttribute->addClass('highlighted-trigger-class');
  }
}
```

## `hook_cheeseburger_menu_alter(CheeseburgerMenu $menu)`
Alter a whole aggregated menu: `setTitle()`, plus attribute bags
`navigationItemAttribute`, `titleAttribute`. Same `getOriginalEntityTypeId()/Id()` accessors
(`menu`, `taxonomy_vocabulary`).

## `hook_cheeseburger_menu_tree_manipulators_alter(&$manipulators, $menu_link_tree)`
Add/replace menu-tree manipulators (the callables used to build the tree), e.g. append
`['callable' => 'menu.language_tree_manipulator:filterLanguage']` to filter by language.

Enable these by ticking **Invoke hooks** on the menu block (or setting
`settings.invoke_hooks: true` on the `block.block.<id>` config).
