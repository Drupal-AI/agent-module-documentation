<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Polling configuration, services & pipeline

## Config entity — entity_webhook_polling

`src/Entity/EntityWebhookPolling.php`, `#[ConfigEntityType id: 'entity_webhook_polling']`, config
prefix `polling` (objects named `entity_webhook_polling.polling.*`). Schema:
`config/schema/entity_webhook_polling.schema.yml`. Keys:

- `id`, `label`, `status` (bool — only enabled configs run).
- `cron_expression` — standard 5-field cron expression (`getCronExpression()`).
- `polling_provider` (+ `polling_provider_config` map) — the `polling_provider` plugin ID and its
  settings (`getPollingProvider()`, `getPollingProviderConfig()`).
- `endpoint_id` — the parent `webhook_endpoint` to route payloads to (`getEndpointId()`).
- `source_type_id` — the parent `webhook_source_type` whose mappings apply (`getSourceTypeId()`).

Route: `entity.entity_webhook_polling.collection` at `/admin/config/services/entity-webhook/polling`,
`_permission: 'administer entity_webhook_polling'` (`permissions.yml`, `restrict access: true`).
Managed with `EntityWebhookPollingForm` / `EntityWebhookPollingListBuilder`.

## Services

- `entity_webhook_polling.polling_manager` — `PollingManager` (`src/Service/PollingManager.php`).
- `entity_webhook_polling.cron_expression_service` — `CronExpressionService`
  (`isDue()`, wraps dragonmantank/cron-expression).
- `plugin.manager.polling_provider` — `PollingProviderManager`.
- state storage — `PollingStateStorage` (`src/Storage/PollingStateStorage.php`): `getHash()`,
  `saveState()` per (config id, external id).

## Cron pipeline

`entity_webhook_polling_cron()` acquires a lock (skips if held) and calls
`PollingManager::runAllDue()`:

1. `loadByProperties(['status' => TRUE])` — enabled configs.
2. For each, `CronExpressionService::isDue($config->getCronExpression())`; if due, `runPolling($id)`.
3. `runPolling()` instantiates the provider plugin and calls `fetch()`; provider exceptions are caught
   and logged (one config's failure does not stop the others).
4. `processPayload()` per returned payload: `hash('sha256', serialize($payload))`, external id =
   `payload['id']` (string) or the hash; if the stored hash matches, return (skip). Otherwise build a
   `WebhookQueueItem(endpointId, sourceType, payload, receivedAt, source: 'polling')`, enqueue via the
   parent `WebhookQueueServiceInterface`, and `saveState()` the new hash.

Downstream processing (extraction, mutation, upsert/delete, events) is the parent module's — see the
parent's `agent/inbound/pipeline.md`.

## polling_provider plugin type

Attribute `#[PollingProvider]` (`src/Attribute/PollingProvider.php`); interface + `PollingProviderBase`
+ `PollingProviderManager` in `src/Plugin/PollingProvider/`. A provider implements `fetch(): array`
returning a list of payload arrays. No concrete provider is bundled; add one per external API and its
`fetch()` is responsible for calling the remote service using the provider config.
