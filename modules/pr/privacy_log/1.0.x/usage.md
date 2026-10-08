<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Privacy Log is a data-minimization module for Drupal's logging layer: it strips the client IP from every log entry and reliably time-expires database log rows.

---

Drupal's Logger API records the client IP (`$context['ip']`) with log entries — personal data many sites should not retain. Privacy Log removes it universally by decorating the logger channel factory: `privacy_log.services.yml` overrides the core `logger.factory` with `PrivacyProtectingLoggerChannelFactory`, whose `addLogger()` wraps each registered logger in a `PrivacyProtectingLogger` decorator that forcibly sets `$context['ip'] = ''` before delegating. Because the wrapping happens at the factory's `service_collector` `addLogger` tag, no downstream logger — dblog, syslog, monolog, remote shippers — ever sees the real IP. It blanks the IP entirely rather than hashing it, and applies to all channels and backends.

For retention, `Hook\Form::alterSystemLoggingSettingsForm()` adds a "Database log messages expiry" select to core's `system.logging_settings` form (shown only when dblog is enabled), bound via `#config_target` to `privacy_log.settings:dblog_expiry` (default 168 hours = 1 week; `0` = Never). `Hook\Cron::run()` then deletes `watchdog` rows older than `now - expiry*3600` on each cron run (only if the table exists and expiry > 0), guaranteeing time-based cleanup even on low-traffic sites where core's row-count cap never triggers. Typical setup: enable the module (IP scrubbing is immediate and zero-config), optionally adjust the expiry at Configuration › Development › Logging and errors, and ensure cron runs regularly. It defines no routes or permissions of its own and has no non-core dependencies.

---

- Enable the module to auto-strip client IPs from all log entries.
- Achieve GDPR-friendlier logging with zero configuration after install.
- Blank IPs across every logger channel simultaneously.
- Blank IPs regardless of backend (dblog, syslog, monolog).
- Stop storing visitor IPs in the `watchdog` table.
- Prevent IPs reaching remote log shippers via the decorated factory.
- Adjust "Database log messages expiry" at Logging and errors.
- Set dblog expiry to 1 week (default) for time-based cleanup.
- Set expiry to 1 hour for aggressive log minimization.
- Set expiry to 1/2/3 days as your policy requires.
- Set expiry to "Never" to disable time-based purging.
- Rely on cron to purge old `watchdog` rows automatically.
- Guarantee cleanup on low-traffic sites where row caps never fire.
- Export `privacy_log.settings` (`dblog_expiry`) config across environments.
- Run `drush cron` to force an immediate purge.
- Combine with dblog to keep only recent, IP-free logs.
- Use on sites without dblog (IP scrubbing still applies; expiry UI hidden).
- Verify scrubbing by confirming new watchdog entries have an empty IP.
- Confirm cron deletes rows older than the configured window.
- Retain protection even if custom loggers are added later.
- Meet a data-retention policy by pairing short expiry with regular cron.
- Reduce PII exposure in log-export / monitoring pipelines.
- Keep non-IP log fields fully intact.
- Deploy as a drop-in privacy-hardening module with no dependencies.
