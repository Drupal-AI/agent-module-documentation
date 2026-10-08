<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Events Log Track – User Authentication — agent index

Logs user authentication events (login, logout, password-reset request, failed login) and 403 access-denied events. Submodule of **Events Log Track** (see the parent at `modules/event_log_track/5.0.x/` for the logging API, table schema, settings and report).

## Handler(s) registered

| type | operations |
|---|---|
| `authentication` | login, logout, request password, fail |
| `authorization` | fail |

## How it logs

`user_login` / `user_logout` hooks log `login`/`logout`; a `user_login_form` validate handler logs `fail`; the `user_pass` form-submit callback logs `request password`; and a kernel TERMINATE subscriber logs `authorization`/`fail` on any 403 response.

Each row goes into the `event_log_track` table via `event_log_track.manager`->`insert()`. `ref_numeric` = uid, `ref_char` = username. The login/logout descriptions include a live session count.

## Enable & view

```bash
drush en event_log_track_auth -y
```
View at `/admin/reports/events-track` (filter Type = authentication), or query directly:

```bash
drush sqlq "SELECT operation, ref_char, description, uid, created FROM event_log_track WHERE type='authentication' ORDER BY created DESC LIMIT 20"
```

Reminder: events triggered under Drush/CLI are only logged if the base setting `log_cli` is TRUE.
