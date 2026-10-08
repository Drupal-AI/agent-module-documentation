<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Webhook Polling (entity_webhook_polling) — agent index

Scheduled-ingestion submodule of **entity_webhook**. On cron it runs due **polling configurations**,
fetches payloads from a **polling provider** plugin, and enqueues only new/changed records (SHA-256)
into the parent module's inbound pipeline. Package `Services`. Version 1.0.0-alpha1. Core
`^10.3 || ^11`, PHP 8.3+. Depends on `entity_webhook`; uses **dragonmantank/cron-expression** (a
parent composer dep). Permission: `administer entity_webhook_polling`.

## Config entity

`entity_webhook_polling` (`src/Entity/EntityWebhookPolling.php`, config prefix
`entity_webhook_polling.polling.*`). Keys: `status`, `cron_expression`, `polling_provider`
(+ `polling_provider_config`), `endpoint_id`, `source_type_id`. Getters `getCronExpression()`,
`getPollingProvider()`, `getPollingProviderConfig()`, `getEndpointId()`, `getSourceTypeId()`.
See [config/polling.md](config/polling.md).

## Runtime

`hook_cron` (`entity_webhook_polling.module`) takes a lock → `PollingManager::runAllDue()`
(`entity_webhook_polling.polling_manager`):

1. Load enabled `entity_webhook_polling` configs.
2. `CronExpressionService::isDue($expr)` (wraps dragonmantank/cron-expression) filters to due ones.
3. Instantiate the `polling_provider` plugin and call `fetch()` → array of payloads.
4. Per payload: `hash('sha256', serialize($payload))`; external id = `payload['id']` or the hash;
   compare with `PollingStateStorage::getHash()`; if unchanged, skip; else enqueue a
   `WebhookQueueItem` (source `polling`) via the parent's `WebhookQueueServiceInterface` and
   `saveState()` the new hash.

Queued items are then processed by the parent module's `entity_webhook_processor` queue worker
(JSONPath extraction → mutations → entity upsert/delete). See [config/polling.md](config/polling.md).

## Plugin type

`polling_provider` (attribute `#[PollingProvider]`, `src/Plugin/PollingProvider/`; interface + base +
manager). No concrete provider ships — implement `fetch()` in a custom provider for each external API.

## Operate

Enable `entity_webhook_polling`. Manage configs at `/admin/config/services/entity-webhook/polling`
(menu *Configuration → Services → Entity Webhook → Polling Configurations*). Polling runs on **cron**;
choose a cron expression no finer than your Drupal cron frequency. Parent module →
[../../../1.0.x/agent/start.md](../../../1.0.x/agent/start.md).
