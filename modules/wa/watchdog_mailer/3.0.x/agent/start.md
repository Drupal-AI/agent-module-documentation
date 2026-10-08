<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Watchdog Mailer (watchdog_mailer) — agent index

Registers a **logger backend** (`logger.watchdog_mailer`, tagged `logger`) that receives every
Drupal log entry as it is written and emails the ones matching admin-configured rules
("notification types"). Rules match on log **channel** and **RFC severity** and route to a list of
recipients, using core mail (`hook_mail`) with token-templated subject/body. No external services.

- Core: `^10 || ^11`. No required contrib modules (Token is a dev/optional convenience for the
  token browser in the form).
- Configure route: **`watchdog_mailer.settings`** → `/admin/config/development/watchdog_mailer`,
  gated by the **`administer watchdog_mailer`** permission.
- Defines permissions: yes (1). Drush: no. Plugin types: none (it is a tagged logger service, not a
  plugin manager). Config schema: yes.

## Do X → read this

- **Enable mailing, set recipients, subject/body templates, notification types, rate limit** →
  [configure/settings.md](configure/settings.md)
- **Understand the logger service, the channel/severity match algorithm, mail-limit state, hooks** →
  [api/logger.md](api/logger.md)
- **Who may reach the settings form** → [permissions/permissions.md](permissions/permissions.md)

## Key facts

- Service id: `logger.watchdog_mailer` — class `Drupal\watchdog_mailer\Logger\WatchdogMailer`
  (implements `Psr\Log\LoggerInterface` via `RfcLoggerTrait`), tag `{ name: logger }`.
- Config object: `watchdog_mailer.settings`. Top keys: `enabled`, `recipients_default[]`,
  `mail_subject`, `mail_body`, `mail_limit`, `mail_limit_time_frame`, `limit_mail_subject`,
  `limit_mail_body`, `notification_objects[]` (each: `enabled`, `channels[]`, `channels_negate`,
  `severities[]`, `recipients[]`).
- Token type: `watchdog_mailer` (message, channel, timestamp, referer, request_uri, user, user_ip,
  php_backtrace, php_file, php_line, php_function, php_message, php_type, php_severity_level,
  watchdog_mailer_url) — used inside the mail subject/body templates.
- Rate-limit state keys: `watchdog_mailer.sentMailCount`, `watchdog_mailer.firstMailTimestamp`.
- Mail key: `watchdog_mailer` (`hook_mail`). From address = `system.site` mail.
- Route/form: `watchdog_mailer.settings` → `Drupal\watchdog_mailer\Form\SettingsForm`
  (form id `watchdog_mailer_settings`). Menu link under `system.admin_config_development`.
