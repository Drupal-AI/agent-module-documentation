<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Watchdog Search (watchdog_search) — agent index

Overrides Drupal core's **Recent log messages** report (`dblog.overview`, `/admin/reports/dblog`)
with a searchable, multi-filter version of the same database-log page. Package `Search`. Depends
only on core **`dblog`**. Core requirement `^9 || ^10 || ^11`. PHP `8.1`. License GPL-2.0-or-later.
Version 1.x (installed 1.0.0-beta2). No settings form, no permissions, no Drush, no hooks, no
config schema.

- **How the page override, search, filters and modal work** →
  [api/page-override.md](api/page-override.md)

## What it actually is (from source)

- **No routing/permissions YAML.** The module ships no `*.routing.yml` or `*.permissions.yml`.
  It hijacks the *existing* core route instead: `src/Routing/RouteSubscriber.php`
  (`RouteSubscriber::alterRoutes()`) rewrites the `_controller` default of `dblog.overview` to
  `\Drupal\watchdog_search\Controller\DbLogController::buildPage`. The route's access
  requirement (core `access site reports`) is left untouched, so who can reach the page is
  unchanged.
- **Controller** `src/Controller/DbLogController.php` — `DbLogController` *extends* core
  `Drupal\dblog\Controller\DbLogController` and implements `FormInterface` (it is both the page
  controller and the filter form). Services injected via `create()`: `database`, `module_handler`,
  `date.formatter`, `form_builder`, `request_stack`.
- **Config override** `src/ConfigOverride.php` — a `config.factory.override` service
  (`watchdog_search.override`, priority 5) that forces `views.view.watchdog` `status` to `FALSE`,
  disabling the core Views-based log report so this controller's table is what renders.
- **Library** `watchdog_search/watchdog_search` = `css/watchdog_search.css` only (flex layout for
  the filter form). No JS of its own; the modal reuses core `dblog/drupal.dblog` + `use-ajax`.

## Services

| Service id | Class | Tag |
|---|---|---|
| `watchdog_search.override` | `ConfigOverride` | `config.factory.override` (priority 5) |
| `watchdog_search.route_subscriber` | `Routing\RouteSubscriber` | `event_subscriber` |

## Operate it

- Enable: `drush en watchdog_search -y` (pulls in core `dblog`). Nothing else to configure — visit
  `/admin/reports/dblog`.
- The page is gated by the same core permission as the stock report, **`access site reports`**.
  Keep that permission restricted; searching the log exposes whatever the log messages contain.
