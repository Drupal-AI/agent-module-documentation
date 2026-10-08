<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Slack

## Settings form

Route `slack.admin_settings` → `/admin/config/services/slack/config` (under *Configuration →
Services → Slack*). Permission: `administer site configuration`. Form
`Drupal\slack\Form\SettingsForm` edits config object `slack.settings`.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `slack_webhook_url` | uri | `''` | Incoming Webhook URL from Slack (**required** to send) |
| `slack_channel` | string | `''` | default channel `#name`, or `@user` for a DM/private group |
| `slack_username` | string | `''` | bot display name |
| `slack_icon_type` | string | `none` | `none`, `emoji`, or `url` |
| `slack_icon_emoji` | string | `''` | e.g. `:ghost:` (when icon type = emoji) |
| `slack_icon_url` | uri | `''` | icon image URL (when icon type = url) |
| `slack_link_names` | bool | — | link `@names`/`#channels` in messages |
| `slack_queue_messages` | bool | `false` | send via queue (cron) instead of immediately |

Get the webhook URL from Slack: create an "Incoming WebHooks" app/integration in your Slack
workspace and copy its URL (`https://hooks.slack.com/services/...`).

Read/write:

```bash
drush cget slack.settings
```

```php
\Drupal::configFactory()->getEditable('slack.settings')
  ->set('slack_webhook_url', 'https://hooks.slack.com/services/T00/B00/xxxx')
  ->set('slack_channel', '#general')
  ->set('slack_username', 'Drupal Bot')
  ->set('slack_queue_messages', TRUE)
  ->save();
```

## Test the integration

Route `slack.admin_test` → `/admin/config/services/slack/test`
(`SendTestMessageForm`): enter a message and send it to confirm the webhook, channel and bot
settings work before wiring up automated messages.

## Notes

- `slack_queue_messages` only changes the behavior of `deliverMessage()` (queue vs immediate);
  `sendMessage()`/`queueMessage()` force their respective paths — see
  [../api/send.md](../api/send.md).
- The module defines **no permissions of its own**; all three routes require `administer site
  configuration`.
