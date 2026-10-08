<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mattermost logger (mattermost_logger) — agent index

Forwards Drupal log messages to a **Mattermost channel** via Mattermost **incoming webhooks**,
filtered per logging channel and per severity. Package `Logging`. Core `^10 || ^11`.
License GPL-2.0-or-later. Version 1.0.1 (doc dir `1.x`). **No dependencies** outside core.

- **Settings form, config object/keys, the two services, and manual API usage** →
  [config/settings.md](config/settings.md)

## What it actually is

- Two services (`mattermost_logger.services.yml`):
  - **`mattermost_logger`** (class `Drupal\mattermost_logger\MattermostLogger`, `public: true`) —
    the sender. Args `@http_client`, `@config.factory`, `@logger.log_message_parser`. Has
    `sendMessage($channel, $message, $level, $context = [], $optional = [])` plus PSR-style
    shorthands `error()/warning()/alert()/notice()/info()/debug()/emergency()/critical()`.
  - **`mattermost_logger.auto_logger`** (class `…\Logger\MattermostAutoLogger`, tagged **`logger`**)
    — a `Psr\Log\LoggerInterface` (uses `RfcLoggerTrait`) that core's logger factory calls for
    **every** logged message. Its `log()` decides whether to forward, then delegates to the sender.
- One route/form/permission — no entities, no plugin types, no Drush, no hooks, no config schema,
  no default config shipped.

## Mechanism (from source)

- `MattermostAutoLogger::log($level, $message, $context)` translates the RFC 5424 `$level` to a
  PSR-3 string via `LEVEL_TRANSLATION`, reads `$context['channel']` (default `'none'`), and looks
  up a matching entry in config `channel_webhooks`. If no channel entry matches, or the current
  level is not in that entry's enabled `level` set, it **returns without sending**. If the entry's
  `use_default_webhook_url` is empty it calls `setWebhookUrl($entry['webhook_url'])` first, then
  `MattermostLogger::sendMessage(...)`.
- `MattermostLogger::sendMessage()` substitutes message placeholders with
  `LogMessageParserInterface::parseMessagePlaceholders()` + `strtr()`, picks an emoji and hex
  `color` by level, builds `text = "$emoji [$channel] **$LEVEL:** \n$message"`, and **POSTs** a
  JSON `attachments` payload (with `mrkdwn_in => ['text']` and any `$optional` extras merged in) to
  the webhook URL using Guzzle `$this->httpClient->post($url, ['json' => $payload])`. If no webhook
  URL is set it logs an error instead; HTTP exceptions are caught and logged.
- Constructors read `webhook_url` and `channel_webhooks` from config `mattermost_logger.settings`.

## Config, route, permission

- Config object **`mattermost_logger.settings`**: `webhook_url` (string, the default webhook) and
  `channel_webhooks` (list of `{channel, webhook_url, use_default_webhook_url, level[]}`).
  **No `config/install` or `config/schema` ships** — the object is created on first save.
- Route **`mattermost_logger.settings`** → `/admin/config/services/mattermost-logger/settings`
  (form `\Drupal\mattermost_logger\Form\SettingsForm`), menu link under
  *Configuration → Web services* (`system.admin_config_services`).
- Permission **`edit mattermost logger settings`** (in `mattermost_logger.permissions.yml`) gates
  the form.

See [config/settings.md](config/settings.md) for the form fields, the `channel_webhooks` shape, a
config example, and the manual-notification API (including custom attachments).
