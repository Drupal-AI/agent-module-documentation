<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Overriding the dblog overview (route + controller)

Two classes, no config:

## Route subscriber

`Drupal\autoban_dblog\Routing\RouteSubscriber` (registered as an `event_subscriber` in
`autoban_dblog.services.yml`) subscribes to `RoutingEvents::ALTER` with priority `-176`:

```php
public function alterRoutes(RouteCollection $collection) {
  if ($route = $collection->get('dblog.overview')) {
    $route->setDefault('_controller',
      '\Drupal\autoban_dblog\Controller\AutobanDbLogController::overview');
  }
}
```

So whenever the `dblog.overview` route is present, its controller is replaced.

## Controller

`Drupal\autoban_dblog\Controller\AutobanDbLogController extends
\Drupal\dblog\Controller\DbLogController`. Its `create()` injects core's dependencies
(`database`, `module_handler`, `date_formatter`, `form_builder`) **plus** the `autoban`
service (`Drupal\autoban\Controller\AutobanController`). `overview()` renders the same Recent
log messages table as core but augmented with Autoban ban actions for the listed IPs.

## Observing / verifying it

```bash
drush php:eval 'print \Drupal::service("router.route_provider")
  ->getRouteByName("dblog.overview")->getDefault("_controller");'
# enabled  => \Drupal\autoban_dblog\Controller\AutobanDbLogController::overview
# disabled => core Drupal\dblog\Controller\DbLogController::overview (or a Views controller
#             if a dblog View serves /admin/reports/dblog on this site)
```

There is nothing to configure — enabling the submodule activates the override; disabling it
removes it. To customize further, subclass `AutobanDbLogController` and point the route at your
class in your own RouteSubscriber (use a priority lower than -176 to win).
