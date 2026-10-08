# OpenTelemetry Syslog — agent index

Submodule of `opentelemetry`. Makes the current OpenTelemetry trace id available as a `!trace_id`
token inside core Syslog's log-line format, so a raw syslog line can be correlated with the
distributed trace it belongs to. Depends on core `syslog` + parent `opentelemetry`. No settings form
of its own — info.yml declares `configure: opentelemetry_syslog.settings`, but that route is not
defined anywhere, so the "Configure" link is dead; you configure the format on core's Logging
settings page instead. No permissions, config schema, plugins, drush commands, or services.

- **Add/keep `!trace_id` in the syslog format, and how the token is seeded and substituted at runtime**
  → [configure/trace-id.md](configure/trace-id.md)

Parent module docs:
- `opentelemetry` (index) → [../../../../1.0.x/agent/start.md](../../../../1.0.x/agent/start.md)
- `opentelemetry` service, incl. `getTraceId()` →
  [../../../../1.0.x/agent/api/service.md](../../../../1.0.x/agent/api/service.md)

Key facts:
- Service provider `Drupal\opentelemetry_syslog\OpentelemetrySyslogServiceProvider::alter()` swaps the
  class of core service `logger.syslog` → `Drupal\opentelemetry_syslog\Logger\OpenTelemetrySysLog`.
- `OpenTelemetrySysLog::syslogWrapper()` replaces the `!trace_id` placeholder with
  `\Drupal::service('opentelemetry')->getTraceId()` just before each line is written to syslog.
- `hook_install` seeds `syslog.settings:format` to
  `!base_url|!timestamp|!type|!ip|!request_uri|!referer|!uid|!link|!message|!trace_id`.
- `hook_form_system_logging_settings_alter` prints help text documenting `!trace_id` on
  `/admin/config/development/logging`.
- Config object touched: core `syslog.settings` (key `format`). The module defines no config of its own.
