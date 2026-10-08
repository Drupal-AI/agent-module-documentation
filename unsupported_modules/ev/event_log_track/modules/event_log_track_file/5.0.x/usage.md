<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Logs managed file create, update and delete events.

---

This submodule of Events Log Track logs file events. `file_insert` / `_update` / `_delete` hooks call the manager. Each event is written through the base module's `event_log_track.manager` service into the `event_log_track` table with `type` `file` and one of the operations [insert, update, delete]. `ref_numeric` = file id, `ref_char` = filename; description = the file URI. Enable it with `drush en event_log_track_file -y`; view the results in the Events Log Track report at `/admin/reports/events-track` (filter Type = file). It registers a handler via `hook_event_log_track_handlers()` so its type/operations appear in the report filters.

---

- Log when a file is uploaded.
- Log when a managed file is replaced.
- Log when a file is deleted.
- Log when tracking media/file churn.
- Record the `insert` operation on file in the audit trail.
- Record the `update` operation on file in the audit trail.
- Record the `delete` operation on file in the audit trail.
- Answer "who changed this file and when" from the event log.
- Filter the Events Log Track report to just `file` events.
- See the acting user, IP address and timestamp behind every file change.
- Build a custom View of file activity on the `event_log_track` base table.
- Also enable the syslog or stdout submodule to forward file events to external logging.
- Automatically prune old file logs via the base module's cron-based deletion.
- Exclude noisy file events with a base-module `skip_patterns` glob on `ref_char`.
- Demonstrate for a compliance audit that file changes are tracked.
- Correlate a file change with the acting account via `ref_numeric`/`ref_char`.
- Investigate an unexpected file deletion after the fact.
- Measure how often each user performs file operations.
- Retain a searchable history of file events for incident response.
