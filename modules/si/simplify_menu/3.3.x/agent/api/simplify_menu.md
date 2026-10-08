<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API: the `simplify_menu.menu_items` service

The whole module is one service plus a Twig wrapper. Call the service from any PHP to get a
menu as a normalized array.

## Service

- **id:** `simplify_menu.menu_items`
- **class:** `Drupal\simplify_menu\MenuItems`
- **constructor arg:** `@menu.link_tree` (core's `MenuLinkTreeInterface`)

```php
$menu = \Drupal::service('simplify_menu.menu_items')->getMenuTree('main');
```

Inject it in your own service/controller instead of `\Drupal::service()` where you can:
`arguments: ['@simplify_menu.menu_items']`.

## `getMenuTree(string $menuId = 'main'): array`

Loads `$menuId` via `menu.link_tree` with `onlyEnabledLinks()`, applies the standard
`checkAccess` and `generateIndexAndSort` manipulators, flags the active trail, then flattens
the tree. Returns:

```php
[
  'menu_tree' => [
    [
      'text'         => 'Home',      // link title
      'url'          => '/',         // resolved URL string
      'active'       => false,       // true when url === current request URI
      'active_trail' => false,       // true when link is in the active trail
      // 'submenu'   => [ ...same shape... ]  // present only if the link has children
    ],
    // ...
  ],
]
```

Notes:
- Disabled links and links whose access resolves to *not allowed* are **excluded**.
- Children are nested under the `submenu` key (recursively); leaf links have no `submenu` key.
- The default argument is `'main'`, but the Twig function passes `NULL` when called with no
  arg — always pass an explicit menu machine name.
- The menu tree is cached. If you create/alter menu links programmatically, rebuild links and
  clear the menu cache before reading, e.g.
  `\Drupal::service('plugin.manager.menu.link')->rebuild(); \Drupal::cache('menu')->deleteAll();`
  (or `drush cr`).

## Decoupled / JSON output (there is no built-in route)

3.x ships **no** REST route or controller — older 1.x/2.x releases did, 3.x does not. To serve
a menu as JSON, call the service and encode it yourself, e.g. in a controller:

```php
use Symfony\Component\HttpFoundation\JsonResponse;

public function menuJson(string $menu = 'main'): JsonResponse {
  return new JsonResponse(
    \Drupal::service('simplify_menu.menu_items')->getMenuTree($menu)
  );
}
```

Wire it to a route with your own `*.routing.yml`, or return the array from a REST/JSON:API
normalizer. The array is already plain scalars/arrays, so `json_encode()` works directly.

## Altering each link — `hook_simplify_menu_simplified_link_alter()`

While flattening, the module invokes an alter on every link, so other modules can add or
change keys (icon, description, attributes, etc.):

```php
/**
 * Implements hook_simplify_menu_simplified_link_alter().
 *
 * @param array $simplifiedLink
 *   The link item being built: text, url, active, active_trail (+ submenu later).
 * @param \Drupal\Core\Menu\MenuLinkInterface $link
 *   The source menu link plugin.
 */
function mymodule_simplify_menu_simplified_link_alter(array &$simplifiedLink, $link): void {
  $simplifiedLink['description'] = $link->getDescription();
  $simplifiedLink['attributes'] = ['data-id' => $link->getPluginId()];
}
```

The added keys appear on every item in `menu_tree` (and in `submenu` entries) and are
available in both the service output and the Twig function.
