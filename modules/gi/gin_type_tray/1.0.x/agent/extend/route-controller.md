<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extend: route subscriber + controller override

## Route subscriber
`src/Routing/GinTypeTrayRouteSubscriber.php` (registered in `gin_type_tray.services.yml` as
`gin_type_tray.route_subscriber`, tag `event_subscriber`, extends `RouteSubscriberBase`).

In `alterRoutes()` it takes the core `node.add_page` route and overrides its `_controller`
default to:
```
\Drupal\gin_type_tray\Controller\GinTypeTrayController::addPage
```
So on a site with this module enabled, `node.add_page` is served by GinTypeTrayController, not
Type Tray's controller. Confirm on the live site:
```php
\Drupal::service('router.route_provider')->getRouteByName('node.add_page')->getDefault('_controller');
// => \Drupal\gin_type_tray\Controller\GinTypeTrayController::addPage
```

## Controller
`src/Controller/GinTypeTrayController.php` extends
`Drupal\type_tray\Controller\TypeTrayController`. Its `addPage()` calls
`parent::addPage($request)` (so all Type Tray grouping/logic is reused), then loops the
returned `#items` and, for any content type still using Type Tray's default icon path
(`TYPE_TRAY_DEFAULT_ICON_PATH`), swaps `#icon_url` to this module's
`assets/icons/file-text.svg`. Everything else in the build is left untouched.

This is the only behavioral override; the rest of the module is templates and CSS
(see [../theming/overrides.md](../theming/overrides.md)). It defines no new routes, services
you'd call, or plugins.
