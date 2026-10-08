<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The breadcrumb builder service

- **Service:** `breadcrumb_menu.breadcrumb`
- **Class:** `Drupal\breadcrumb_menu\BreadcrumbBuilder extends Drupal\system\PathBasedBreadcrumbBuilder`
- **Tag:** `breadcrumb_builder`, **priority 1** (`breadcrumb_menu.services.yml`).

Core's default builder `system.breadcrumb.default` is tagged at priority 0, so this service is
consulted first. It does **not** override `applies()`; the parent's `applies()` returns TRUE
for every route, so this builder wins on all pages and effectively replaces the core
path-based breadcrumb.

## What `build()` does (`src/BreadcrumbBuilder.php`)

1. `$links = parent::build($route_match)` — produces the **standard path-based** breadcrumb
   (`Drupal\Core\Breadcrumb\Breadcrumb`). This step already filters out links the current
   user cannot access (the parent uses `@access_manager` / `@current_user`). The module never
   adds links of its own, so it cannot introduce a link to a page the trail did not already
   contain.
2. For each menu name in `breadcrumb_menu.settings:menus`:
   - adds cache context `route.menu_active_trails:<menu>`;
   - walks `menu.active_trail`'s `getActiveTrailIds(<menu>)`, instantiates each menu link
     via `plugin.manager.menu.link` (`createInstance()`), and records a map
     `url-string => menu link title` (first title per URL wins: `... ??= $menu_link->getTitle()`);
   - adds each menu link as a cacheable dependency (`$links->addCacheableDependency($menu_link)`).
3. Iterates the existing breadcrumb links; for any whose `getUrl()->toString()` matches a URL
   in the map, replaces the link **text** with the menu link title via `$link->setText(...)`.

Net effect: the trail shape (which URLs, in what order) stays the path-based trail; only the
visible label of a link is swapped to its menu title where the two URLs coincide in a
configured menu's active trail. Links with no matching menu entry keep their page-title text.

## Constructor arguments (order, from services.yml)

`@router.request_context`, `@access_manager`, `@router`, `@path_processor_manager`,
`@config.factory`, `@title_resolver`, `@current_user`, `@path.current`, `@menu.active_trail`,
`@plugin.manager.menu.link`. The first eight are forwarded to the parent constructor; the
last two are this module's additions. The config `breadcrumb_menu.settings` is read once in
the constructor into `$this->breadcrumbMenuConfig`.

## Cache

The returned `Breadcrumb` carries `route.menu_active_trails:<menu>` contexts plus each menu
link's cacheability, on top of the cache metadata already set by the parent path-based
builder — so it varies correctly per active menu trail.

## Integration note: priority conflicts

Any other `breadcrumb_builder` whose `applies()` returns TRUE at a priority **> 1** will
short-circuit this one for the routes it claims. A second breadcrumb module registered at a
higher priority is the usual reason "Breadcrumb Menu has no effect" — inspect the tagged
services (`breadcrumb_builder`) and their priorities before debugging this module.
