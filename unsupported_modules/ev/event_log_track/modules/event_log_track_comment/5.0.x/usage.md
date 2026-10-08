<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Logs comment create, update and delete events.

---

This submodule of Events Log Track logs comment events. `comment_insert` / `_update` / `_delete` hooks call the manager. Each event is written through the base module's `event_log_track.manager` service into the `event_log_track` table with `type` `comment` and one of the operations [insert, update, delete]. `ref_numeric` = comment id, `ref_char` = comment subject; description includes the comment type. Enable it with `drush en event_log_track_comment -y`; view the results in the Events Log Track report at `/admin/reports/events-track` (filter Type = comment). It registers a handler via `hook_event_log_track_handlers()` so its type/operations appear in the report filters.

---

- Log when a comment is posted.
- Log when a comment is edited.
- Log when a comment is deleted.
- Log when moderating comment activity.
- Record the `insert` operation on comment in the audit trail.
- Record the `update` operation on comment in the audit trail.
- Record the `delete` operation on comment in the audit trail.
- Answer "who changed this comment and when" from the event log.
- Filter the Events Log Track report to just `comment` events.
- See the acting user, IP address and timestamp behind every comment change.
- Build a custom View of comment activity on the `event_log_track` base table.
- Also enable the syslog or stdout submodule to forward comment events to external logging.
- Automatically prune old comment logs via the base module's cron-based deletion.
- Exclude noisy comment events with a base-module `skip_patterns` glob on `ref_char`.
- Demonstrate for a compliance audit that comment changes are tracked.
- Correlate a comment change with the acting account via `ref_numeric`/`ref_char`.
- Investigate an unexpected comment deletion after the fact.
- Measure how often each user performs comment operations.
- Retain a searchable history of comment events for incident response.
