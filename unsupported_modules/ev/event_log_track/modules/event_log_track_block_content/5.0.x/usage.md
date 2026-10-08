<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Logs custom (content) block create, update and delete events.

---

This submodule of Events Log Track logs block content events. `block_content_insert` / `_update` / `_delete` entity hooks call `EventLogTrackManager::insert()`. Each event is written through the base module's `event_log_track.manager` service into the `event_log_track` table with `type` `block_content` and one of the operations [insert, update, delete]. `ref_numeric` = block id, `ref_char` = block label; description includes bundle and published status. Enable it with `drush en event_log_track_block_content -y`; view the results in the Events Log Track report at `/admin/reports/events-track` (filter Type = block_content). It registers a handler via `hook_event_log_track_handlers()` so its type/operations appear in the report filters.

---

- Log when a custom block is created.
- Log when a block's body is edited.
- Log when a block is deleted.
- Log when published/unpublished status of a block changes.
- Record the `insert` operation on block content in the audit trail.
- Record the `update` operation on block content in the audit trail.
- Record the `delete` operation on block content in the audit trail.
- Answer "who changed this block content and when" from the event log.
- Filter the Events Log Track report to just `block_content` events.
- See the acting user, IP address and timestamp behind every block content change.
- Build a custom View of block content activity on the `event_log_track` base table.
- Also enable the syslog or stdout submodule to forward block content events to external logging.
- Automatically prune old block content logs via the base module's cron-based deletion.
- Exclude noisy block content events with a base-module `skip_patterns` glob on `ref_char`.
- Demonstrate for a compliance audit that block content changes are tracked.
- Correlate a block content change with the acting account via `ref_numeric`/`ref_char`.
- Investigate an unexpected block content deletion after the fact.
- Measure how often each user performs block content operations.
- Retain a searchable history of block content events for incident response.
