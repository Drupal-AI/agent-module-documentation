<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sending messages (service, queue, Rules action)

## The service

`slack.slack_service` → `Drupal\slack\Slack` implementing
`Drupal\slack\SlackInterface` (constructor args: `@config.factory`, `@http_client`,
`@logger.factory`, `@messenger`, `@queue`).

All three methods share the signature
`($message, $channel = '', $username = '', ?string $webhook_url = NULL)` — empty `channel`/
`username`/`webhook_url` fall back to `slack.settings`.

```php
/** @var \Drupal\slack\SlackInterface $slack */
$slack = \Drupal::service('slack.slack_service');

// Respects the slack_queue_messages setting (queue if on, else send now):
$slack->deliverMessage('Hello from Drupal', '#general', 'Drupal Bot');

// Always send immediately via the webhook (returns the HTTP result / FALSE if no webhook):
$slack->sendMessage('Immediate alert', '#alerts');

// Always enqueue for cron delivery (returns bool):
$slack->queueMessage('Deferred note');

// Override the webhook per call:
$slack->sendMessage('To another workspace', '#ops', 'Bot', 'https://hooks.slack.com/services/…');
```

- `deliverMessage()` checks `slack.settings.slack_queue_messages`; TRUE → `queueMessage()`,
  FALSE → `sendMessage()`.
- `sendMessage()` builds the payload (`prepareMessage()`: channel, username, icon, link_names)
  and POSTs to the webhook; if no webhook is configured it sets an error message and returns
  FALSE.
- `queueMessage()` creates an item on the `slack_message` queue.

## Async queue

QueueWorker plugin id **`slack_message`** (`Plugin/QueueWorker/SlackMessage`) processes queued
items on cron by calling the service's send path. Each item carries `message`, `channel`,
`username`, `webhook_url`.

## Rules action (no code)

Rules action id **`rules_slack_send_message`** — "Send message to Slack" (category *Slack*),
context: Message, Channel, User name. Add it to a Rules reaction to post to Slack when an event
fires. Requires the `drupal/rules` module (a dev dependency of this module).

## Notes

- There are no Drush commands and no plugin *types* defined by this module; `slack_message`
  (QueueWorker) and `rules_slack_send_message` (RulesAction) are plugin *instances* of core /
  Rules types.
- Delivery requires a configured `slack_webhook_url` (or one passed per call).
