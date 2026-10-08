<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Amazon Simple Notification Service (SNS) (amazon_sns) — agent index

Receives inbound **Amazon SNS** HTTP notifications at one route, **validates the AWS message
signature**, and re-dispatches each message as a **Symfony event** for other code to handle.
Package `Web services`. Core `^9.1 || ^10 || ^11`. License GPL-2.0-or-later. Version 8.x-1.3.

- **The endpoint, signature validation, events, subscribers, and settings** →
  [api/events.md](api/events.md)
- **Config object + settings form** → [config/settings.md](config/settings.md)

## What it actually is

- **No Drupal-module dependencies.** It depends on two Composer libraries (declared in
  `composer.json`, installed via `packages.drupal.org`): `aws/aws-sdk-php ^3.28` and
  `aws/aws-php-sns-message-validator ^1.1`. No `*.permissions.yml` (routes reuse the core
  `administer site configuration` permission). No entities, no plugin types, no Drush.
- **One inbound route** `amazon_sns.notify` → `/_amazon-sns/notify` →
  `NotificationController::receive()` (`src/Controller/NotificationController.php`). Requirement
  `_access: 'TRUE'` — SNS posts unauthenticated by design; the **security boundary is the AWS
  signature check**, not Drupal access.
- **One settings route** `amazon_sns.settings` → `/admin/config/services/amazon-sns` →
  `SnsSettingsForm`, requirement `_permission: 'administer site configuration'`. Menu link in
  `amazon_sns.links.menu.yml` under *Configuration → Services*.

## Mechanism (from source)

- `RequestMessageValidator::getMessageFromRequest()` (`src/RequestMessageValidator.php`) requires
  the `X-Amz-Sns-Message-Type` header, JSON-decodes the body into an `Aws\Sns\Message`, then runs
  `Aws\Sns\MessageValidator::validate()`. The validator enforces the signing-cert URL is
  `https`, ends in `.pem`, and matches `sns.<region>.amazonaws.com` before fetching it and
  checking the signature. Failures throw `InvalidSnsMessageException` / `\InvalidArgumentException`.
- `NotificationController::receive()` catches those and returns an HTTP **400** (message escaped
  via `Html::escape`); valid messages go to `MessageEventDispatcher::dispatch()` and it returns a
  **200** (so SNS does not retry).
- `MessageEventDispatcher::dispatch()` (`src/Event/MessageEventDispatcher.php`) switches on
  `$message['Type']` and dispatches an `SnsMessageEvent` under one of the `SnsEvents` constants;
  an unknown type throws `\InvalidArgumentException` → 400.

## Events (`src/Event/SnsEvents.php`) and bundled subscribers

- `SnsEvents::NOTIFICATION` = `amazon_sns_notification`
- `SnsEvents::SUBSCRIPTION_CONFIRMATION` = `amazon_sns_subscription_confirmation`
- `SnsEvents::UNSUBSCRIBE_CONFIRMATION` = `amazon_sns_unsubscribe_confirmation`
- `SnsSubscriptionConfirmationSubscriber::confirm()` — GETs the (already-signature-validated)
  `SubscribeURL` to auto-confirm subscriptions; logs the topic.
- `SnsNotificationSubscriber::logNotification()` (priority 100) — logs `MessageId` + `TopicArn`
  **only when** `amazon_sns.settings:log_notifications` is TRUE.
- Write your own: tag an `event_subscriber` service on `SnsEvents::NOTIFICATION` and read
  `$event->getMessage()` (an `Aws\Sns\Message`, array-accessible: `TopicArn`, `Message`, etc.).

## Config

- One config object `amazon_sns.settings` with a single boolean `log_notifications` (default
  FALSE). Schema in `config/schema/amazon_sns.schema.yml`, default in `config/install/`. Details
  in [config/settings.md](config/settings.md).
