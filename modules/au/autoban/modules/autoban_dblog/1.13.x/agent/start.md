<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Autoban Dblog (autoban_dblog) — agent index

Autoban submodule that overrides the core **Recent log messages** report
(`dblog.overview`, `/admin/reports/dblog`) so log rows gain Autoban "ban this IP" actions.
Depends on `autoban`. No config, settings, permissions, Drush, or config schema.

- **How the override works (RouteSubscriber + AutobanDbLogController)** →
  [extend/dblog-override.md](extend/dblog-override.md)

Key facts:
- `Drupal\autoban_dblog\Routing\RouteSubscriber` (event_subscriber) alters routes at
  `RoutingEvents::ALTER` priority `-176`, setting `dblog.overview`'s `_controller` to
  `\Drupal\autoban_dblog\Controller\AutobanDbLogController::overview`.
- `AutobanDbLogController extends \Drupal\dblog\Controller\DbLogController` and also receives
  the `autoban` service to add ban actions.
- Enabled ⇒ `dblog.overview` served by `AutobanDbLogController`; disabled ⇒ reverts to the
  previous controller (core `DbLogController`, or a dblog View if one exists on the site).
