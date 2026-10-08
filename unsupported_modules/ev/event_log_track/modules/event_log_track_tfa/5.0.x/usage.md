<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Logs successful two-factor-authentication logins.

---

This submodule of Events Log Track logs tfa events. A form-submit callback on the `tfa_entry_form` logs a `TFA login` with the current user's session count. Each event is written through the base module's `event_log_track.manager` service into the `event_log_track` table with `type` `authentication_tfa` and one of the operations [TFA login]. `ref_numeric` = uid, `ref_char` = username; description carries the session count. Enable it with `drush en event_log_track_tfa -y`; view the results in the Events Log Track report at `/admin/reports/events-track` (filter Type = authentication_tfa). Requires the contrib **TFA** module and the Events Log Track – User Authentication submodule. It registers a handler via `hook_event_log_track_handlers()` so its type/operations appear in the report filters.

---

- Log when a user completes 2FA login.
- Log when auditing two-factor sign-ins.
- Record the `TFA login` operation on tfa in the audit trail.
- Answer "who changed this tfa and when" from the event log.
- Filter the Events Log Track report to just `authentication_tfa` events.
- See the acting user, IP address and timestamp behind every tfa change.
- Build a custom View of tfa activity on the `event_log_track` base table.
- Also enable the syslog or stdout submodule to forward tfa events to external logging.
- Automatically prune old tfa logs via the base module's cron-based deletion.
- Exclude noisy tfa events with a base-module `skip_patterns` glob on `ref_char`.
- Demonstrate for a compliance audit that tfa changes are tracked.
- Correlate a tfa change with the acting account via `ref_numeric`/`ref_char`.
- Investigate an unexpected tfa deletion after the fact.
- Measure how often each user performs tfa operations.
- Retain a searchable history of tfa events for incident response.
