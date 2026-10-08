<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Slack — agent index

Sends messages to Slack via an **Incoming Webhook**. Configure the webhook + defaults, then
send from code, from Rules, or via a queue. No own permissions (uses `administer site
configuration`), no Drush, no plugin types.

- **Settings form, config keys, test message form** →
  [configure/settings.md](configure/settings.md)
- **Send messages from code (service + methods) and the Rules action / queue** →
  [api/send.md](api/send.md)

Key facts:
- Config object `slack.settings`: `slack_webhook_url` (required, uri), `slack_channel`,
  `slack_username`, `slack_icon_type` (none|emoji|url), `slack_icon_emoji`, `slack_icon_url`,
  `slack_link_names` (bool), `slack_queue_messages` (bool).
- Settings form route `slack.admin_settings` at `/admin/config/services/slack/config`; test
  form `slack.admin_test` at `/admin/config/services/slack/test` (perm `administer site
  configuration`).
- Service `slack.slack_service` (`Slack` / `SlackInterface`):
  `deliverMessage()` (queues or sends per `slack_queue_messages`), `sendMessage()` (immediate),
  `queueMessage()` (enqueue). All take `($message, $channel='', $username='', $webhook_url=NULL)`.
- Async: QueueWorker id `slack_message` (processed on cron).
- Rules action id `rules_slack_send_message` ("Send message to Slack") — needs `drupal/rules`.
- Nothing is delivered without a `slack_webhook_url`.
