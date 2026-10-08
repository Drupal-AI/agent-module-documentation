<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Logs user account create, update and delete events, including role changes.

---

This submodule of Events Log Track logs user events. `user_insert` / `_update` / `_delete` hooks call the manager; the update description records original vs new roles and blocked/active status. Each event is written through the base module's `event_log_track.manager` service into the `event_log_track` table with `type` `user` and one of the operations [insert, update, delete]. `ref_numeric` = uid, `ref_char` = username. Enable it with `drush en event_log_track_user -y`; view the results in the Events Log Track report at `/admin/reports/events-track` (filter Type = user). It registers a handler via `hook_event_log_track_handlers()` so its type/operations appear in the report filters.

---

- Log when a user account is created.
- Log when a user's roles change.
- Log when a user is blocked or unblocked.
- Log when a user account is deleted.
- Log when auditing account administration.
- Record the `insert` operation on user in the audit trail.
- Record the `update` operation on user in the audit trail.
- Record the `delete` operation on user in the audit trail.
- Answer "who changed this user and when" from the event log.
- Filter the Events Log Track report to just `user` events.
- See the acting user, IP address and timestamp behind every user change.
- Build a custom View of user activity on the `event_log_track` base table.
- Also enable the syslog or stdout submodule to forward user events to external logging.
- Automatically prune old user logs via the base module's cron-based deletion.
- Exclude noisy user events with a base-module `skip_patterns` glob on `ref_char`.
- Demonstrate for a compliance audit that user changes are tracked.
- Correlate a user change with the acting account via `ref_numeric`/`ref_char`.
- Investigate an unexpected user deletion after the fact.
- Measure how often each user performs user operations.
- Retain a searchable history of user events for incident response.
