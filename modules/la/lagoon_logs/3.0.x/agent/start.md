<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Lagoon Logs — agent index

Ships Drupal log messages over **UDP** to a Lagoon/Logstash endpoint as Logstash JSON, via Monolog.
Near zero-config. No permissions of its own, no Drush, no plugin types. Requires `monolog/monolog`.

- **Settings (`lagoon_logs.settings`: host / port / identifier / disable) + env vars** →
  [configure/settings.md](configure/settings.md)
- **The logger service, Monolog pipeline, and disable behavior** → [api/logger.md](api/logger.md)

Key facts:
- Config `lagoon_logs.settings`: `host` (default `application-logs.lagoon.svc`), `port` (default `5140`),
  `identifier` (default `drupal`), `disable` (default `0`).
- Configure route `lagoon_logs.settings` → `/admin/config/development/lagoon_logs`
  (permission: core `administer site configuration`). The form only toggles `disable` + shows the rest read-only.
- Logger service `logger.lagoon_logs`, tagged `logger`, factory `LagoonLogsLoggerFactory::create`.
- Per-record system name = `LAGOON_PROJECT` + `-` + `LAGOON_GIT_SAFE_BRANCH` env vars
  (fallbacks `project_unset` / `safe_branch_unset`). If `disable` is truthy, nothing is sent.
