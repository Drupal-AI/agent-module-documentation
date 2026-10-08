<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Extended Logger renders every Drupal log record as a single-line JSON object and writes it to a target you choose — stdout/stderr for containers, a file, syslog, or the database — with control over exactly which fields are included and the ability to attach free-form metadata.

---

It registers a PSR-3 logger service (`extended_logger.logger`, tagged `logger`) that receives a copy of every log record alongside core dblog/syslog. Each record becomes an `ExtendedLoggerEntry` whose data array is `json_encode()`d to one line, so what you emit is structured and consistently keyed for tools like Grafana Loki, Elasticsearch, or a platform's stdout collector. You select fields from a predefined set (time, level, channel, message, ip, uid, request_uri, referer, exception, backtrace, metadata, and more) or add custom context keys, and can strip empty values, cap line length (with `adhocore/json-fixer` re-closing truncated JSON), and cap backtrace depth. Messages support Drupal placeholders plus nested-array and JSONPath (`{$.a.b}`) placeholders via `softcreatr/jsonpath`; the `extended_logger_fallback` submodule extends that placeholder support to all core loggers. A pre-persist `ExtendedLoggerLogEvent` lets subscribers enrich, redact, or drop entries, and an OpenTelemetry span, if present, contributes a `trace_id`. The `extended_logger_db` submodule adds a database target with an indexed `extended_logger_logs` table, a Views-based browser at `/admin/reports/extended-logs`, a per-entry detail page, and cron-driven cleanup by age or row count. All configuration lives in `extended_logger.settings` and is edited at `/admin/config/development/extended-logger`. Requirements are PHP 8.0+ and core `^9.4 || ^10 || ^11`; the current release is 1.3.0-beta2.

---

- Write Drupal logs to stdout/stderr as JSON in a container.
- Emit structured logs for Grafana Loki, Elasticsearch, or Datadog.
- Send logs to a syslog daemon with a per-site identity and facility.
- Store logs in the database and browse them in a Views table.
- Pick exactly which fields appear in each log entry.
- Add free-form metadata (timings, IDs, context) to a log record.
- Include a request id / trace id on every entry.
- Auto-add an OpenTelemetry `trace_id` when tracing is enabled.
- Reduce dblog database load by logging to stdout instead.
- Log full exception details as a structured object.
- Cap backtrace depth so traces stay readable.
- Truncate over-long JSON lines safely for Docker/syslog limits.
- Use JSONPath placeholders in a log message.
- Bring JSONPath placeholders to all core loggers (fallback submodule).
- Enrich or redact entries from a custom event subscriber.
- Drop specific log entries before they are written.
- Standardise the log format across multiple services.
- Set a `service.name` to identify the log source.
- Exclude empty fields from each entry.
- Auto-clean database logs older than a chosen age.
- Keep only the newest N database log rows.
- Log to a file with a Drupal stream wrapper path.
- Disable internal persistence and let another module handle logs.
- Correlate Drupal logs with platform/observability data.
- View a single log entry's full field set on an admin page.
