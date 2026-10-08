<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Notification channels

Alerts are delivered through `@NotificationChannel` plugins managed by `plugin.manager.log_alert_notification_channel` (`NotificationChannelManager`). A `notification_target` config entity selects and configures a channel.

## Built-in
- **Email** — `Drupal\log_alert_rules\Notification\Plugin\EmailNotification` (base module).

## Webhook submodule (`log_alert_rules_webhook`, depends on `key`)
- `WebhookNotificationBase` — POSTs a JSON payload to a URL; `post()` uses `http_client->request('POST', $url, ['json' => ..., 'timeout' => 5, 'http_errors' => FALSE])`, retries with a bounded attempt count (honours `Retry-After` on 429), and TLS verification is left at Guzzle defaults (no `verify => false`).
- `SlackNotification` — Slack incoming-webhook channel.
- `WebhookUrlKeyType` — a Key module KeyType so the destination URL is stored as a **Key entity**, not plaintext config. Enable the `key` module and create a webhook key, then reference it from the target.

## Monolog submodule (`log_alert_rules_monolog`, depends on `monolog`)
`MonologChannelHandlerPass` / `LogAlertRulesMonologServiceProvider` route Monolog records into the same alerting engine on sites using the Monolog contrib module.

## Add your own channel
Create a `@NotificationChannel`-attributed plugin implementing `NotificationChannelInterface`; it is discovered automatically by the channel plugin manager and becomes selectable on a notification target.
