Error Log registers the PHP error log (`error_log()`) as a Drupal PSR-3 logger, so Drupal log messages reappear in the same web-server error log, stderr, or syslog they went to before Drupal bootstrapped.

---

The module adds one tagged logger service (`logger.error_log`, class `Drupal\error_log\Logger\ErrorLog`) that implements `LoggerInterface` via core's `RfcLoggerTrait`. On every log event it consults `error_log.settings`: it drops the message unless the event's severity is enabled in `log_levels` (eight booleans, emergency→debug, all on by default), drops it if the event's channel is in `ignored_channels`, and — under Drush, where the console already logs — drops it unless the PHP `error_log` ini directive is set. Surviving messages are formatted with a configurable `format` string of `!`-placeholders (`!level`, `!type`, `!ip`, `!uid`, `!request_uri`, `!referer`, `!message`, `!base_url`, `!link`, `!severity`, `!timestamp`) and written with PHP's `error_log()`. There is no dedicated settings page: the module alters core's Logging and errors form (`system.logging_settings`, `admin/config/development/logging`, permission `administer site configuration`) to add a "Error Log" section for the levels, ignored channels, and format. It provides config schema but no permissions, routes, Drush commands, or plugins. Because core also calls `error_log()` for some fatal errors, a few messages may appear twice.

---

- Send Drupal log entries to Apache/nginx's error log so they sit beside PHP warnings.
- Capture Drupal logs on the CLI via stderr when PHP `error_log` is configured.
- Forward Drupal logs to syslog by pointing PHP's `error_log` directive at syslog.
- Replace or supplement Database Logging (dblog) with file/stream-based logging.
- Keep a persistent error trail even when the database is unavailable.
- Ship Drupal logs to an external log aggregator that tails the PHP error log.
- Toggle exactly which severities (emergency through debug) reach the error log.
- Silence debug/info noise in production while keeping warnings and errors.
- Suppress 404 spam by adding the `page not found` channel to ignored channels.
- Suppress 403 noise by ignoring the `access denied` channel.
- Ignore a chatty custom module's channel without disabling all logging.
- Include the client IP (`!ip`) in each line for abuse investigation.
- Include the requesting user id (`!uid`) to attribute events.
- Include the request URI (`!request_uri`) and referer (`!referer`) for context.
- Prefix lines with severity level (`!level`/`!severity`) for downstream filtering.
- Add the site base URL (`!base_url`) so multi-site logs are distinguishable.
- Customize the whole log line format to match an existing log-parsing pipeline.
- Avoid duplicate CLI logging by relying on the Drush console log by default.
- Provide a lightweight logger with no external service dependency.
- Combine with dblog/syslog core modules since multiple loggers can run at once.
