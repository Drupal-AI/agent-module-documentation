<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Logs when an admin starts and stops masquerading as another user.

---

This submodule of Events Log Track logs masquerade events. A kernel REQUEST subscriber watches the `entity.user.masquerade` and `masquerade.unmasquerade` routes and logs the start/stop, naming the admin and target user. Each event is written through the base module's `event_log_track.manager` service into the `event_log_track` table with `type` `masquerade` and one of the operations [masquerade, unmasquerade]. No entity refs; the description carries the admin and target usernames and uids. Enable it with `drush en event_log_track_masquerade -y`; view the results in the Events Log Track report at `/admin/reports/events-track` (filter Type = masquerade). Requires the contrib **Masquerade** module. It registers a handler via `hook_event_log_track_handlers()` so its type/operations appear in the report filters.

---

- Log when an admin impersonates a user.
- Log when an admin stops impersonating.
- Log when auditing support-staff impersonation.
- Record the `masquerade` operation on masquerade in the audit trail.
- Record the `unmasquerade` operation on masquerade in the audit trail.
- Answer "who changed this masquerade and when" from the event log.
- Filter the Events Log Track report to just `masquerade` events.
- See the acting user, IP address and timestamp behind every masquerade change.
- Build a custom View of masquerade activity on the `event_log_track` base table.
- Also enable the syslog or stdout submodule to forward masquerade events to external logging.
- Automatically prune old masquerade logs via the base module's cron-based deletion.
- Exclude noisy masquerade events with a base-module `skip_patterns` glob on `ref_char`.
- Demonstrate for a compliance audit that masquerade changes are tracked.
- Correlate a masquerade change with the acting account via `ref_numeric`/`ref_char`.
- Investigate an unexpected masquerade deletion after the fact.
- Measure how often each user performs masquerade operations.
- Retain a searchable history of masquerade events for incident response.
