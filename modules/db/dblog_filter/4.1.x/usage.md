<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DB Log Filter intercepts Drupal's database-log and syslog loggers so only the messages you allow (by severity level and/or channel) are actually written, cutting log noise and dblog table size.

---

The module swaps the core `logger.dblog` and `logger.syslog` services for its own subclasses (`DBLogFilter extends dblog\DbLog`, `SyslogFilter extends syslog\SysLog`) via a `ServiceProvider`, and each overridden `log()` first calls a shared `shouldLog()` filter before delegating to the parent. Filtering is driven entirely by the `dblog_filter.settings` config, which holds two parallel groups — one for dblog, one for syslog. Each group has: `severity_levels` (a map of the eight RFC levels to booleans), `log_values` (a sequence of `channel|level1,level2` rules), `log_values_regex` (per-rule message regexes keyed by `md5(rule)`), and a `method` of `include` or `exclude`. With `method: exclude` (the default) a matched severity/channel rule means "do **not** log this"; with `method: include` only matched messages are logged. Severity match is evaluated first: if the current message's level is among the checked `severity_levels`, the decision is made immediately (`include` ⇒ log, `exclude` ⇒ drop). Otherwise each `log_values` row is tested against the message's channel + level (and optional regex on the message text). Out of the box every level is unchecked and both `log_values` lists are empty, so nothing is filtered and all messages log as normal. Configure it at `/admin/reports/dblog-filter` (permission "access site reports"). It ships config + schema only — no permissions of its own, no plugins, no Drush.

---

- Stop low-value `info`/`debug` messages from filling the Recent log messages table in production.
- Log only `error` and above by checking those severities with `method: include`.
- Exclude a chatty module's channel (e.g. `cron`) from dblog while keeping everything else.
- Keep the `dblog` table small on a busy site for better `admin/reports/dblog` performance.
- Apply different filtering to database log vs syslog independently.
- Whitelist just `php|error,alert` and `mymodule|notice,warning` so only those log.
- Drop `notice`-level noise from a specific integration module.
- Reduce syslog volume shipped to an external aggregator by pre-filtering at the source.
- Silence a deprecation-warning channel that you cannot fix immediately.
- Regex-match a message body so only matching entries of a channel/level are logged.
- Exclude a known benign warning by channel+level+message pattern.
- Only record security-relevant channels to the database log.
- Cut storage costs where dblog rows are archived off-site.
- Temporarily include only one module's log output while debugging it.
- Prevent a runaway logger from bloating the database during an incident.
- Standardise a minimal production logging policy via exported config.
- Keep `emergency`/`alert`/`critical` always logged while dropping the rest.
- Filter syslog to `error`-and-above while dblog keeps more detail (or vice versa).
- Remove verbose watchdog entries created by batch/queue processes.
- Reduce log-table growth that slows down `drush watchdog:show`.
- Enforce a channel allow-list so third-party modules cannot spam the log.
- Deploy consistent log filtering across environments through configuration management.
- Exclude `page not found`/`access denied` noise by channel and level.
- Log only messages whose text matches a regex (e.g. containing a specific error code).
- Restore full logging instantly by clearing the severities and log_values lists.
