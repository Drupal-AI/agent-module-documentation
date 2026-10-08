<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Watchdog Mailer

- Route: `watchdog_mailer.settings` → `/admin/config/development/watchdog_mailer`
- Form: `Drupal\watchdog_mailer\Form\SettingsForm` (form id `watchdog_mailer_settings`, extends `ConfigFormBase`)
- Permission: `administer watchdog_mailer`
- Config object: `watchdog_mailer.settings`
- Menu link: under `system.admin_config_development` (Configuration → Development)

## Config keys (`watchdog_mailer.settings`)

| Key | Schema type | Default | Meaning |
|-----|-------------|---------|---------|
| `enabled` | boolean | `TRUE` | Master switch. When false the logger does nothing. |
| `recipients_default` | sequence of email | `{}` | Addresses that receive mail for **every** matching entry, in addition to a notification type's own recipients. |
| `mail_subject` | label (max 512) | see below | Subject template. Tokens allowed. |
| `mail_body` | text | see below | Body template. Tokens allowed. |
| `mail_limit` | integer | `0` | Max mails per time frame; `0` disables rate limiting. |
| `mail_limit_time_frame` | integer | `3600` | Rate-limit window in seconds. |
| `limit_mail_subject` | label | see below | Subject of the one-shot "limit reached" notice. |
| `limit_mail_body` | text | see below | Body of the "limit reached" notice (extra limit/resume-time text is appended automatically). |
| `notification_objects` | sequence of mapping | one disabled starter object | The matching rules ("Notification Types"); see below. |

Default `mail_subject`:
`[Watchdog Mailer ([watchdog_mailer:channel])] "[watchdog_mailer:message]" at [site:name] ([site:url])`

Default `mail_body` (abridged) references `[watchdog_mailer:message]`, `[watchdog_mailer:php_backtrace]`,
`[watchdog_mailer:request_uri]`, `[watchdog_mailer:channel]`, `[watchdog_mailer:user:display-name]`,
`[watchdog_mailer:user]`, `[watchdog_mailer:user_ip]`, `[watchdog_mailer:timestamp:medium]`,
`[watchdog_mailer:referer]`, `[watchdog_mailer:watchdog_mailer_url]`.

## Notification objects (rules)

`notification_objects` is an ordered list. Each object is a mapping:

| Field | Type | Effect |
|-------|------|--------|
| `enabled` | boolean | Object is evaluated only when true. |
| `channels` | sequence of string | Log channels to match (one per line in the UI). Empty = all channels. |
| `channels_negate` | boolean | When true, `channels` becomes an **exclude** list (match all channels except those). |
| `severities` | sequence of integer | RFC 5424 levels to match (see table). Empty = all severities. |
| `recipients` | sequence of email | Extra recipients for this rule, merged with `recipients_default`. |

An entry is mailed when its channel and severity both pass at least one enabled object, and the merged
recipient list is non-empty. See [../api/logger.md](../api/logger.md) for the exact algorithm.

RFC severity integers (from `RfcLogLevel::getLevels()`), as stored in `severities`:

| Int | Level | Int | Level |
|-----|-------|-----|-------|
| 0 | Emergency | 4 | Warning |
| 1 | Alert | 5 | Notice |
| 2 | Critical | 6 | Info |
| 3 | Error | 7 | Debug |

In the form, severity checkbox keys are UI-prefixed with `rfc` (e.g. `rfc3`) because Drupal FAPI
`#options` cannot use a `"0"` key; the form strips the prefix and stores plain integers. The channels
field autocompletes from a built-in list (`access denied, content, cron, form, locale, php, system,
user`) plus, if a module named `watchdog` is enabled, the `DISTINCT` `type` values in the `{watchdog}`
table.

## Tokens for the templates (token type `watchdog_mailer`)

Available in `mail_subject`, `mail_body`, `limit_mail_subject`, `limit_mail_body`. Empty tokens are
cleared (`['clear' => TRUE]`). The Token contrib module is optional — only its in-form token browser
needs it; the tokens themselves work with core.

| Token | Notes |
|-------|-------|
| `[watchdog_mailer:message]` | The log message with placeholders replaced. |
| `[watchdog_mailer:channel]` | Log channel/type. |
| `[watchdog_mailer:timestamp]` | Date token (chain e.g. `:medium`). |
| `[watchdog_mailer:referer]` | Request referer. |
| `[watchdog_mailer:request_uri]` | Request URI (Location). |
| `[watchdog_mailer:link]` | Log entry link. |
| `[watchdog_mailer:user]` | UID; chainable as a `user` token (e.g. `:display-name`). |
| `[watchdog_mailer:user_ip]` | Client IP (Hostname). |
| `[watchdog_mailer:php_backtrace]` | PHP backtrace — PHP channel only. |
| `[watchdog_mailer:php_file]` / `:php_line` / `:php_function` | PHP location — PHP channel only. |
| `[watchdog_mailer:php_message]` / `:php_type` / `:php_severity_level` | PHP error detail — PHP channel only. |
| `[watchdog_mailer:watchdog_mailer_url]` | Absolute URL of the settings page. |

## Set config without the UI

Recipients and severities are stored as arrays; severities are plain integers.

```php
\Drupal::configFactory()->getEditable('watchdog_mailer.settings')
  ->set('enabled', TRUE)
  ->set('recipients_default', ['ops@example.com'])
  ->set('mail_limit', 50)
  ->set('mail_limit_time_frame', 3600)
  ->set('notification_objects', [
    [
      'enabled' => TRUE,
      'channels' => ['php', 'cron'],
      'channels_negate' => FALSE,
      // Emergency, Alert, Critical, Error:
      'severities' => [0, 1, 2, 3],
      'recipients' => ['oncall@example.com'],
    ],
  ])
  ->save();
```

Drush equivalents: `drush cset watchdog_mailer.settings enabled 1 -y` and
`drush cget watchdog_mailer.settings` to inspect. (The module ships no Drush commands of its own.)

## Notes

- Changing `mail_limit` in the form resets the rate-limit counters (`watchdog_mailer.sentMailCount`
  and `watchdog_mailer.firstMailTimestamp` in State) to `0`.
- Recipient fields are validated with `email.validator`; a comma-separated list is accepted and split.
- The "Remove" checkbox on a notification type deletes it on save; "Add Notification Type" appends a
  new disabled object.
