Amazon SNS lets a Drupal site receive Amazon Simple Notification Service push messages at a signed HTTP endpoint and re-dispatch each one as a Symfony event that other code can react to.

---

The module registers one inbound endpoint, `/_amazon-sns/notify`, that accepts the HTTP/HTTPS POSTs Amazon SNS sends to a subscribed topic. Every request body is parsed as JSON, wrapped in an `Aws\Sns\Message`, and passed through the AWS SDK `MessageValidator`, which verifies the message signature against the AWS signing certificate before anything acts on it. Valid messages are turned into an `SnsMessageEvent` and dispatched under one of three event names depending on the SNS `Type` (`Notification`, `SubscriptionConfirmation`, `UnsubscribeConfirmation`). The module ships two subscribers of its own: one auto-confirms new subscriptions by requesting the message's `SubscribeURL`, and one optionally logs incoming notifications. Everything else is meant to be built by your own event subscribers keyed on the topic ARN, so Drupal can respond to upstream systems (job completion, S3 uploads, CloudWatch alarms, third-party webhooks fanned out through SNS) without polling. The module requires the AWS SDK for PHP, installed via Composer.

---

- Receive Amazon SNS topic notifications in Drupal without writing a custom controller.
- Replace queue polling / cron-based checks with real-time push notifications from an upstream service.
- Trigger a cache clear or content re-index when an external pipeline signals it is done.
- Update or invalidate entity data when an S3 object is created, updated, or deleted (via S3 → SNS).
- React to CloudWatch alarms delivered through SNS (e.g. put the site into a degraded/maintenance mode).
- Fan out a third-party webhook through SNS and have several Drupal subscribers react independently.
- Kick off a Drupal batch or queue item when an AWS Lambda or Step Functions workflow completes.
- Confirm SNS subscriptions automatically the first time AWS sends a `SubscriptionConfirmation`.
- Log every inbound SNS message ID and topic ARN to help debug delivery problems.
- Route different SNS topics to different handlers by inspecting the `TopicArn` attribute in a subscriber.
- Build a decoupled notification bus where multiple AWS services publish to one topic Drupal listens on.
- Notify Drupal when a media transcoding / video-processing job (e.g. MediaConvert) finishes.
- Sync product, price, or inventory changes pushed from an ERP/CRM into SNS.
- Invalidate a CDN or rebuild a static export when upstream content changes.
- Receive delivery/bounce/complaint notifications from Amazon SES (which publishes to SNS).
- Trigger user-facing messages or emails in response to an external event delivered via SNS.
- Provide a reference implementation for writing your own AWS SDK-backed event subscribers in Drupal.
- Handle `UnsubscribeConfirmation` events to clean up or alert when a topic subscription is removed.
- Integrate mobile/push or SMS delivery status callbacks that AWS routes back through SNS.
- Let external monitoring or deployment tooling push status events straight into Drupal's log or workflow.
