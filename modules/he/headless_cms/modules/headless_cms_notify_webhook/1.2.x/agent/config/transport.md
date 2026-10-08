<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webhook transport — configuration & delivery

## Enable & create

```
drush en headless_cms_notify_webhook -y
```

Go to `/admin/config/headless-cms/notify/transports/add`, select **Webhook** as the transport
plugin, and fill the plugin settings that `HeadlessNotifyWebhookTransport::buildConfigurationForm()`
renders:

| Setting | Key | Default | Notes |
|---|---|---|---|
| URL | `url` | `''` | Required; validated with `FILTER_VALIDATE_URL` in `validateConfigurationForm()` |
| Use Queue | `use_queue` | `TRUE` | Queued (cron) vs. synchronous delivery |

These are stored in the transport entity's `transport_plugin_configuration`. Assign the transport to
a consumer under *Consumer → Additional Settings → Headless CMS → Notify*.

## What gets sent

For each applicable consumer, `HeadlessNotifyWebhookTransport::send()` calls
`HeadlessNotifyWebhookService::send($url, $message->toJson(), $use_queue)`. The request is:

- `POST <url>`
- header `Content-Type: application/json`
- body = the message JSON, e.g.
  `{"type":"entity_operation","subType":"node","params":{"id":"12","uuid":"…","bundle":"article","operation":"update"}}`
  or `{"type":"cache_rebuild","subType":null,"params":[]}`.

Sent through Drupal's shared Guzzle client with `connect_timeout: 5`.

## Queue vs. synchronous

- **Queued** (`use_queue = TRUE`): `send()` creates a `HeadlessNotifyWebhookQueueItem($url, $json)`
  and pushes its JSON onto the `headless_cms_notify_webhook` queue. The
  `HeadlessNotifyWebhookQueueWorker` (`cron: {time: 30}`) drains it on cron, calling
  `send($url, $json, FALSE)`. Run `drush queue:run headless_cms_notify_webhook` to flush manually.
- **Synchronous** (`use_queue = FALSE`): the POST happens inline during the triggering request.

## Logging & errors (`logger.channel.headless_cms_notify_webhook`)

- Success → `info` "Successfully sent webhook to: <url>".
- Destination returns **404** → `warning` "endpoint not implemented"; **no exception** (a frontend
  that hasn't wired the hook yet won't break saves).
- Other `ClientException` (non-404) → `error` with status + payload, then throws
  `WebhookRequestException($response)`.
- `ConnectException` → `error` "Could not connect to host", then throws `WebhookRequestException()`.

In the synchronous path a thrown `WebhookRequestException` propagates to the caller; in the queued
path it surfaces as a queue-worker failure (item retried on the next cron run).
