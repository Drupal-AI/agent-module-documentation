JSON Log registers a PSR-3 logger service that writes every Drupal log (watchdog) event, at or above a configurable severity, as one JSON object per line — to a timestamped file or to STDOUT — for ingestion by log pipelines like ELK/Logstash.

---

The module tags a logger service (`logger.jsonlog`, class `JsonLog`) with `{ name: logger }`, so it
receives all `LoggerInterface` events alongside core's dblog. `JsonLog::log()` drops events below the
configured severity threshold or outside a channel whitelist, then builds a `JsonLogData` value object and
serializes it (`Json::encode`). Output goes either to STDOUT (`php://stdout`, handy for Docker/containers)
or appended to a file `{dir}/{site_id}[.{date}].json.log` using `file_put_contents(..., FILE_APPEND |
LOCK_EX)` (write-locked to avoid garbled concurrent writes). Each JSON entry carries `@timestamp`
(millisecond ISO-8601), `@version`, `message`, a unique `message_id`, `site_id`, `canonical`, `tags`,
`type`/`subtype` (log channel), `severity`, `method`, `request_uri`, `referer`, `uid`, `client_ip`,
`link`/`code`, and truncation info. `JsonLogData::setMessage()` resolves placeholders, strips tags if the
message begins with `<`, escapes null bytes, and truncates to the configured Kb size (multibyte-safe).
Configuration is injected into core's **Logging and errors** form (`system.logging_settings`, the module's
`configure` route) via `hook_form_FORM_ID_alter` — settings persist in `jsonlog.settings`. A distinctive
feature: **every setting can be overridden by a `drupal_<setting>` environment variable** (e.g.
`drupal_jsonlog_dir`), which wins over config and disables the corresponding form field; tags from env and
config are combined. Defaults: severity threshold 4 (warning), truncate 64 Kb, daily file rotation
(`Ymd`), site id derived from hostname + database name, log dir derived from PHP's `error_log` path +
`/drupal-jsonlog`. The settings form can write a test entry to verify the configuration. No permissions or
Drush commands are added; access is core's `administer site configuration`.

---

- Emit structured JSON logs for ingestion by ELK / Logstash / Graylog / Loki.
- Send Drupal logs to container STDOUT so Docker/Kubernetes collects them.
- Write one JSON log line per event to a rotating file for shipping to a SIEM.
- Keep only warning-and-above events out of the logs by raising the severity threshold.
- Capture all severities (down to debug/notice) by lowering the threshold.
- Restrict logging to specific channels (e.g. `php`, `cron`, a custom module) via the channels whitelist.
- Add a stable `site_id` so logs from multiple environments are distinguishable.
- Add a `canonical` name to group logs from load-balanced instances of the same site.
- Tag every entry (e.g. `prod`, `web01`) for downstream filtering.
- Rotate log files daily, weekly, monthly, or use one file forever.
- Truncate long messages to a Kb budget to keep entries within a filesystem block (avoids garbled lines).
- Override any setting per environment with a `drupal_<setting>` environment variable (12-factor style).
- Set the log directory explicitly when the default `error_log`-derived path isn't writable.
- Correlate entries with request context: `request_uri`, `method`, `referer`, `client_ip`, `uid`.
- Get a unique `message_id` per entry for deduplication/tracing.
- Prepend (legacy) instead of append a newline per entry for older pipelines.
- Send a test log entry from the settings form to confirm the file path/permissions work.
- Run JSON logging alongside core dblog (it does not replace the database log).
- Provide millisecond-precision `@timestamp` values for accurate ordering.
- Feed `client_ip` / `uid` fields into security monitoring dashboards.
