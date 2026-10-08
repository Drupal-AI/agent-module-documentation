<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Re-emits every logged event to syslog (or watchdog) using a token-based format.

---

This submodule does not track any entity itself — it is an output backend for Events Log Track. Implements `hook_event_log_track_log_alternative()` to pass each prepared log to `EventLog`, which renders it with the configured token `format` and calls `syslog()` when `output_type` is `syslog`, otherwise logs to watchdog. It stores two settings in `event_log_track_syslog.settings`: `format` (a token string using the `event-log` token type, e.g. `[event-log:type]`, `[event-log:operation]`, `[event-log:description]`, plus `user:` tokens) and `output_type` (`watchdog` = log via Drupal's logger using that format; `syslog` = write the rendered format directly to syslog). The fields are added to the system logging settings form. Requires core **Syslog** (and Token). It adds fields to the system logging settings form (/admin/config/development/logging). Combine with the base setting `disable_db_logs` to send events only to syslog and not the database.

---

- Forward every Events Log Track event to syslog for external collection.
- Feed an external SIEM or log aggregator from Drupal audit events.
- Run in a container and emit audit logs to syslog instead of a database table.
- Format each event with tokens (`[event-log:type]`, `[event-log:operation]`, `[event-log:description]`).
- Include the acting user and roles via `user:` tokens in the log line.
- Switch between `watchdog` and raw `syslog` output with one setting.
- Set `disable_db_logs` on the base module to stop DB logging and rely on syslog.
- Keep a durable off-site copy of who did what on the site.
- Standardise the audit log line format across events.
- Send warning-level events (failed logins, 403s) with an elevated severity.
- Integrate Drupal audit events into existing syslog-based monitoring.
- Customise the log format per environment via config.
- Preview the rendered output on the settings form before saving.
- Route audit events without writing any custom logging code.
- Ship events to both watchdog and syslog depending on configuration.
- Debug the token format by checking the example output on the form.
