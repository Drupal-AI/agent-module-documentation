<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Logs content-moderation workflow state changes on nodes (and groups).

---

This submodule of Events Log Track logs workflows events. `node_insert` / `_update` (and `group_insert` / `_update`) hooks log the moderation_state: on insert the initial state, on update the old->new transition (only when it changed). Each event is written through the base module's `event_log_track.manager` service into the `event_log_track` table with `type` `workflows` and one of the operations [insert, update, delete]. `ref_numeric` = entity id, `ref_char` = title/label; description names the workflow state transition. Enable it with `drush en event_log_track_workflows -y`; view the results in the Events Log Track report at `/admin/reports/events-track` (filter Type = workflows). Logs only entities that have a moderation_state field (Content Moderation). It registers a handler via `hook_event_log_track_handlers()` so its type/operations appear in the report filters.

---

- Log when new content is created in a moderation state.
- Log when content is moved from Draft to Published.
- Log when a moderation state transition happens.
- Log when auditing editorial workflow.
- Record the `insert` operation on workflows in the audit trail.
- Record the `update` operation on workflows in the audit trail.
- Record the `delete` operation on workflows in the audit trail.
- Answer "who changed this workflows and when" from the event log.
- Filter the Events Log Track report to just `workflows` events.
- See the acting user, IP address and timestamp behind every workflows change.
- Build a custom View of workflows activity on the `event_log_track` base table.
- Also enable the syslog or stdout submodule to forward workflows events to external logging.
- Automatically prune old workflows logs via the base module's cron-based deletion.
- Exclude noisy workflows events with a base-module `skip_patterns` glob on `ref_char`.
- Demonstrate for a compliance audit that workflows changes are tracked.
- Correlate a workflows change with the acting account via `ref_numeric`/`ref_char`.
- Investigate an unexpected workflows deletion after the fact.
- Measure how often each user performs workflows operations.
- Retain a searchable history of workflows events for incident response.
