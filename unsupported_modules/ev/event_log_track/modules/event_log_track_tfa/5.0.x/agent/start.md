<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Events Log Track – User authentication (TFA) — agent index

Logs successful two-factor-authentication logins. Submodule of **Events Log Track** (see the parent at `modules/event_log_track/5.0.x/` for the logging API, table schema, settings and report).

> Requires the contrib **TFA** module and the Events Log Track – User Authentication submodule.

## Handler(s) registered

| type | operations |
|---|---|
| `authentication_tfa` | TFA login |

## How it logs

A form-submit callback on the `tfa_entry_form` logs a `TFA login` with the current user's session count.

Each row goes into the `event_log_track` table via `event_log_track.manager`->`insert()`. `ref_numeric` = uid, `ref_char` = username; description carries the session count.

## Enable & view

```bash
drush en event_log_track_tfa -y
```
View at `/admin/reports/events-track` (filter Type = authentication_tfa), or query directly:

```bash
drush sqlq "SELECT operation, ref_char, description, uid, created FROM event_log_track WHERE type='authentication_tfa' ORDER BY created DESC LIMIT 20"
```

Reminder: events triggered under Drush/CLI are only logged if the base setting `log_cli` is TRUE.
