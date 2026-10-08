Salesforce Logger centralizes logging of Salesforce suite events (errors, warnings, notices) to Drupal's logging system, with a configurable minimum log level and optional logging of push payloads.

---

The module subscribes to the Salesforce suite's log events and writes them to Drupal's logger (watchdog/dblog) at a configurable threshold. Its settings live in `salesforce_logger.settings`: `log_level` (the minimum severity — `salesforce.error` = errors only, `salesforce.warning` = warnings and errors, `salesforce.notice` = all Salesforce events), `log_push_success` (also log successful pushes), and push-parameter logging options `log_push_params` (log the params sent to Salesforce), `log_push_params_maxlength` (truncate them) and `log_push_params_sanitized_fields` (fields to redact). The settings form is at the route `salesforce_logger.settings`. This gives one place to control how noisy Salesforce logging is and whether sensitive push payloads are recorded. It has no permissions, plugins, or Drush of its own.

---

- Log only Salesforce errors in production (default).
- Log warnings and errors while debugging an integration.
- Log every Salesforce event (notice level) during initial setup.
- Also record successful pushes, not just failures.
- Log the exact field values pushed to Salesforce for troubleshooting.
- Truncate logged push params to a maximum length to control log size.
- Redact sensitive fields (e.g. SSN, tokens) from logged push params.
- Consolidate scattered Salesforce logging into one configurable channel.
- Reduce log noise by raising the minimum log level.
- Increase log verbosity temporarily to diagnose a sync problem.
- Feed Salesforce events into dblog/syslog via Drupal's logger.
- Audit what data left Drupal for Salesforce.
- Turn off push-param logging once debugging is done.
- Keep a record of push successes for reconciliation.
- Standardize Salesforce logging across environments via exported config.
- Control logging behavior without code changes.
- Pair with monitoring that reads Drupal logs.
- Decide per environment how much Salesforce detail to capture.
