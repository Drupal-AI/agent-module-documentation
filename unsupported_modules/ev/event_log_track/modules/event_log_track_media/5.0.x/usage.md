<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Logs media entity create, update and delete events (and adds a Views relationship to media).

---

This submodule of Events Log Track logs media events. `media_insert` / `_update` / `_delete` hooks call the manager; a `views_data` hook adds the `elt_media_join` relationship to `media_field_data`. Each event is written through the base module's `event_log_track.manager` service into the `event_log_track` table with `type` `media` and one of the operations [insert, update, delete]. `ref_numeric` = media id, `ref_char` = media label; description includes bundle and revision log. Enable it with `drush en event_log_track_media -y`; view the results in the Events Log Track report at `/admin/reports/events-track` (filter Type = media). It registers a handler via `hook_event_log_track_handlers()` so its type/operations appear in the report filters.

---

- Log when a media item is created.
- Log when a media item is edited.
- Log when a media item is deleted.
- Log when building a Views report joined to media.
- Record the `insert` operation on media in the audit trail.
- Record the `update` operation on media in the audit trail.
- Record the `delete` operation on media in the audit trail.
- Answer "who changed this media and when" from the event log.
- Filter the Events Log Track report to just `media` events.
- See the acting user, IP address and timestamp behind every media change.
- Build a custom View of media activity on the `event_log_track` base table.
- Also enable the syslog or stdout submodule to forward media events to external logging.
- Automatically prune old media logs via the base module's cron-based deletion.
- Exclude noisy media events with a base-module `skip_patterns` glob on `ref_char`.
- Demonstrate for a compliance audit that media changes are tracked.
- Correlate a media change with the acting account via `ref_numeric`/`ref_char`.
- Investigate an unexpected media deletion after the fact.
- Measure how often each user performs media operations.
- Retain a searchable history of media events for incident response.
