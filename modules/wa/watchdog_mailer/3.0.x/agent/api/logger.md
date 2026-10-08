<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The logger backend and runtime behavior

## Service

```yaml
# watchdog_mailer.services.yml
logger.watchdog_mailer:
  class: Drupal\watchdog_mailer\Logger\WatchdogMailer
  arguments: [ '@config.factory', '@language_manager', '@database', '@datetime.time', '@state' ]
  tags:
    - { name: logger }
```

`WatchdogMailer implements Psr\Log\LoggerInterface` and uses `RfcLoggerTrait`, so the `logger` tag
makes Drupal's `LoggerChannelFactory` call its `log($level, $message, array $context)` for **every**
log entry site-wide (there is no polling of dblog; it acts at log time). Integrators do not call this
service directly — they configure it (see [../configure/settings.md](../configure/settings.md)).

The mail manager (`plugin.manager.mail`) and token (`token`) services are **lazy-loaded** via the DI
container inside `mailManager()` / `token()` rather than injected, because the logger is constructed
very early in the request lifecycle and eager injection caused a circular-service-reference /
early-bootstrap fatal (drupal.org issues 3337719 and 3414001).

## `log()` match algorithm

For each incoming entry, if `watchdog_mailer.settings:enabled` is true, it iterates
`notification_objects` and for each one:

1. Skip if the object's `enabled` is false.
2. **Channel filter** — only if the object has `channels`: `channelMatches = in_array($channel, $channels)`.
   Skip when `channelMatches === channels_negate`. So with `channels_negate = FALSE` the channel must
   be in the list; with `TRUE` it must **not** be. Empty `channels` = match any channel.
3. **Severity filter** — if `severities` is non-empty and the entry's RFC `$level` is not in it, skip.
   Empty `severities` = match any level.
4. Build recipients = `array_unique(array_merge(recipients_default, object.recipients))`. If empty,
   nothing is sent for this object.
5. Render `mail_subject` / `mail_body` through the token service (`['clear' => TRUE]`), then
   `Html::decodeEntities(strip_tags(...))` to produce plain text, and send one mail per recipient via
   `plugin.manager.mail->mail('watchdog_mailer', 'watchdog_mailer', $recipient, $langcode, $params)`.

Token values are drawn from the log `$context` (channel, timestamp, referer, request_uri, link, uid,
ip, and the `php`-channel keys `@backtrace_string`, `%file`, `%function`, `%line`, `@message`,
`%type`, `severity_level`), each `Html::escape()`-d before token replacement.

The whole loop is wrapped in try/catch; on failure it calls `$this->error(...)` (never
`watchdog_exception`) to avoid an endless logging loop.

## Rate limiting (frequency capping)

`mailLimitReached()` runs before each send when `mail_limit` > 0. It tracks two **State** values:

- `watchdog_mailer.sentMailCount`
- `watchdog_mailer.firstMailTimestamp`

Within a rolling `mail_limit_time_frame` window: if the window has expired, the counter resets to 1
and the timestamp to now; while `sentMailCount < mail_limit`, the counter increments and the mail is
sent; when `sentMailCount == mail_limit`, a single "limit reached" notice (`limit_mail_subject` /
`limit_mail_body`, plus an auto-appended limit/resume-time line built with `date('r', ...)`) is sent
and further log mails are suppressed until the window rolls over. These State keys are deleted on
uninstall.

## Hooks implemented (`watchdog_mailer.module`)

| Hook | Purpose |
|------|---------|
| `hook_mail` | Defines the `watchdog_mailer` mail key; sets `from` = `system.site` mail, and subject/body from `$params`. |
| `hook_token_info` / `hook_tokens` | Define and resolve the `watchdog_mailer` token type used in the templates. |
| `hook_help` | Renders `README.md` on `help.page.watchdog_mailer` (via the Markdown filter if present). |

## Install-time note

`watchdog_mailer.install` declares a `hook_schema` table `watchdog_mailer_history` (`wmid`, `timestamp`),
a legacy artifact — the current rate-limit feature uses State (above), not this table. `hook_uninstall`
clears the two State keys. Update hooks `watchdog_mailer_update_92000`–`92007` migrate older config
key names (`mail_address`→`mail_addresses`→`recipients_default`, `watchdog_mailer_enable`→`enabled`,
add `channels_negate`, mail-limit keys, and initialize `notification_objects`).
