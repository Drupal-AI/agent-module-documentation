<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Logs user authentication events (login, logout, password-reset request, failed login) and 403 access-denied events.

---

This submodule of Events Log Track logs auth events. `user_login` / `user_logout` hooks log `login`/`logout`; a `user_login_form` validate handler logs `fail`; the `user_pass` form-submit callback logs `request password`; and a kernel TERMINATE subscriber logs `authorization`/`fail` on any 403 response. Each event is written through the base module's `event_log_track.manager` service into the `event_log_track` table with `type` `authentication` and one of the operations [login, logout, request password, fail]. `ref_numeric` = uid, `ref_char` = username. The login/logout descriptions include a live session count. Enable it with `drush en event_log_track_auth -y`; view the results in the Events Log Track report at `/admin/reports/events-track` (filter Type = authentication). It registers a handler via `hook_event_log_track_handlers()` so its type/operations appear in the report filters.

---

- Log when logins.
- Log when logouts.
- Log when password-reset requests.
- Log when failed login attempts.
- Log when 403 unauthorized-access attempts.
- Record the `login` operation on auth in the audit trail.
- Record the `logout` operation on auth in the audit trail.
- Record the `request password` operation on auth in the audit trail.
- Record the `fail` operation on auth in the audit trail.
- Answer "who changed this auth and when" from the event log.
- Filter the Events Log Track report to just `authentication` events.
- See the acting user, IP address and timestamp behind every auth change.
- Build a custom View of auth activity on the `event_log_track` base table.
- Also enable the syslog or stdout submodule to forward auth events to external logging.
- Automatically prune old auth logs via the base module's cron-based deletion.
- Exclude noisy auth events with a base-module `skip_patterns` glob on `ref_char`.
- Demonstrate for a compliance audit that auth changes are tracked.
- Correlate a auth change with the acting account via `ref_numeric`/`ref_char`.
- Investigate an unexpected auth deletion after the fact.
- Measure how often each user performs auth operations.
- Retain a searchable history of auth events for incident response.
