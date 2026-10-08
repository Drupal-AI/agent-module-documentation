<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Syslog Watcher (syslog_watcher) — agent index

Admin **report to browse core Syslog** file contents, dblog-style. Version **8.x-1.3**, core `^9 || ^10`. Depends on `drupal:syslog`.

**Shape:** routes `syslog_watcher.overview` (`/admin/reports/syslog-watcher`) + `syslog_watcher.line/{line_number}`, both requiring **`access site reports`**. `SyslogWatcherController` reads `syslog_watcher.settings:syslog_file_path` via `SplFileObject`, pages with `PagerHelper`/`SyslogWatcherPagerForm`, parses via `LineParser` (splits on configured `separator`, keys by `syslog.settings:format`; `Xss::filterAdmin`+`strip_tags` fallback). Services: line_formatter, line_parser, pager_helper, pager_form. Config reuses `system.logging_settings`.

**Access (reviewed):** log routes are properly gated by the restricted `access site reports` permission — no anonymous info disclosure. Sound.
