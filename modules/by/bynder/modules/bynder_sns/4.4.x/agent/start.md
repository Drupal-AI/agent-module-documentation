# Bynder SNS — agent index

Event-driven Bynder metadata refresh via Amazon SNS. Adds a **Topic** (ARN) field to the Bynder config form
and processes SNS notifications to update the matching local media. Depends on `bynder` + `amazon_sns`.

- **Setup (topic config, AWS subscription) and how the notification is processed** →
  [configure/sns.md](configure/sns.md)

Key facts:
- Config `bynder_sns.settings:topic` (SNS topic ARN); added to the Bynder settings form via
  `bynder_sns_form_bynder_configuration_form_alter()`.
- Event subscriber `NotificationSubscriber` (`bynder_sns.services.yml`) listens to
  `SnsEvents::NOTIFICATION`; matches `TopicArn`, reads `media_id` from the message, loads Bynder media by
  source field, calls `BynderService::updateMediaEntities()`.
- AWS subscription should POST to route `amazon_sns.notify`.
- No permissions. Logs to the `bynder_sns` channel.
