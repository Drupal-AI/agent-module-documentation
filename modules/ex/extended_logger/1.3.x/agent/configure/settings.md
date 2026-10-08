# Configure Extended Logger

Settings form `Drupal\extended_logger\Form\SettingsForm` (form id `extended_logger_settings`)
at route `extended_logger.settings` → `/admin/config/development/extended-logger`. It edits the
single config object **`extended_logger.settings`** (schema `config/schema/extended_logger.schema.yml`).

Route access requires permission `administer extended_logger configuration`. NOTE: the module
ships **no** `extended_logger.permissions.yml`, so nothing defines that permission — it cannot be
granted to a role, so in practice only user 1 (super-admin) can open the settings pages unless
another module or `user.role.*` config defines/grants it.

## Config keys

| Key | Type | Default (install) | Meaning |
|---|---|---|---|
| `fields` | string[] | see below | Which fields to include in each JSON entry. |
| `fields_all` | bool | `false` | Add *every* key from the log `$context` array to the entry (ignores the `fields` allowlist). |
| `entry_exclude_empty` | bool | `true` | Drop keys whose value is `null`/`''`/`[]` (numeric `0` is kept). |
| `service_name` | string | `drupal` | Value emitted for the `service.name` field. |
| `target` | string | `file` | Where to write: `output`, `file`, `syslog`, `database`, `none`. |
| `target_output_stream` | string | `stderr` | For `target: output` — `stderr` (recommended) or `stdout`. |
| `target_file_path` | string | `temporary://drupal-log.jsonl` | For `target: file` — absolute/relative path or any Drupal stream wrapper (`public://`, `private://`, `temporary://`). |
| `target_syslog_identity` | string | `drupal` | For `target: syslog` — string prepended to each message (`openlog()` ident). |
| `target_syslog_facility` | int | `128` (`LOG_LOCAL0`) | For `target: syslog` — syslog facility. Form offers `LOG_USER` + `LOG_LOCAL0..7`. |
| `log_line_max_length` | int/null | `null` | Truncate lines longer than this (must be ≥ 255; `<=0` stored as null = unlimited). Truncation re-closes the JSON via `adhocore/json-fixer` and appends `_cut_"`. Applies to `output`/`file`/`syslog` only. |
| `backlog_items_limit` | int/null | `8` | Cap the number of backtrace / exception-trace frames logged (`null` = no cap). |
| `skip_event_dispatch` | bool | `false` | Skip dispatching `ExtendedLoggerLogEvent` (perf win when no subscribers). |

Default install `fields`: `service.name`, `timestamp_float`, `message`, `message_raw`,
`base_url`, `request_time_float`, `channel`, `ip`, `request_uri`, `referer`, `severity`, `level`,
`uid`, `link`, `metadata`, `exception`.

## Available field names

Predefined fields (`ExtendedLogger::LOGGER_FIELDS`). Any other string in `fields` is treated as a
custom key read straight from the log `$context` (the form's "Custom fields" textbox is a
comma-separated list merged into `fields`).

| Field | Source |
|---|---|
| `service.name` | the `service_name` config value |
| `time` | `date('c', $context['timestamp'])` |
| `timestamp` / `timestamp_float` | context timestamp / `microtime(TRUE)` |
| `message` / `message_raw` | rendered (placeholders replaced) / raw message text |
| `base_url` | global `$base_url` |
| `request_time` / `request_time_float` | request `REQUEST_TIME` / `REQUEST_TIME_FLOAT` |
| `channel`, `ip`, `request_uri`, `referer`, `uid`, `link` | core log context values |
| `severity` / `level` | numeric 0–7 / RFC string (`error`, `warning`, …) |
| `metadata` | free-form `$context['metadata']` (see api/logging.md) |
| `exception` | `$context['exception']` expanded to `{message,code,file,line,trace,previous}` |
| `backtrace` | `$context['backtrace']` (do not enable together with `exception` — duplicates) |

Also auto-added when present: `trace_id` — set from the current OpenTelemetry span when
`OpenTelemetry\SDK\Trace\Span` exists.

## Set it without the UI

```php
// Log everything to stdout as JSON (container use case).
\Drupal::configFactory()->getEditable('extended_logger.settings')
  ->set('target', 'output')
  ->set('target_output_stream', 'stdout')
  ->set('service_name', 'my-app')
  ->set('fields', ['time', 'level', 'channel', 'message', 'uid', 'metadata', 'exception'])
  ->save();
```

```bash
ddev drush config:set extended_logger.settings target syslog -y
ddev drush config:set extended_logger.settings target_syslog_facility 128 -y
```

## Runtime notes

- The logger is registered with the `logger` service tag, so it receives a copy of **every**
  Drupal log record in addition to core dblog/syslog. To make it the only sink, uninstall
  `dblog`/`syslog`, or use their own settings.
- `target: none` disables this module's own writing — useful when a subscriber or another module
  handles persistence.
- With `target: file` and a stream wrapper URI, the path is resolved via
  `stream_wrapper_manager` → `realpath()`; entries are appended with `FILE_APPEND`.
- Each entry is one line: `json_encode()` of the entry data (newlines inside values are escaped),
  so entries stay one-per-line.
