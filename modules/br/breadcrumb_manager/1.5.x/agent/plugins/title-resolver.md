# `breadcrumb_title_resolver` plugin type

Resolves the title (label) for one breadcrumb path segment. The builder runs the **enabled**
resolvers in weight order and uses the first non-empty title.

- **Manager:** `plugin.manager.breadcrumb_title_resolver`
  (`BreadcrumbTitleResolverManager`, extends `DefaultPluginManager`).
- **Directory:** `src/Plugin/BreadcrumbTitleResolver/`.
- **Interface:** `BreadcrumbTitleResolverInterface` (base `BreadcrumbTitleResolverBase`).
- **Annotation:** `@BreadcrumbTitleResolver` — `id`, `label`, `description`, `weight` (default 0),
  `enabled` (default TRUE). The config form's per-resolver `enabled`/`weight` override the
  annotation defaults (merged in `getDefinitions()`).
- **Alter hook:** `hook_breadcrumb_manager_breadcrumb_title_resolver_info_alter()`.

## Interface
```php
public function getTitle($path, Request $request, RouteMatchInterface $route_match); // string|FALSE
public function setActive($active = TRUE);
public function isActive();
```
`isActive()` reflects the resolver's `enabled` config (set by the manager via `setActive()`).

## Shipped resolvers
| id | weight | Title source |
|---|---|---|
| `menu_link_title` | 0 | `MenuLinkManager::loadLinksByRoute()` for the segment's route; prefers the `main` menu, else the first menu link's title. |
| `request_title` | 1 | Core `title_resolver` service — the route's page title for the request. |
| `raw_path_component` | 100 | Humanized last path element (`Unicode::ucfirst`, `-`/`_` → space). Also used for route-less "fake" segments. |

## Writing one
```php
namespace Drupal\my_module\Plugin\BreadcrumbTitleResolver;

use Drupal\breadcrumb_manager\Plugin\BreadcrumbTitleResolverBase;
use Drupal\Core\Routing\RouteMatchInterface;
use Symfony\Component\HttpFoundation\Request;

/**
 * @BreadcrumbTitleResolver(
 *   id = "my_resolver",
 *   label = @Translation("My resolver"),
 *   description = @Translation("..."),
 *   weight = 5
 * )
 */
class MyResolver extends BreadcrumbTitleResolverBase {
  public function getTitle($path, Request $request, RouteMatchInterface $route_match) {
    // return a string title, or FALSE to let the next resolver try.
  }
}
```
For dependencies, override `create()`/`__construct()` (see `MenuLinkTitle`/`RequestTitle` which
inject `plugin.manager.menu.link` / `title_resolver`). New resolvers appear in the config form's
weighted table automatically.
