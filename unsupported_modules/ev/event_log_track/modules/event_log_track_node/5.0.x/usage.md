<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Logs node create, update and delete events (and adds a Views relationship to nodes).

---

This submodule of Events Log Track logs node events. `node_insert` / `_update` / `_delete` hooks call the manager; a `views_data` hook adds the `elt_node_join` relationship to `node_field_data`. Each event is written through the base module's `event_log_track.manager` service into the `event_log_track` table with `type` `node` and one of the operations [insert, update, delete]. `ref_numeric` = node id, `ref_char` = node title; description includes content type and published status. Enable it with `drush en event_log_track_node -y`; view the results in the Events Log Track report at `/admin/reports/events-track` (filter Type = node). It registers a handler via `hook_event_log_track_handlers()` so its type/operations appear in the report filters.

---

- Log when content is created.
- Log when content is edited.
- Log when content is deleted.
- Log when content is published or unpublished.
- Log when building a Views audit report joined to nodes.
- Record the `insert` operation on node in the audit trail.
- Record the `update` operation on node in the audit trail.
- Record the `delete` operation on node in the audit trail.
- Answer "who changed this node and when" from the event log.
- Filter the Events Log Track report to just `node` events.
- See the acting user, IP address and timestamp behind every node change.
- Build a custom View of node activity on the `event_log_track` base table.
- Also enable the syslog or stdout submodule to forward node events to external logging.
- Automatically prune old node logs via the base module's cron-based deletion.
- Exclude noisy node events with a base-module `skip_patterns` glob on `ref_char`.
- Demonstrate for a compliance audit that node changes are tracked.
- Correlate a node change with the acting account via `ref_numeric`/`ref_char`.
- Investigate an unexpected node deletion after the fact.
- Measure how often each user performs node operations.
- Retain a searchable history of node events for incident response.
