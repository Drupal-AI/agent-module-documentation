<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# hook_layout_builder_blocks__is_dashboard_type_route_alter()

The module suppresses the Style tab on Layout Builder forms whose route name **or** path
contains `dashboard`/`dashboards` (so Dashboard layouts stay unstyled). That decision runs
through `layout_builder_blocks__is_dashboard_type_route()`, which invokes an alter hook so you
can force the Style tab on or off for your own routes.

```php
/**
 * Implements hook_layout_builder_blocks__is_dashboard_type_route_alter().
 *
 * @param bool $is_dashboard
 *   TRUE means "treat as a dashboard route" → the Style tab is NOT added.
 *   Set FALSE to allow styling; set TRUE to suppress it.
 * @param mixed $context
 *   Reserved context (currently NULL).
 */
function mymodule_layout_builder_blocks__is_dashboard_type_route_alter(&$is_dashboard, &$context) {
  $route = \Drupal::routeMatch()->getRouteName();
  // Example: never treat my custom builder route as a dashboard.
  if ($route === 'mymodule.custom_layout') {
    $is_dashboard = FALSE;
  }
}
```

Notes:
- The result is statically cached per request (`drupal_static`), so the hook fires once per
  request.
- This is the only hook the module defines. It has no `.api.php` file; the hook name derives
  from the function `layout_builder_blocks__is_dashboard_type_route()` in
  `layout_builder_blocks.module`.
