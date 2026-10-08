<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Logs configuration changes with a field-level diff of what changed.

---

This submodule of Events Log Track logs config events. A `ConfigCrudEvent` subscriber on `ConfigEvents::SAVE` / `DELETE` logs `save`/`delete`; on save it builds a concise human diff of the changed keys (ignoring dependencies, uuid, _core, langcode, third_party_settings). Each event is written through the base module's `event_log_track.manager` service into the `event_log_track` table with `type` `config` and one of the operations [save, delete]. `ref_char` = the config object name; description is the diff (or 'Config added' / 'Config removed'). Enable it with `drush en event_log_track_config -y`; view the results in the Events Log Track report at `/admin/reports/events-track` (filter Type = config). It registers a handler via `hook_event_log_track_handlers()` so its type/operations appear in the report filters.

---

- Log when a setting is changed on an admin form.
- Log when a view or field config is saved.
- Log when a config object is deleted.
- Log when auditing configuration drift.
- Log when seeing the before/after of a config value.
- Record the `save` operation on config in the audit trail.
- Record the `delete` operation on config in the audit trail.
- Answer "who changed this config and when" from the event log.
- Filter the Events Log Track report to just `config` events.
- See the acting user, IP address and timestamp behind every config change.
- Build a custom View of config activity on the `event_log_track` base table.
- Also enable the syslog or stdout submodule to forward config events to external logging.
- Automatically prune old config logs via the base module's cron-based deletion.
- Exclude noisy config events with a base-module `skip_patterns` glob on `ref_char`.
- Demonstrate for a compliance audit that config changes are tracked.
- Correlate a config change with the acting account via `ref_numeric`/`ref_char`.
- Investigate an unexpected config deletion after the fact.
- Measure how often each user performs config operations.
- Retain a searchable history of config events for incident response.
