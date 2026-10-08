<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Autoban Dblog overrides Drupal's **Recent log messages** report (`/admin/reports/dblog`) so that log rows gain quick **"ban this IP"** actions wired to Autoban's ban providers, letting an administrator ban offending IPs straight from the log.

---

This glue submodule contains no config, permissions, or Drush. Its single mechanism is a
route subscriber: `Drupal\autoban_dblog\Routing\RouteSubscriber` (an `event_subscriber`
service) reacts to `RoutingEvents::ALTER` (priority `-176`) and, if the `dblog.overview` route
exists, swaps its `_controller` to
`Drupal\autoban_dblog\Controller\AutobanDbLogController::overview`. That controller extends core
`Drupal\dblog\Controller\DbLogController` and is constructed with the `autoban` service
(`AutobanController`) in addition to core's dependencies, so the rebuilt Recent log messages
table can offer Autoban ban actions for the IPs it lists. It depends only on `autoban`. When the
submodule is disabled the route reverts to whatever previously served it (core's
`DbLogController`, or a dblog View if one is installed); when enabled, `dblog.overview` is served
by `AutobanDbLogController`.

---

- Ban an offending IP directly from the Recent log messages report without visiting the Autoban UI.
- Turn the core dblog report into a triage screen for banning scanners and abusive clients.
- Add per-row Autoban ban actions to `/admin/reports/dblog`.
- Let admins react to a spike of 404/403 log entries by banning the source IP in one click.
- Use Autoban's configured providers (e.g. core Ban) to execute bans launched from the log page.
- Speed up manual moderation of suspicious log activity.
- Keep the familiar core log report layout while adding banning shortcuts (controller subclasses DbLogController).
- Provide a route override example: swapping a core controller via a RouteSubscriber at ALTER priority -176.
- Ban IPs seen in authentication-failure or access-denied log messages on the spot.
- Combine with Autoban rules so both automated and manual banning share the same providers.
- Enable log-driven banning on sites that prefer manual review over automatic rules.
- Give security staff a one-page workflow: read the log, ban the IP.
- Extend the core dblog controller without patching core.
- Surface ban links only where the dblog.overview route is present (guarded by the subscriber).
- Serve the dblog overview through Autoban so ban context is available inline.
- Support incident response by banning from the same screen where the incident is observed.
- Let editors escalate a noisy IP without knowing Autoban rule syntax.
- Provide a lightweight, config-free integration that activates purely by being enabled.
