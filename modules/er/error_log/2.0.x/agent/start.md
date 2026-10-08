# Error Log — agent index

Registers PHP's `error_log()` as a Drupal PSR-3 logger (service `logger.error_log`), so Drupal
log messages go to the web-server error log / stderr / syslog. No dedicated config page — it
extends core's Logging and errors form. No permissions, routes, Drush, or plugins of its own.

- **Settings keys, the log format placeholders, level/channel filtering, and where they're edited** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Config object `error_log.settings`: `log_levels` (8 booleans emergency→debug, all TRUE), `ignored_channels` (list), `format` (string).
- Configured at `admin/config/development/logging` (route `system.logging_settings`, perm `administer site configuration`) — the module adds a fieldset there via `hook_form_system_logging_settings_alter`.
- Logger drops events whose severity is off, whose channel is ignored, or (under Drush) when the PHP `error_log` ini directive is empty.
