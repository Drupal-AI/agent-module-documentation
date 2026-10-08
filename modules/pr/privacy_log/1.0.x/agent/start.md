<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Privacy Log (privacy_log) — agent index

**Strips client IPs from every Drupal log entry (all channels/backends) and adds time-based expiry of database log rows.**

- **Version:** 1.0.x (1.0.0)
- **Core:** `^10.3 || ^11.0`
- **Dependencies:** none outside core
- **Configure:** reuses core `system.logging_settings`

Key surfaces:
- Service override: `logger.factory` → `PrivacyProtectingLoggerChannelFactory`, wrapping each logger in `PrivacyProtectingLogger` which sets `$context['ip'] = ''`.
- Hook `Form::alterSystemLoggingSettingsForm` — adds "Database log messages expiry" bound to `privacy_log.settings:dblog_expiry` (default 168h, `0` = Never).
- Hook `Cron::run` — deletes `watchdog` rows older than the configured window (parameterized query).
- No routes, no permissions of its own.

**Security:** No findings. No routes, no `_access: TRUE`, no anonymous endpoints, no outbound HTTP, no `unserialize`, no weak tokens, no secrets. The one DB write uses a parameterized `condition('timestamp', $bound, '<')` — no raw SQL. IP blanking is unconditional and universal via the factory override.
