Events Log Track (ELT) is a lightweight audit-trail engine: it records who did what and when into a dedicated `event_log_track` database table and shows the result as a filterable report at `admin/reports/events-track`. The base module supplies the table, the logging service, a hook-based "handler" registration system, Views integration, an `event-log` token type, and optional cron-based log pruning; the actual tracking of each subsystem (nodes, users, config, media, webform, authentication, …) is switched on by enabling the matching opt-in submodule.

---

When any enabled submodule detects an event (a node insert, a login, a config save, a cache clear, a masquerade, …) it builds a small `$log` array — `type`, `operation`, `description`, and optional `ref_numeric`/`ref_char` references — and passes it to `EventLogTrackManager::insert()` (`event_log_track.manager`). `insert()` fills in the actor uid, client IP, request path and timestamp, applies the configured skip patterns, lets other modules mutate the entry via `hook_event_log_track_alter()`, fans it out to alternative backends via `hook_event_log_track_log_alternative()` (the syslog and stdout submodules), and — unless `disable_db_logs` is set — writes a row to `event_log_track`. Each submodule also declares its event type and operation labels through `hook_event_log_track_handlers()`, which drives the *Type*/*Operation* exposed filters on the bundled Views report. Viewing the log requires the `access event log track` permission; the settings form (`event_log_track.settings_form`, gated by `administer site configuration`) controls retention (`enable_log_deletion`, `timespan_limit`, `batch_size`), CLI logging (`log_cli`), DB-vs-external logging (`disable_db_logs`), and `skip_patterns`. Custom subsystems are tracked by implementing the handler hook and calling the service — no plugin class required.

---

- Keep a full audit trail of content create/update/delete actions per user.
- See which editor unpublished or deleted a given node, and when.
- Track user account creation, role changes, and blocking/deletion.
- Record successful and failed login attempts, logouts, and password-reset requests.
- Audit two-factor (TFA) logins separately from password logins.
- Log configuration changes with a before/after diff of the changed keys.
- Record who cleared the site cache.
- Track taxonomy vocabulary and term CUD operations.
- Audit media, file, and custom-block content changes.
- Log menu and menu-link changes made through the admin UI.
- Track comment create/update/delete operations.
- Audit webform submission create/update/delete, view, download, and clear operations.
- Log Group and Group membership (role) changes for the Group module.
- Record content-moderation workflow state transitions.
- Log masquerade / unmasquerade impersonation sessions.
- Filter the report by event type, operation, user, IP, date range, or reference.
- Prune old log rows automatically on cron after a configurable retention window.
- Ship audit events to syslog/watchdog for centralized SIEM ingestion.
- Ship audit events to stdout/stderr for Docker/Kubernetes log pipelines.
- Log only to an external backend (disable the DB table) for high-volume sites.
- Exclude noisy changes (e.g. `system.*` config) with wildcard skip patterns.
- Include or exclude CLI/Drush-triggered events from the audit trail.
- Build custom Views reports joining the log to the referenced entity.
- Extend tracking to a custom entity or subsystem via `hook_event_log_track_handlers()`.
- Demonstrate compliance by exporting the event report for a user or date range.
- Detect unusual activity such as repeated unauthorized (403) access attempts.
