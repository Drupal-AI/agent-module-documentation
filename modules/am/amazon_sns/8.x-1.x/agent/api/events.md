<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Amazon SNS — endpoint, signature validation & events

How the inbound webhook works and how to consume its events. Cite files under
`src/` of `web/modules/contrib/amazon_sns/`.

## Install / enable

1. `composer require drupal/amazon_sns` (pulls `aws/aws-sdk-php ^3.28` and
   `aws/aws-php-sns-message-validator ^1.1`).
2. `drush en amazon_sns`.
3. In the AWS SNS console create a topic and an **HTTP/HTTPS** subscription whose endpoint is
   `https://<your-site>/_amazon-sns/notify`. The URL must be publicly reachable by AWS.
4. AWS sends a `SubscriptionConfirmation`; the bundled subscriber auto-confirms it. Publish a
   test message to verify.

## The endpoint

- Route `amazon_sns.notify` (`amazon_sns.routing.yml`): path `/_amazon-sns/notify`,
  `_controller: NotificationController::receive`, `_access: 'TRUE'`.
- SNS delivers unauthenticated POSTs by design; **authenticity comes from the AWS message
  signature**, verified before any event fires. Do not add your own auth in front of the route.

## Request validation — `RequestMessageValidator::getMessageFromRequest()`

File `src/RequestMessageValidator.php` (static method):
1. Requires header `X-Amz-Sns-Message-Type`; missing → `\InvalidArgumentException`.
2. JSON-decodes `$request->getContent()` (associative) into an `Aws\Sns\Message`.
3. Builds `Aws\Sns\MessageValidator` with a cert-fetching callback that uses
   `\Drupal::httpClient()->request('GET', $cert_url)` (default Guzzle TLS verification), then
   calls `$validator->validate($message)`. The AWS SDK validator enforces the `SigningCertURL`
   is `https`, ends `.pem`, and its host matches `sns.<region>.amazonaws.com(.cn)` *before*
   fetching it, then verifies the RSA signature. A bad signature/cert → `InvalidSnsMessageException`.

## Controller — `NotificationController::receive(Request $request)`

File `src/Controller/NotificationController.php`:
- Wraps the validator call; `InvalidSnsMessageException` and `\InvalidArgumentException` →
  `badRequestResponse()`, which logs via a private `watchdogException()` helper and returns
  HTTP **400** with `Html::escape($e->getMessage())` as the body.
- On success calls `MessageEventDispatcher::dispatch($message)` and returns an empty **200**
  (`new Response()`), so SNS treats delivery as successful and does not retry.
- Constructor-injected via `create()`: `amazon_sns.message_dispatcher` and
  `logger.channel.amazon_sns`.

## Dispatch — `MessageEventDispatcher::dispatch(Message $message)`

File `src/Event/MessageEventDispatcher.php` (service `amazon_sns.message_dispatcher`, arg
`@event_dispatcher`). Wraps the message in `SnsMessageEvent` and `switch ($message['Type'])`:
- `SubscriptionConfirmation` → dispatch `SnsEvents::SUBSCRIPTION_CONFIRMATION`
- `Notification` → dispatch `SnsEvents::NOTIFICATION`
- `UnsubscribeConfirmation` → dispatch `SnsEvents::UNSUBSCRIBE_CONFIRMATION`
- anything else → `\InvalidArgumentException` (→ 400 upstream).

## Event names — `SnsEvents` (`src/Event/SnsEvents.php`)

| Constant | Value |
| --- | --- |
| `NOTIFICATION` | `amazon_sns_notification` |
| `SUBSCRIPTION_CONFIRMATION` | `amazon_sns_subscription_confirmation` |
| `UNSUBSCRIBE_CONFIRMATION` | `amazon_sns_unsubscribe_confirmation` |

## Event object — `SnsMessageEvent` (`src/Event/SnsMessageEvent.php`)

Extends `Symfony\Contracts\EventDispatcher\Event`. `getMessage()` returns the validated
`Aws\Sns\Message` (array-accessible: `Type`, `MessageId`, `TopicArn`, `Message`, `Subject`,
`SubscribeURL`, etc.).

## Bundled subscribers (`amazon_sns.services.yml`)

- `amazon_sns.subscription_confirmation_subscriber` →
  `SnsSubscriptionConfirmationSubscriber::confirm()` on `SUBSCRIPTION_CONFIRMATION`. GETs
  `$message['SubscribeURL']` with `@http_client` to confirm the subscription and logs the topic.
  (The URL originates from a signature-validated AWS message.) HTTP errors are intentionally not
  caught, so the controller returns a non-200 and SNS retries.
- `amazon_sns.notification_logger_subscriber` (priority 100) →
  `SnsNotificationSubscriber::logNotification()` on `NOTIFICATION`. Logs `%message-id` and
  `%topic` **only if** `amazon_sns.settings:log_notifications` is TRUE.

## Consume events from your own module

Register an `event_subscriber`-tagged service and subscribe to `SnsEvents::NOTIFICATION`.
Inspect `$event->getMessage()['TopicArn']` to route by topic; the message body is
`$event->getMessage()['Message']`. Use `src/Event/SnsSubscriptionConfirmationSubscriber.php`
as the reference pattern. There is no per-topic routing built in — all topics hit the same
endpoint and the same events.
