Monolog integrates the Monolog PHP logging library into Drupal, replacing the core logger factory so log messages can be routed to files, syslog, mail, Slack, stdout and other destinations through handlers, formatters and processors defined in services YAML.

---

The module's `MonologServiceProvider` overrides Drupal's `logger.factory` service with `MonologLoggerChannelFactory`, so every `\Drupal::logger($channel)` call returns a Monolog-backed logger. It has no UI: all configuration lives in a site services file (typically `sites/default/monolog.services.yml`, registered via `$settings['container_yamls']`). The `monolog.channel_handlers` parameter maps each log channel (e.g. `php`, `cron`, or `default`) to one or more handlers; the `default` mapping is the fallback. Handlers are plain Drupal/Symfony services under the `monolog.handler.*` namespace whose class is any Monolog handler (`RotatingFileHandler`, `SyslogHandler`, `StreamHandler`, `SlackHandler`, `ErrorLogHandler`, `NullHandler`, etc.). Formatters (`monolog.formatter.*`, e.g. `line`, `json`, `drush`) and processors (`monolog.processor.*`, e.g. `message_placeholder`, `current_user`, `request_uri`, `ip`, `referer`, `filter_backtrace`, `introspection`) can be attached per handler, per channel, or to the whole logger via `monolog.processors` / `monolog.logger.processors`. Because Monolog replaces core logging, the module auto-registers a `DrupalHandler` wrapper (`monolog.handler.drupal.<name>`) for every service tagged `logger`, so you can still route messages back to Watchdog/dblog by using the `drupal.dblog` handler. It also ships Drupal-aware extras: `DrupalMailHandler` (sends logs via core mail), `ConditionalHandler`/`ConditionalFormatter` with a `cli` condition resolver to switch behavior between web and CLI/Drush, and a `DrushLineFormatter` for clean stdout/stderr output during Drush commands.

---

- Replace Drupal's core logging with Monolog by simply enabling the module.
- Log every message to a daily rotating file in the private filesystem via `RotatingFileHandler`.
- Send the `php` error channel to its own separate log file, apart from other channels.
- Route logs to the operating system's syslog with `SyslogHandler`.
- Write logs to the web server error log with `ErrorLogHandler`.
- Emit structured JSON logs (`monolog.formatter.json`) for ingestion by log aggregators.
- Ship logs to a Slack channel using `SlackHandler`.
- Email critical log records to an address with the Drupal-aware `DrupalMailHandler`.
- Keep logging to the Watchdog/dblog table by adding the `drupal.dblog` handler.
- Route different channels (php, cron, default) to entirely different handlers.
- Send one channel to multiple handlers, each with its own formatter.
- Buffer and only flush logs on error using Monolog's `FingersCrossedHandler`.
- Discard noisy channels by pointing them at the `NullHandler`.
- Print logs to stdout/stderr for container/Kubernetes log collection.
- Use a `ConditionalHandler` to log to stdout for web requests but to Drush for CLI runs.
- Use a `ConditionalFormatter` to pick JSON for web and the Drush line format for CLI.
- Attach the `current_user`, `request_uri`, `ip` and `referer` processors to enrich records.
- Add the `message_placeholder` processor to interpolate Drupal placeholder tokens into messages.
- Strip heavy context (e.g. backtrace) from records with the `filter_backtrace` processor.
- Add call-site file/line/class info with the `introspection` processor.
- Add memory usage, process id, or git branch metadata via Monolog's built-in processors.
- Set per-handler minimum log levels (e.g. only `ERROR` and above to Slack).
- Configure formatters/handlers/processors entirely as services with no admin UI.
- Deploy identical logging configuration across environments by committing the services YAML.
- Add the `debug` processor (from WebProfiler) to the whole logger instance for profiling.
- Define brand-new handlers or processors as custom services and reference them by name.
- Decorate or alter an existing handler/processor service using standard Drupal/Symfony DI.
- Send logs to a GELF/Graylog endpoint via the optionally-registered `gelf` formatter.
- Format Google Cloud Logging output for GCP-hosted sites.
