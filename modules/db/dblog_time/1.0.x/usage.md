<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Database Logging Time makes core's dblog prune its `watchdog` log by age instead of by row count, so you can keep messages for a fixed retention window (for example "-7 days") rather than a fixed quantity.

---

Core's Database Logging module caps the log by **row limit**: cron keeps the newest N `watchdog` rows and deletes the rest, so on a busy site a day's worth of messages can be gone within hours. `dblog_time` replaces that policy with a **timespan** policy. It adds two fields to the standard logging settings form at `/admin/config/development/logging` (route `system.logging_settings`) — a radio toggle between **Row limit** (core's behaviour, the default) and **Timespan**, a text field for the retention window, and a textarea for per-type overrides — and stores them in `dblog_time.settings` (`limit_type`, `timespan`, `timespan_per_type_override`). The retention window is any string PHP's `strtotime()` accepts, entered relative and negative, e.g. `-7 days`; if the string does not parse, the module silently falls back to core's row-limit cron. Mechanically it implements `hook_module_implements_alter()` to unset dblog's `hook_cron`, then runs its own `hook_cron` via the `dblog_time.manager` service (`DatabaseLoggingTimeManager`), which issues a `DELETE FROM watchdog WHERE timestamp < <cutoff>`. Per-type overrides are one `type|-N unit` line each (e.g. `cron|-2 days`); listed types are deleted at their own cutoff and excluded (`type NOT IN (...)`) from the default delete, so you can keep `user`/login events for a month while pruning `cron` noise after a week. Because pruning is time-based rather than bounded by count, a spike in logging can leave a very large table between cron runs — the module's own README flags this risk. To keep date-range filtering and deletes fast, `hook_schema_alter()` and the install hook add an index named `timestamp` on the `watchdog.timestamp` column (dropped again on uninstall). It depends only on core `dblog`, adds no permissions of its own (the settings form stays behind core's `administer site configuration`, and the log behind `access site reports`), and provides no Drush commands — retention runs entirely on cron.

---

- Keep database log messages for a fixed time window instead of a fixed row count.
- Delete `watchdog` entries older than N days on cron (e.g. `-7 days`, `-30 days`).
- Switch dblog's retention policy from "Row limit" to "Timespan".
- Retain a full audit-style trail for a required period (e.g. 90 days) rather than losing it to the row cap.
- Prevent the row cap from wiping a busy day's logs within hours.
- Set different retention per log type — keep `user` events a month, prune `cron` after a week.
- Configure log retention entirely from the standard `/admin/config/development/logging` form.
- Use any `strtotime()`-compatible expression as the retention window.
- Add an index on `watchdog.timestamp` for faster date-range filtering in the dblog view.
- Speed up date-bounded deletes and reports against a large `watchdog` table.
- Fall back safely to core row-limit behaviour when the timespan string is invalid.
- Keep login/security log entries longer than routine cron or debug noise.
- Enforce a data-retention / compliance window on application logs stored in the database.
- Bound how long personal data lingers in `watchdog` for privacy reasons.
- Reduce log churn without shipping logs to syslog or an external store.
- Store the retention policy in exportable config (`dblog_time.settings`) for deployment.
- Combine a long default window with short per-type windows to control table growth.
- Revert to core behaviour cleanly by uninstalling (the timestamp index is dropped).
- Understand the trade-off: time-based retention risks a large table if logging spikes.
- Trigger retention manually in testing by running cron after setting a timespan.
