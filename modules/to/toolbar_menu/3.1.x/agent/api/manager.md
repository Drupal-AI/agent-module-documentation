<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Toolbar Menu — programmatic API

Small surface: one service, the `toolbar_menu_element` config entity with accessor methods,
and a cache tag. No hooks for you to implement, no Drush commands, no plugin types.

## Service: `toolbar_menu.manager`

`Drupal\toolbar_menu\ToolbarMenuManager` (constructed with the entity type manager and the
current account). It loads all `toolbar_menu_element` entities once at construction.

```php
$manager = \Drupal::service('toolbar_menu.manager');

// Elements the CURRENT user may see (filtered by the per-element
// "view <id> in toolbar" permission). Keyed by element id.
$elements = $manager->getToolbarMenuElements();

// The dynamic permission definitions (used by ToolbarMenuPermissions).
$perms = $manager->getPermissionList();

// Sanitize an id for use in a machine/permission context.
$clean = $manager->cleanId('Some Id');
```

`hook_toolbar()` (in `toolbar_menu.module`) iterates `getToolbarMenuElements()` and builds a
`toolbar_item` per element, using `$element->getDisplayLabel()` for the tab title and
pre-rendering `$element->loadMenu()`'s link tree into the tray
(`ToolbarMenuPrerender::prerenderToolbarTray`).

## Entity accessor methods

On a loaded `Drupal\toolbar_menu\Entity\ToolbarMenuElement`:

| Method | Returns |
|---|---|
| `menu()` | The target menu machine name (`menu` property) |
| `loadMenu()` | The loaded `Drupal\system\Entity\Menu` (or NULL) |
| `rewriteLabel()` | The `rewrite_label` boolean |
| `weight()` | The `weight` integer |
| `getDisplayLabel()` | The menu's own label if `rewrite_label` is TRUE and a menu is set, else the element `label` |

```php
$el = \Drupal::entityTypeManager()->getStorage('toolbar_menu_element')->load('my_tab');
$title = $el->getDisplayLabel();          // what shows on the toolbar tab
$menu  = $el->loadMenu();                  // the referenced Menu entity
```

## Cache tag

Saving any element invalidates the **`toolbar_menu`** cache tag (via the entity's
`postSave()`), and `hook_page_top()` tags the toolbar render array with it, so the toolbar
rebuilds when elements change. Force a rebuild manually with `drush cr` if needed.
