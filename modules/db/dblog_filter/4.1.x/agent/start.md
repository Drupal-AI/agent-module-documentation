<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DB Log Filter — agent index

Filters which log messages Drupal actually writes, by **severity level** and/or **channel**,
for the database log (`logger.dblog`) and syslog (`logger.syslog`) separately. It does this by
**replacing** those two logger services with filtering subclasses. All behaviour is driven by
one config object; no permissions of its own, no plugins, no Drush.

- **The settings form, config keys (`severity_levels`, `log_values`, `method`, …) and how the
  include/exclude decision is made** → [configure/filtering.md](configure/filtering.md)
- **How the logger services are swapped and the `shouldLog()` algorithm** →
  [extend/logger-override.md](extend/logger-override.md)

Key facts:
- `configure` route: `dblog_filter.settings` at `/admin/reports/dblog-filter` (permission
  `access site reports` — a core permission, not one this module defines).
- Config object: `dblog_filter.settings`. dblog keys: `severity_levels`, `log_values`,
  `log_values_regex`, `method`. syslog keys: `syslog_severity_levels`, `syslog_log_values`,
  `syslog_log_values_regex`, `syslog_method`.
- Default config filters nothing (all levels false, empty lists) ⇒ everything logs.
