<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Logs taxonomy vocabulary and term create, update and delete events.

---

This submodule of Events Log Track logs taxonomy events. `taxonomy_vocabulary_*` and `taxonomy_term_*` hooks log vocabulary and term CUD via the manager. Each event is written through the base module's `event_log_track.manager` service into the `event_log_track` table with `type` `taxonomy` and one of the operations [vocabulary insert, vocabulary update, vocabulary delete, term insert, term update, term delete]. Terms: `ref_numeric` = tid, `ref_char` = vocabulary id. Vocabularies: `ref_char` = vid. Enable it with `drush en event_log_track_taxonomy -y`; view the results in the Events Log Track report at `/admin/reports/events-track` (filter Type = taxonomy). It registers a handler via `hook_event_log_track_handlers()` so its type/operations appear in the report filters.

---

- Log when a vocabulary is created.
- Log when a term is added.
- Log when a term is renamed.
- Log when a term is deleted.
- Log when a vocabulary is removed.
- Record the `vocabulary insert` operation on taxonomy in the audit trail.
- Record the `vocabulary update` operation on taxonomy in the audit trail.
- Record the `vocabulary delete` operation on taxonomy in the audit trail.
- Record the `term insert` operation on taxonomy in the audit trail.
- Record the `term update` operation on taxonomy in the audit trail.
- Record the `term delete` operation on taxonomy in the audit trail.
- Answer "who changed this taxonomy and when" from the event log.
- Filter the Events Log Track report to just `taxonomy` events.
- See the acting user, IP address and timestamp behind every taxonomy change.
- Build a custom View of taxonomy activity on the `event_log_track` base table.
- Also enable the syslog or stdout submodule to forward taxonomy events to external logging.
- Automatically prune old taxonomy logs via the base module's cron-based deletion.
- Exclude noisy taxonomy events with a base-module `skip_patterns` glob on `ref_char`.
- Demonstrate for a compliance audit that taxonomy changes are tracked.
- Correlate a taxonomy change with the acting account via `ref_numeric`/`ref_char`.
- Investigate an unexpected taxonomy deletion after the fact.
- Measure how often each user performs taxonomy operations.
- Retain a searchable history of taxonomy events for incident response.
