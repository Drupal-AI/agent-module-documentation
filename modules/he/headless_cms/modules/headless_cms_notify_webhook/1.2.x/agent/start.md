<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Headless CMS - Notify Webhook (headless_cms_notify_webhook) — agent index

Provides a **`webhook`** transport plugin for Headless CMS - Notify: delivers each notification
message as a JSON HTTP `POST`. Version **1.2.x**. Core `^10.3 || ^11`. Depends on
`headless_cms:headless_cms`, `headless_cms_notify:headless_cms_notify`. No routes, permissions or
config schema of its own — it is configured on a `headless_notify_transport` entity.

## What it provides

- **Transport plugin** `HeadlessNotifyWebhookTransport`
  (`src/Plugin/HeadlessNotifyTransport/HeadlessNotifyWebhookTransport.php`), id **`webhook`**,
  implements `HeadlessNotifyTransportPluginFormInterface`. Config: `url` (required, validated with
  `FILTER_VALIDATE_URL`) and `use_queue` (bool, default TRUE). `send()` calls the service with
  `$message->toJson()`.
- **Service** `HeadlessNotifyWebhookService` (`src/HeadlessNotifyWebhookService.php`) —
  `send(string $url, string $json, bool $useQueue = TRUE)`. Queued path enqueues a
  `HeadlessNotifyWebhookQueueItem`; direct path POSTs via Guzzle (`Content-Type: application/json`,
  `connect_timeout: 5`). Logs to `logger.channel.headless_cms_notify_webhook`; 404 → warning
  (swallowed), other client/connection errors → `WebhookRequestException`.
- **Queue worker** `Plugin\QueueWorker\HeadlessNotifyWebhookQueueWorker`, id
  **`headless_cms_notify_webhook`** (`cron: {time: 30}`) — pops items and calls
  `service->send($url, $json, FALSE)`.
- **DTO** `HeadlessNotifyWebhookQueueItem` (url + json, `toJson()`/`fromJson()`).
- **Exception** `Exception\WebhookRequestException`.

## Configure

Add a transport at `/admin/config/headless-cms/notify/transports/add`, pick **Webhook**, set the
URL, choose queued vs. synchronous. Then reference the transport from a consumer's
*Headless CMS → Notify* settings. See
[config/transport.md](config/transport.md) and the parent Notify docs
([../../headless_cms_notify/1.2.x/agent/start.md](../../headless_cms_notify/1.2.x/agent/start.md)).
