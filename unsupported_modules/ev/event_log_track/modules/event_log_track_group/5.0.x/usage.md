<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Logs Group entity create, update and delete events.

---

This submodule of Events Log Track logs group events. `group_insert` / `_update` / `_delete` hooks call the manager; the description includes any revision log message. Each event is written through the base module's `event_log_track.manager` service into the `event_log_track` table with `type` `group` and one of the operations [insert, update, delete]. `ref_numeric` = group id, `ref_char` = group label. Enable it with `drush en event_log_track_group -y`; view the results in the Events Log Track report at `/admin/reports/events-track` (filter Type = group). Requires the contrib **Group** module; enable it (and this submodule) to log group events. It registers a handler via `hook_event_log_track_handlers()` so its type/operations appear in the report filters.

---

- Log when a group is created.
- Log when a group is edited.
- Log when a group is deleted.
- Log when auditing group lifecycle.
- Record the `insert` operation on group in the audit trail.
- Record the `update` operation on group in the audit trail.
- Record the `delete` operation on group in the audit trail.
- Answer "who changed this group and when" from the event log.
- Filter the Events Log Track report to just `group` events.
- See the acting user, IP address and timestamp behind every group change.
- Build a custom View of group activity on the `event_log_track` base table.
- Also enable the syslog or stdout submodule to forward group events to external logging.
- Automatically prune old group logs via the base module's cron-based deletion.
- Exclude noisy group events with a base-module `skip_patterns` glob on `ref_char`.
- Demonstrate for a compliance audit that group changes are tracked.
- Correlate a group change with the acting account via `ref_numeric`/`ref_char`.
- Investigate an unexpected group deletion after the fact.
- Measure how often each user performs group operations.
- Retain a searchable history of group events for incident response.
