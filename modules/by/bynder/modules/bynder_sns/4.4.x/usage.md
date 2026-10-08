Bynder SNS updates local Bynder media metadata in near-real-time by processing Amazon SNS notifications that Bynder emits when an asset changes, replacing the slower periodic cron refresh.

---

The submodule bridges the [Amazon SNS](https://www.drupal.org/project/amazon_sns) module and Bynder. It adds
a **Topic** field (config `bynder_sns.settings:topic`, an SNS topic ARN) to the Bynder configuration form via
`hook_form_bynder_configuration_form_alter()`, and an event subscriber (`NotificationSubscriber`) that listens
to `SnsEvents::NOTIFICATION`. When a notification arrives, it ignores anything whose `TopicArn` does not match
the configured topic, decodes the message, extracts `media_id`, finds local Bynder media whose source field
holds that ID (querying every Bynder media type's source field with access checks off), and calls
`BynderService::updateMediaEntities()` to refresh that entity from the remote metadata, logging the result.
The SNS subscription must be configured on the AWS side to POST to the Amazon SNS module's notify endpoint
(`amazon_sns.notify`); once working, the background metadata refresh can be disabled. Depends on `bynder` and
`amazon_sns`. No permissions; the only config is the topic ARN.

---

- Refresh a Bynder media entity immediately when its asset changes in Bynder, via an SNS push.
- Replace (or supplement) the periodic cron metadata sync with event-driven updates.
- Restrict processing to a single trusted SNS topic ARN so foreign notifications are ignored.
- Keep titles, descriptions, and metaproperties in sync within seconds of a Bynder edit.
- Wire Bynder's SNS notifications to the Amazon SNS module's notify endpoint.
- Configure the SNS topic directly on the Bynder settings form (no separate admin page).
- Log every processed/ignored/failed notification to the `bynder_sns` channel for auditing.
- Match a changed asset across multiple Bynder media types by their source fields.
- Reduce API load by updating only the specific asset referenced in a notification.
- Disable the background refresh once SNS delivery is confirmed to cut cron work.
- Handle notifications with missing/invalid media IDs gracefully (logged, skipped).
- Support multi-type setups where different media types share or differ in source fields.
- Give editors faster feedback that DAM changes have propagated to the site.
- Integrate Bynder change events into an AWS-centric infrastructure.
- Avoid stale metadata between scheduled syncs for high-churn asset libraries.
