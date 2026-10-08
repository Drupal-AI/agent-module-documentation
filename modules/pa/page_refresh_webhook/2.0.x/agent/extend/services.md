<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services & extension points

Two services carry the logic; both are decoratable (register a `decorates:` service).

## `page_refresh_webhook.trigger`

Class `PageRefreshWebhookTrigger`, interface `PageRefreshWebhookTriggerInterface` (type-hint the interface for autowiring).

- `trigger(EntityInterface $entity, string $operation): void` — called by the `entity_insert`/`entity_update`/`entity_delete` hooks (`src/Hook/EntityHooks.php`). Bails out unless the entity is a `NodeInterface`, an `endpoint` is configured, and the bundle is enabled; skips new/still-unpublished nodes; consults `hook_page_refresh_webhook_trigger_webhook()`; then resolves the node's **absolute** URL and adds a queue item `{nid, bundle, operation, url, depth}` to the `page_refresh_webhook` queue. The URL is resolved here (in the web request), not in the worker, because cron has no host name. All failures are caught (`\Throwable`) and logged — never bubble up into the save.
- Constants: `QUEUE_NAME = 'page_refresh_webhook'`, `DEFAULT_DEPTH = 1`.

## `page_refresh_webhook.sender`

Class `PageRefreshWebhookSender`, interface `PageRefreshWebhookSenderInterface`.

- `send(string $url, int $depth): bool` — POSTs to the configured `endpoint` with `Content-Type: application/json`, optional `api-key` header (from the Key entity), body `{"docs":[{"url":$url}],"depth":$depth}`, 5s timeout. Returns `FALSE` if no endpoint is configured; throws `RuntimeException` if the configured Key is missing or the response is not 2xx; Guzzle throws for >=400.

## Queue worker

`src/Plugin/QueueWorker/PageRefreshWebhookQueueWorker.php` (`#[QueueWorker(id: 'page_refresh_webhook', cron: ['time' => 30])]`) claims items on cron and calls the sender. Dedupes identical `url|depth` within one run. On `ClientException` (endpoint rejected, e.g. 403) it drops the item; on any other `\Throwable` it throws `SuspendQueueException` so the whole queue retries next cron.

## Decorate example

```yaml
# my_module.services.yml
my_module.trigger_decorator:
  class: Drupal\my_module\MyTrigger
  decorates: page_refresh_webhook.trigger
  arguments: ['@my_module.trigger_decorator.inner']
```

Implement `PageRefreshWebhookTriggerInterface` (or `...SenderInterface` to change how requests are built/sent) and wrap the inner service.
