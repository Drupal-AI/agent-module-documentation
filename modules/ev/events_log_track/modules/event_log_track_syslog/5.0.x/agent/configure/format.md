# Configure the syslog format & output type

Config object: **`event_log_track_syslog.settings`** (schema `format` string, `output_type`
string). There is no dedicated route — the fields are injected into the **core Syslog settings
form** at `/admin/config/development/logging` (`system_logging_settings`) by
`EventLogTrackSyslogHooks::formSystemLoggingSettingsAlter()`, which adds:

- **Events Log Track format** — a textarea (required) holding a `token->replace()` template.
- A **token tree** (`event-log` + global types) when `token` is enabled.
- **Events Log Track Output type** — select of `watchdog` (default) / `syslog` (raw).
- A disabled **Example output** preview rendered from a sample event.

Its custom submit (`loggingSettingsSubmit`) saves `format` and `output_type` (only if `token`
is enabled).

| Key | Default | Meaning |
| --- | --- | --- |
| `format` | `ELT [[event-log:type]] [[event-log:ref_char]] [[event-log:operation]] ON [[event-log:path]] BY [user:[event-log:user:uid]:[event-log:user:name]:[event-log:user:roles:join:,]] [[event-log:description]]` | Token template for the log line. |
| `output_type` | `watchdog` | `watchdog` = log on the `events_log_track` logger channel (uses Drupal's syslog/dblog handlers); `syslog` = write the rendered line directly with `syslog()`. |

Runtime (`EventLog::logEvent()`): builds an `entry` from the `$log`, sets severity
(`RfcLogLevel::WARNING` for operation `fail`, else `NOTICE`), and `token->replace()`s the
format. If the configured format is empty or missing the required `[event-log:type]`,
`[event-log:user:uid]`, or `[event-log:description]` placeholders, it falls back to the default
format. For `output_type = syslog` it calls `openlog()` (using core `syslog.settings`
identity/facility) then `syslog()`; otherwise it logs to the `events_log_track` channel.

Set via drush / PHP:

```bash
drush cset event_log_track_syslog.settings output_type syslog -y
```

```php
\Drupal::configFactory()->getEditable('event_log_track_syslog.settings')
  ->set('format', 'ELT [[event-log:type]] [[event-log:operation]] [[event-log:description]]')
  ->set('output_type', 'watchdog')
  ->save();
```

To emit **only** to syslog (no DB rows), also set the parent `event_log_track.settings`
`disable_db_logs` to true (see the parent configure doc).
