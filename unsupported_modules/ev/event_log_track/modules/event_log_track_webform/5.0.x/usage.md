<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Logs webform submission create, update, delete, view, download and clear events.

---

This submodule of Events Log Track logs webform events. `webform_submission_*` and `entity_view` hooks log submission CUD and `view`; a controller subscriber logs `download` and `clear` on the results export/clear routes. Each event is written through the base module's `event_log_track.manager` service into the `event_log_track` table with `type` `webform_submission` and one of the operations [insert, update, delete, view, download, clear]. `ref_numeric` = submission id, `ref_char` = webform id. Enable it with `drush en event_log_track_webform -y`; view the results in the Events Log Track report at `/admin/reports/events-track` (filter Type = webform_submission). Requires the contrib **Webform** module. It registers a handler via `hook_event_log_track_handlers()` so its type/operations appear in the report filters.

---

- Log when a form is submitted.
- Log when a submission is edited.
- Log when a submission is deleted.
- Log when a submission is viewed.
- Log when results are exported/downloaded.
- Log when submissions are cleared/purged.
- Record the `insert` operation on webform in the audit trail.
- Record the `update` operation on webform in the audit trail.
- Record the `delete` operation on webform in the audit trail.
- Record the `view` operation on webform in the audit trail.
- Record the `download` operation on webform in the audit trail.
- Record the `clear` operation on webform in the audit trail.
- Answer "who changed this webform and when" from the event log.
- Filter the Events Log Track report to just `webform_submission` events.
- See the acting user, IP address and timestamp behind every webform change.
- Build a custom View of webform activity on the `event_log_track` base table.
- Also enable the syslog or stdout submodule to forward webform events to external logging.
- Automatically prune old webform logs via the base module's cron-based deletion.
- Exclude noisy webform events with a base-module `skip_patterns` glob on `ref_char`.
- Demonstrate for a compliance audit that webform changes are tracked.
- Correlate a webform change with the acting account via `ref_numeric`/`ref_char`.
- Investigate an unexpected webform deletion after the fact.
- Measure how often each user performs webform operations.
- Retain a searchable history of webform events for incident response.
