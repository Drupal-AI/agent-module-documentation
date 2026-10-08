<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
**Syslog Watcher** gives you a dblog-style *Recent log messages* screen for sites that log to [Syslog](https://www.drupal.org/docs/8/core/modules/syslog) instead of the database. It reads the configured syslog file, parses each line per the Syslog format string, and renders a paginated table with per-line detail pages — recovering the admin log UI you lose when core dblog is off.

---

Two routes, both requiring the core permission `access site reports`: `syslog_watcher.overview` (`/admin/reports/syslog-watcher`) and `syslog_watcher.line` (`/admin/reports/syslog-watcher/line/{line_number}`). `SyslogWatcherController` reads the file path from `syslog_watcher.settings:syslog_file_path`, opens it with `SplFileObject`, seeks to the end to count lines, then pages through them (via `PagerHelper` / a `SyslogWatcherPagerForm`) formatting each with the `LineFormatter` service and parsing with `LineParser` (splits on the configured `separator`, keyed by `syslog.settings:format`, with `Xss::filterAdmin`+`strip_tags` fallback for malformed lines). The detail page shows the raw line. Services: `syslog_watcher.line_formatter`, `syslog_watcher.line_parser`, `syslog_watcher.pager_helper`, `syslog_watcher.pager_form`. Configuration reuses core's `system.logging_settings`. Depends on `drupal:syslog`. **Access note:** both routes are correctly gated by `access site reports` (a restricted admin permission), so the log contents are not exposed to anonymous users — the `accessCheck` is present and appropriate.

---

- Browse Syslog-logged events in an admin table when dblog is disabled.
- Page through a large syslog file without a shell.
- View full details of a single log line, including the raw entry.
- Parse syslog lines into Type / Timestamp / Message / User columns.
- Point the viewer at a custom syslog file path in settings.
- Keep an in-Drupal log UI on production where only Syslog is enabled.
- Read the log file safely with admin-only access.
- Truncate long messages in the list, expand on the detail page.
- Match the parser to the site's Syslog format string.
- Configure the field separator used to split log lines.
- Triage recent errors from the reports menu.
- Restrict log viewing to users with *access site reports*.
- Reuse core logging settings rather than a separate config screen.
- Handle malformed lines gracefully with an admin-filtered fallback.
- Audit user actions recorded in syslog from the back office.
- Support both list and single-line inspection workflows.
- Complement server-side log tooling with an in-app view.
