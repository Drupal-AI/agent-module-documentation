<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Events Log Track – Stdout — agent index

Re-emits every logged event to stdout/stderr (or watchdog) using a token-based format. Output backend submodule of **Events Log Track** — it registers no handler and tracks no entity; it re-emits every event that the base module logs.

> Requires the contrib **Log Stdout** module (and Token). It adds fields to the Log Stdout config form.

## How it works

Implements `hook_event_log_track_log_alternative()` to pass each prepared log to `EventLogStdout`, which renders it with the configured token `format` and writes to `php://stdout` (or `php://stderr` for warnings) when `output_type` is `stdout`, otherwise to watchdog.

## Config: `event_log_track_stdout.settings`

| key | meaning |
|---|---|
| `format` | Token string (token type `event-log`) used to render each event, e.g. `[event-log:type] [event-log:operation] [event-log:description]`. |
| `output_type` | `watchdog` (default) — log via Drupal's logger using `format`; `stdout` — write the rendered `format` directly to stdout. |

The fields are injected into the log_stdout config form. Set via drush:

```bash
drush config:set event_log_track_stdout.settings output_type stdout -y
drush config:set event_log_track_stdout.settings format '[event-log:type] [event-log:operation] [event-log:description]' -y
```

Tip: pair with the base setting `disable_db_logs` (on the parent's settings form) to send events only to stdout.
