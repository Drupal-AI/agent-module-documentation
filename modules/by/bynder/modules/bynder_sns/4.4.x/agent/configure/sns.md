# Set up Bynder SNS

## 1. Configure the SNS topic

`bynder_sns_form_bynder_configuration_form_alter()` adds an **Amazon SNS notifications** details section to
the Bynder settings form (`/admin/config/services/bynder`) with a single **Topic** textfield. Enter the SNS
topic ARN (e.g. `arn:aws:sns:eu-central-1:...`). It is saved to `bynder_sns.settings:topic`:

```bash
drush cset bynder_sns.settings topic 'arn:aws:sns:eu-central-1:123456789012:my-bynder-topic' -y
```

## 2. Subscribe on the AWS side

Create an SNS subscription (in Bynder's SNS setup / AWS) that POSTs notifications to the Amazon SNS module's
endpoint — route `amazon_sns.notify` (its absolute URL is shown in the form's description). On successful
confirmation the topic name is logged. See Bynder's docs: `help.bynder.com/system/SNS_notifications.htm`.

## 3. Behaviour (`NotificationSubscriber::onNotification`)

On each `SnsEvents::NOTIFICATION`:
1. **Topic guard** — if `bynder_sns.settings:topic` is empty or `!= $sns_message['TopicArn']`, return
   (foreign/unmatched notifications are ignored).
2. Decode `$sns_message['Message']`; require `media_id` (else log error + return).
3. Collect the source field of every Bynder media type (`BynderService::getBynderMediaTypes()`), build an OR
   condition, and query `media` for entities whose source field == `media_id` (`accessCheck(FALSE)`).
4. For matches, call `BynderService::updateMediaEntities([$media_id => $media])` and log a notice; no match
   logs a notice and returns.

## 4. Disable cron refresh (optional)

Once SNS delivery is confirmed reliable, the periodic background metadata refresh can be turned down/off
(raise `bynder.settings:update_frequency`) since updates now arrive on demand.

No permissions are defined; access to the notify endpoint is governed by the Amazon SNS module.
