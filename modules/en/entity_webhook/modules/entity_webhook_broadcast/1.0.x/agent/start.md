<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Webhook Broadcast (entity_webhook_broadcast) — agent index

Outbound submodule of **entity_webhook**. On entity **insert/update/predelete** it matches configured
outbound endpoints, builds a JSON payload from entity fields, **HMAC-signs** it, and **POSTs** it to
each subscription's URL through a queue, with **exponential-backoff retry** and per-attempt
**delivery logging**. Package `Services`. Version 1.0.0-alpha1. Core `^10.3 || ^11`, PHP 8.3+.
Depends on `entity_webhook`. Permission: `administer entity_webhook_broadcast`.

## Entities (config unless noted)

- `outbound_endpoint` — `entity_type`, `entity_bundle` (empty = all), `events` (insert/update/delete),
  `conditions` (Condition API), `status`.
- `outbound_subscription` — `endpoint_id`, `url`, `secret` (nullable), `signing_algorithm`
  (default `sha256`, `none` = off), `retry_max_attempts` (default 5), `retry_base_delay` (default 60),
  `active`.
- `outbound_field_mapping` — `subscription_id`, `resolver` (+ config), `output_key`,
  `mutation_plugin` (+ config).
- `outbound_delivery_log` — **content entity** (table `outbound_delivery_log`): `status`
  (pending/success/failed/abandoned), `attempt`, `max_attempts`, `http_status`, response body,
  `next_retry_at`, payload + hash.

Details, routes, schema keys → [config/entities.md](config/entities.md).

## Pipeline & services

`EntityLifecycleHooks` (`#[Hook]` insert/update/predelete) → `OutboundDispatcher` (match endpoints,
evaluate conditions, enqueue per subscription, create pending log) → `OutboundQueueWorker`
(`#[QueueWorker id: 'entity_webhook_broadcast']`) → `DeliveryService` (Guzzle POST, HMAC via
`hash_hmac`, header `X-Webhook-Signature`) → `RetryScheduler` (`shouldRetry`, `nextRetryAt` =
`base * 2^(attempt-1)`). `hook_cron` → `RetryProcessor::processDue()` re-enqueues due pending logs.
`PayloadBuilder` assembles payloads. See [outbound/pipeline.md](outbound/pipeline.md).

## Plugin type

`outbound_value_resolver` (attribute `#[OutboundValueResolver]`, `resolve(EntityInterface): mixed`):
`entity_field`, `entity_reference_field`, `field_component`, `static_value`. Reuses the parent
`field_value_mutation` plugins. See [outbound/pipeline.md](outbound/pipeline.md).

## Operate

Enable `entity_webhook_broadcast`. Configure at
`/admin/config/services/entity-webhook/broadcast/endpoints` (menu *Configuration → Services → Entity
Webhook → Outbound Broadcasts*). Delivery and retries run on **cron**. A per-subscription **Test
Webhook** form (`TestWebhookForm`) and **delivery logs** view are available under each subscription.
Parent module → [../../../1.0.x/agent/start.md](../../../1.0.x/agent/start.md).
