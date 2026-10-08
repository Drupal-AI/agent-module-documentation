# Configure the stdout format & output type

Config object: **`event_log_track_stdout.settings`** (schema `format` string, `output_type`
string). No dedicated route — the fields are injected into the **log_stdout settings form**
(`log_stdout_config_form`, at `/admin/config/development/log_stdout`) by
`EventLogTrackStdoutHooks::formLogStdoutConfigFormAlter()`, which adds an ELT format textarea, a
token tree (`event-log`), an output-type select (`watchdog` / `stdout`), and a disabled example
preview. Its submit (`loggingSettingsSubmit`) saves `format` and `output_type` (only if `token`
is enabled).

| Key | Default | Meaning |
| --- | --- | --- |
| `format` | `ELT [[event-log:type]] [[event-log:ref_char]] [[event-log:operation]] ON [[event-log:path]] BY [user:[event-log:user:uid]:[event-log:user:name]:[event-log:user:roles:join:,]] [[event-log:description]]` | Token template for the log line. |
| `output_type` | `watchdog` | `watchdog` = log on the `events_log_track` logger channel; `stdout` = write the rendered line directly to the PHP output stream. |

Runtime (`EventLogStdout::logEvent()`): builds the entry, sets severity (WARNING for `fail`,
else NOTICE), `token->replace()`s the format, and replaces newlines with `#012`/`#015`. When
`output_type = stdout`, `syslogWrapper()` opens `php://stderr` if `log_stdout.settings.use_stderr`
is `1` **and** the severity is ≤ WARNING, otherwise `php://stdout`, and writes the line; when
`watchdog`, it logs to the `events_log_track` channel. (Unlike the syslog submodule, an empty
format is not backfilled with a default here.)

```bash
drush cset event_log_track_stdout.settings output_type stdout -y
```

```php
\Drupal::configFactory()->getEditable('event_log_track_stdout.settings')
  ->set('format', 'ELT [[event-log:type]] [[event-log:operation]] [[event-log:description]]')
  ->set('output_type', 'stdout')
  ->save();
```

For container log pipelines, set the parent `event_log_track.settings` `disable_db_logs` to true
so events go only to stdout/stderr.
