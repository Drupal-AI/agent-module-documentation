Log Stdout registers a Drupal logger that writes every watchdog/Logging API message to `php://stdout` (or `php://stderr` for warnings and errors), so container platforms can collect Drupal logs from the process output stream.

---

The module ships a single tagged logger service (`logger.stdout`, class `Drupal\log_stdout\Logger\Stdout`) that implements the PSR `LoggerInterface` via core's `RfcLoggerTrait`. Because it is tagged `{ name: logger }`, it is added alongside (not instead of) core's Database Logging / Syslog loggers — every logged event is passed to it. For each event it checks the configured minimum severity level and, if the event is important enough, formats a single line from a configurable template and `fwrite()`s it to `php://stdout`, or to `php://stderr` when "use stderr" is on and the level is WARNING or more severe. The line template supports placeholders such as `@severity`, `@type`, `@date`, `@message`, `@uid`, `@request_uri`, `@referer`, `@ip` and `@link`. Configuration lives in `log_stdout.settings` (`format`, `use_stderr`, `severity_level`) and is edited at `/admin/config/development/log_stdout` (route `log_stdout.settings`, permission `administer site configuration`). This is the standard pattern for Docker/Kubernetes/12-factor deployments where logs are expected on the container's stdout/stderr rather than in a database table or file. Note a shipped quirk: the schema file keys the settings object as `syslog.settings` rather than `log_stdout.settings`, so the config is effectively schema-less at runtime, but the module still reads/writes the three keys directly.

---

- Stream Drupal logs to a Docker container's stdout so `docker logs` shows watchdog messages.
- Ship Drupal logs to Kubernetes/Fluentd/Loki by reading the pod's stdout stream.
- Follow 12-factor app logging by treating logs as an event stream on stdout.
- Send warnings and errors to stderr while routing lower-severity info to stdout.
- Replace or supplement the Database Logging (dblog) module in ephemeral containers.
- Set a minimum severity threshold so only errors and above reach the log stream.
- Emit debug-level events to stdout during development by lowering the severity level.
- Customize the log line format to match a downstream log parser's expectations.
- Include the request URI, referer and client IP in each emitted log line.
- Include the acting user's uid in each log line for audit correlation.
- Produce ISO-style timestamps in logs via the `@date` placeholder.
- Feed structured-ish single-line logs into a centralized logging pipeline.
- Avoid disk-based log files on read-only container filesystems.
- Keep logs out of the database to reduce DB write load on high-traffic sites.
- Correlate application logs with platform logs collected from the same stream.
- Route PHP/Drupal notices to the platform log collector without extra syslog config.
- Provide a lightweight alternative to core Syslog for cloud-native hosting.
- Surface cron and queue worker errors on the container console.
- Debug a failing deployment by tailing the container's stdout for Drupal errors.
- Standardize log output across multiple Drupal containers behind a load balancer.
- Tune which channels appear by including `@type` (channel) in the format for grepping.
- Emit emergency/critical events to stderr so orchestrators can alert on them.
- Keep a consistent log schema across environments by version-controlling the format string.
