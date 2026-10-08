<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Events Log Track – Syslog — agent index

Re-emits every logged event to syslog (or watchdog) using a token-based format. Output backend submodule of **Events Log Track** — it registers no handler and tracks no entity; it re-emits every event that the base module logs.

> Requires core **Syslog** (and Token). It adds fields to the system logging settings form (/admin/config/development/logging).

## How it works

Implements `hook_event_log_track_log_alternative()` to pass each prepared log to `EventLog`, which renders it with the configured token `format` and calls `syslog()` when `output_type` is `syslog`, otherwise logs to watchdog.

## Config: `event_log_track_syslog.settings`

| key | meaning |
|---|---|
| `format` | Token string (token type `event-log`) used to render each event, e.g. `[event-log:type] [event-log:operation] [event-log:description]`. |
| `output_type` | `watchdog` (default) — log via Drupal's logger using `format`; `syslog` — write the rendered `format` directly to syslog. |

The fields are injected into the system logging settings form. Set via drush:

```bash
drush config:set event_log_track_syslog.settings output_type syslog -y
drush config:set event_log_track_syslog.settings format '[event-log:type] [event-log:operation] [event-log:description]' -y
```

Tip: pair with the base setting `disable_db_logs` (on the parent's settings form) to send events only to syslog.
