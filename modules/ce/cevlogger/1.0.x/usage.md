<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Custom Event Logger provides a detached logging mechanism independent of core dblog: your code calls a service and the message is written to a dedicated `cevlogger_logs` table.

The `cevlogger.logger` service exposes `log(string $module_name, string $type, string $message): void`. Only messages you explicitly send are stored — the module does not subscribe to Drupal's watchdog/logger channels, so it stays lightweight and is useful on production sites where dblog is disabled for performance or policy reasons. Entries carry a source module name, a log type/level (`error`, `warning`, `info`, …), the message body and a Unix timestamp, with indexes on module name, timestamp and type.

Logged entries are shown at `/admin/reports/cevlogger` (50 per page, newest first), gated by `administer site configuration`. The schema is created on install and dropped on uninstall. Inject `@cevlogger.logger` into your own services, or call `\Drupal::service('cevlogger.logger')->log(...)` from hooks.
---
Call the logger service from custom code to record business events, then review them in the admin report.
---
- Log an API error response from a custom integration
- Record a failed external service call for later review
- Capture application-specific events without enabling dblog
- Log a warning from inside an entity presave hook
- Categorize entries by source module name
- Tag entries with a severity/type (error/warning/info)
- View recent log entries at `/admin/reports/cevlogger`
- Page through historical entries (50 per page)
- Inject the logger service into a custom service class
- Log from a `.module` hook via the static container
- Quick-test logging with `drush php:eval`
- Keep custom logs isolated from core watchdog noise
- Run `drush updb` after install to create the log table
- Drop the log table cleanly by uninstalling the module
- Restrict log viewing to site administrators
- Index queries by module, timestamp or type for fast lookups