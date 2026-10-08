# Adding the OpenTelemetry trace id to syslog lines

This submodule has **no settings form of its own**. Its only configuration surface is the core Syslog
**format** string, into which it injects a `!trace_id` placeholder that is expanded, per log line, to
the request's current OpenTelemetry trace id.

## Where to configure

- UI: `/admin/config/development/logging` (route `system.logging_settings`, permission
  `administer logging settings`). Core `syslog` adds the **Syslog format** textarea here; this module
  adds help text (via `hook_form_system_logging_settings_alter`) documenting the extra placeholder:
  `!trace_id` — "A trace id value from OpenTelemetry module."
- info.yml declares `configure: opentelemetry_syslog.settings`, but **no such route exists** in this
  project — the Extend-page "Configure" link is a dead reference. Use the Logging settings page above.

## The config it touches

| Key | Owner | Purpose |
| --- | --- | --- |
| `syslog.settings:format` | core `syslog` | Pipe-joined token template for each syslog line. |

`hook_install()` (`opentelemetry_syslog.install`) rewrites `syslog.settings:format` on enable to:

```
!base_url|!timestamp|!type|!ip|!request_uri|!referer|!uid|!link|!message|!trace_id
```

i.e. the core default plus a trailing `|!trace_id`. Uninstalling does **not** restore the old format;
remove the `!trace_id` token by hand if you no longer want it. If you customise the format, just keep
`!trace_id` somewhere in the string to keep emitting trace ids.

### Set the format via Drush or PHP

```php
// Append (or ensure) the !trace_id token in the syslog format.
\Drupal::configFactory()->getEditable('syslog.settings')
  ->set('format', '!base_url|!timestamp|!type|!ip|!request_uri|!referer|!uid|!link|!message|!trace_id')
  ->save();
```

```bash
# Drush equivalent.
drush config:set syslog.settings format '!base_url|!timestamp|!type|!ip|!request_uri|!referer|!uid|!link|!message|!trace_id' -y
```

There is **no config schema in this submodule**; `syslog.settings` (and its `format` key) is defined
by core `syslog`, so no extra schema is added or needed.

## How `!trace_id` is expanded at runtime

1. `OpentelemetrySyslogServiceProvider::alter()` (a `ServiceProviderBase`) rewrites the class of the
   core `logger.syslog` service definition to `OpenTelemetrySysLog` when that definition exists. No
   new service id is registered — the override is transparent to everything that logs to syslog.
2. `OpenTelemetrySysLog extends \Drupal\syslog\Logger\SysLog`. Core's logger fills every token it
   knows (`!base_url`, `!message`, …) and leaves the unknown `!trace_id` verbatim in the entry, then
   calls the protected `syslogWrapper($level, $entry)`.
3. The override intercepts `syslogWrapper()`, fetches the id, and does
   `strtr($entry, ['!trace_id' => $traceId])` before delegating to `parent::syslogWrapper()` (the real
   `syslog()` write). The id comes from `\Drupal::service('opentelemetry')->getTraceId()` on the
   parent module's service (`OpentelemetryService`), which returns the current root span's trace id
   (32-char hex) or `NULL` when no root span is active yet.

### Caveats baked into the code

- The trace id is fetched with a **static** `\Drupal::service('opentelemetry')` call, not dependency
  injection — deliberate, to avoid a circular service dependency around `logger.syslog`.
- Any exception while resolving the service is **swallowed** (logging must never fail): if the
  `opentelemetry` service is not yet initialised, the line is written with `!trace_id` unexpanded.
- For requests that log **before** `KernelEvents::REQUEST` (e.g. some 404 paths) the root span does
  not exist yet, so `getTraceId()` returns `NULL` and the token expands to an empty string.

## Verify

Trigger any logging to syslog and inspect the destination (e.g. `/var/log/syslog` or `/dev/log`
target). Lines from a traced request end with the 32-hex trace id; you can then look that id up in
Jaeger/Tempo/Grafana to jump from the log line to the full trace waterfall.
