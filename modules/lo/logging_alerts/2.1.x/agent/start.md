<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Logging and alerts (logging_alerts) — agent index

Routes Drupal log (watchdog/dblog) messages to alternative sinks based on severity. The `logging_alerts`
project ships **no module at its root** — only two independent submodules, each a logger channel you enable
separately (`drush en logging_alerts` fails; enable `emaillog` and/or `errorlog`):

- **emaillog** — emails log entries, a different address per severity level (the alerting channel).
- **errorlog** — writes selected severities to the web server's error log via PHP `error_log()`.

Core `^10.3 || ^11`. Latest release on this branch is **2.1.0-beta1** (no stable on 2.1.x). emaillog depends
on core `user`; errorlog has no dependencies. Neither defines a permission, drush command, or plugin type;
both admin forms are gated by core **`administer site configuration`**.

- **Configure email alerts (severity→address, debug info, rate limiting, subject)** → [configure/emaillog.md](configure/emaillog.md)
- **Configure error-log routing (which severities)** → [configure/errorlog.md](configure/errorlog.md)
- **How the logger channels intercept messages, the mail alert, theme hooks, the debug-info alter hook** → [api/loggers.md](api/loggers.md)

Key facts:
- Logger services (both tagged `logger`, implement `Psr\Log\LoggerInterface` + core `RfcLoggerTrait`):
  `logger.mylog` → `Drupal\emaillog\Logger\EmailLogger`; `logger.errorlog` → `Drupal\errorlog\Logger\ErrorLogMessageFormatter`.
- Config objects: `emaillog.settings` (keys `emaillog_0`..`emaillog_7` = per-severity email address, plus
  `emaillog_debug_info`, `emaillog_backtrace_replace_args`, `emaillog_max_similar_emails`,
  `emaillog_max_consecutive_timespan`, `emaillog_max_similarity_level`, `emaillog_legacy_subject`) and
  `errorlog.settings` (booleans `errorlog_0`..`errorlog_7`).
- Routes: `emaillog.configuration` → `/admin/config/development/emaillog`; `errorlog.configuration` →
  `/admin/config/development/errorlog`.
- emaillog sends via core mail (`hook_mail` key `alert`, `plugin.manager.mail`); errorlog writes via PHP
  `error_log()`. Theme hooks `emaillog` (`emaillog.html.twig`) and `errorlog_format` (`errorlog-format.html.twig`).
- Only errorlog ships a config schema (`errorlog.schema.yml`); emaillog has none.
- Severities are core `RfcLogLevel` 0-7 (0 Emergency, 1 Alert, 2 Critical, 3 Error, 4 Warning, 5 Notice,
  6 Info, 7 Debug).
