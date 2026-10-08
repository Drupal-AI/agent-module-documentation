<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Events Log Track records create/update/delete (and other) events performed by users into a dedicated `event_log_track` database table, viewable as an admin report, with a family of submodules that each add logging for one entity type or subsystem (node, user, taxonomy, media, config, files, menus, workflows, webforms, and more).

---

The base module provides the storage, the report, the settings form, and the logging API; it logs almost nothing on its own — you enable the submodule(s) for the things you want tracked. Each logged row (table `event_log_track`) carries `type` (the handler, e.g. `node`), `operation` (e.g. `insert`), a human `description`, `ref_numeric`/`ref_char` references to the affected object, plus `uid`, `ip`, `path`, and `created`. Logging goes through `EventLogTrackManager::insert()` (service `event_log_track.manager`), which fills in defaults (time, current user, IP, path), applies **skip patterns**, strips tags, fires `hook_event_log_track_alter()` and `hook_event_log_track_log_alternative()` (used by the syslog/stdout submodules), and writes to the DB unless `disable_db_logs` is set. Submodules register a **handler** via `hook_event_log_track_handlers()` (a `type` with a `title` and an `operations` list) — used to populate the report's Type/Operation filters — and then call `insert()` from entity hooks, event subscribers, or form-submit callbacks. The admin report is a View at `/admin/reports/events-track`; settings live at `/admin/config/system/events-log-track` (route `event_log_track.settings_form`, permission `administer site configuration`) and include `enable_log_deletion`, `timespan_limit`, `batch_size`, `disable_db_logs`, `log_cli` (CLI/Drush events are ignored unless this is on), and `skip_patterns`. When `enable_log_deletion` is on, `hook_cron()` batch-deletes rows older than `timespan_limit` days. The report page is gated by the `access event log track` permission.

---

- Keep an audit trail of who created, edited, or deleted content on the site.
- Track configuration changes (which config object changed, and the field-level diff) with the config submodule.
- Log user account create/update/delete events, including role changes, for compliance.
- Record login, logout, password-reset requests, and failed-login attempts (auth submodule).
- Log 403 unauthorized-access attempts across the site.
- Track taxonomy vocabulary and term CUD operations.
- Track media, file, block content, menu, and comment changes each via their submodule.
- Log content-moderation workflow state transitions (workflows submodule).
- Record webform submission create/update/delete/view/download/clear actions.
- Log masquerade start/stop actions to see when admins impersonate users.
- Ship every logged event to syslog or stdout/stderr for external SIEM ingestion (syslog/stdout submodules).
- Disable database logging and rely purely on syslog when running in containers (`disable_db_logs`).
- Automatically prune logs older than N days via cron (`enable_log_deletion` + `timespan_limit`).
- Tune the deletion batch size for large log tables (`batch_size`).
- Include events triggered from Drush/CLI by enabling `log_cli`.
- Exclude noisy events by ref_char using wildcard skip patterns (e.g. `system.*`).
- View, filter (by type/operation/user), and sort the audit log in the admin report.
- Build custom Views on the `event_log_track` base table, joining to users, nodes, or media.
- Add logging for a custom entity/event by implementing `hook_event_log_track_handlers()` and calling the manager.
- Manually record an application event from custom code via `event_log_track.manager`->insert().
- Alter or enrich every log entry centrally with `hook_event_log_track_alter()`.
- Route logs to a bespoke backend with `hook_event_log_track_log_alternative()`.
- Track how many times each user performs CUD operations for activity reporting.
- Provide a session-count trail on login/logout for security monitoring.
- Track two-factor-authentication logins with the TFA submodule.
