<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mattermost logger — settings, services & manual API

Source: `src/Form/SettingsForm.php`, `src/Logger/MattermostAutoLogger.php`,
`src/MattermostLogger.php`, `mattermost_logger.services.yml`,
`mattermost_logger.routing.yml`, `mattermost_logger.permissions.yml`.

## Install / enable

- `composer require drupal/mattermost_logger` then `drush en mattermost_logger`. No other modules
  required. On a Mattermost server, create an **incoming webhook** and copy its URL.

## Configuration (form + config object)

- Route `mattermost_logger.settings` → **`/admin/config/services/mattermost-logger/settings`**,
  permission **`edit mattermost logger settings`**, menu link *Configuration → Web services*.
- The form (`SettingsForm extends ConfigFormBase`, editable config `mattermost_logger.settings`)
  has:
  - **`webhook_url`** — `#type => 'url'`, the *default* Mattermost webhook URL.
  - **`channel_webhooks`** — an AJAX-managed fieldset. *Add channel webhook* / *Remove* buttons
    (`addWebhook()`/`removeWebhook()`/`ajaxRefresh()`) add or drop rows in `$form_state`. Each row:
    - `channel` (textfield, required) — the Drupal **logging channel name** to match
      (`$context['channel']`, e.g. `php`, `cron`, `system`, or a module machine name).
    - `webhook_url` (url) — a per-channel webhook; hidden/disabled when *Use default* is checked
      (`#states`).
    - `use_default_webhook_url` (checkbox) — when set, `submitForm()` `unset()`s this row's
      `webhook_url` so the default is used.
    - `level` (checkboxes) — the PSR-3 severities to forward for this channel: `emergency`,
      `alert`, `critical`, `error`, `warning`, `notice`, `info`, `debug`.
  - `submitForm()` filters empty `level` values (`array_filter`), re-indexes the rows
    (`array_values`), and saves `webhook_url` + `channel_webhooks` to config.

### Config object `mattermost_logger.settings`

No `config/install` default and **no `config/schema`** ship (schema-less config; it is created on
first save). Shape:

```yaml
webhook_url: 'https://mattermost.example.com/hooks/xxxxxxxxxxxxxxxxxxxxxxxxxx'
channel_webhooks:
  - channel: 'php'
    use_default_webhook_url: true
    level:
      error: error
      emergency: emergency
  - channel: 'my_module'
    webhook_url: 'https://mattermost.example.com/hooks/yyyyyyyyyyyyyyyyyyyyyyyyyy'
    use_default_webhook_url: false
    level:
      warning: warning
```

(Enabled `level` entries are stored as `value: value` pairs, matching the core checkboxes format.)

## How forwarding is decided (`MattermostAutoLogger::log()`)

1. The service is tagged `logger`, so core's `LoggerChannelFactory` calls `log()` for **every**
   message on **every** channel.
2. `$level` (RFC 5424 int) → PSR-3 string via `LEVEL_TRANSLATION`.
3. `$channel = $context['channel'] ?? 'none'`.
4. Find the `channel_webhooks` entry whose `channel` equals `$channel`; if none → **return**.
5. If the current PSR level is not in that entry's `level` set → **return**.
6. If `use_default_webhook_url` is empty, call `MattermostLogger::setWebhookUrl($entry['webhook_url'])`.
7. Call `MattermostLogger::sendMessage($channel, $message, $level, $context)`.

So nothing is forwarded until an admin adds a channel row **and** ticks at least one level; only the
named channels/levels are sent.

## Sending (`MattermostLogger::sendMessage()`)

- Signature: `sendMessage(string $channel, string $message, string $level, array $context = [],
  array $optional = [])`.
- If no webhook URL is configured, it logs an error to the `mattermost_logger` channel and returns.
- Placeholders in `$message` are resolved from `$context` via
  `LogMessageParserInterface::parseMessagePlaceholders()` + `strtr()`.
- Emoji + hex color by level: error/emergency → `:x:` / `#FF0000`, alert → `:bellhop_bell:` /
  `#FFA500`, warning → `:warning:` / `#FFFF00`, else → `:information_source:` / `#3E76FF`.
- Builds `text = "$emoji [$channel] **$LEVEL:** \n$message"` and POSTs a single Mattermost
  attachment: `{attachments: [{text, color, mrkdwn_in: ['text'], ...$optional}]}` via
  `$this->httpClient->post($this->webhookUrl, ['json' => $payload])` (Guzzle). HTTP exceptions are
  caught and logged, not rethrown.

## Manual API (the `mattermost_logger` service)

The `mattermost_logger` service (`public: true`) can be called directly, independent of the log
forwarding:

```php
// Shorthand — level implied by the method:
\Drupal::service('mattermost_logger')->error('my_module', 'My error message');

// Full control, including a rich Mattermost attachment via $optional:
\Drupal::service('mattermost_logger')->sendMessage(
  'my_module',
  'Import finished',
  'INFO',
  optional: [
    'title' => 'Nightly import',
    'fields' => [
      ['short' => TRUE, 'title' => 'Rows', 'value' => '1234'],
    ],
  ],
);
```

Shorthands: `error()`, `warning()`, `alert()`, `notice()`, `info()`, `debug()`, `emergency()`,
`critical()` — each takes `($channel, $message)` and delegates to `sendMessage()`. The `$optional`
array is merged into the attachment object, so it supports Mattermost message-attachment keys
(`fallback`, `color`, `pretext`, `text`, `author_name`, `title`, `title_link`, `fields`,
`image_url`, …). Note a manual call sends to whatever `webhook_url` is currently set (the default,
or a URL set earlier via `setWebhookUrl()`); it does not consult `channel_webhooks` level filters.

## Notes

- The webhook POST uses Guzzle's default client (TLS verification on); no custom `verify` option.
- No config schema is provided, so `drush config:inspect`-style schema checks will report the
  object as untyped.
