# Salesforce Logger — agent index

Centralized logging of Salesforce suite events to Drupal's logger, with a configurable
minimum level and optional push-payload logging. Depends on `salesforce`. Configure route:
`salesforce_logger.settings`.

- **The logging settings (`salesforce_logger.settings`)** →
  [configure/logger.md](configure/logger.md)

Key facts:
- Config `salesforce_logger.settings`:
  - `log_level` — minimum severity: `salesforce.error` (errors only), `salesforce.warning`
    (warnings + errors), `salesforce.notice` (all events).
  - `log_push_success` (bool) — also log successful pushes.
  - `log_push_params` (bool), `log_push_params_maxlength` (int|null),
    `log_push_params_sanitized_fields` (list) — log/redact push payloads.
- No permissions, plugins, or Drush of its own.
