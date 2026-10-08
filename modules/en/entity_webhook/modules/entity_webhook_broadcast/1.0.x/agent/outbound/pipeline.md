<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Outbound dispatch, delivery & retry

## Trigger — entity lifecycle hooks

`src/Hook/EntityLifecycleHooks.php` (service-registered, `#[Hook]` attributes):

- `#[Hook('entity_insert')]` → `dispatch($entity, 'insert')`
- `#[Hook('entity_update')]` → `dispatch($entity, 'update')`
- `#[Hook('entity_predelete')]` → `dispatch($entity, 'delete')` (predelete so field values are still
  in memory).

## Dispatch — OutboundDispatcher

`src/Service/OutboundDispatcher.php` (`entity_webhook_broadcast.outbound_dispatcher`,
uses `ConditionAccessResolverTrait`):

1. `loadMatchingEndpoints()` — query enabled `outbound_endpoint` with `status = TRUE` and
   `entity_type = <entity type>` (`accessCheck(FALSE)`).
2. `endpointMatchesEntity()` — bundle filter, event membership (`in_array($event, getEvents())`), then
   `evaluateConditions()` (AND logic over active Condition plugins with the entity as context).
3. For each match, `loadActiveSubscriptions()` (`active = TRUE`), then per subscription
   `enqueueForSubscription()`: build the payload, create a pending `OutboundDeliveryLog`, and enqueue
   an `OutboundQueueItem` (endpoint, subscription, entity type/id, event, payload, delivery-log id,
   `attempt: 1`). Failures are caught and logged.

## Payload — PayloadBuilder

`src/Service/PayloadBuilder.php` (`entity_webhook_broadcast.payload_builder`): loads
`outbound_field_mapping` children for the subscription, and for each: resolves the value via the
mapping's `outbound_value_resolver` plugin (`resolve($entity)`), applies the optional parent
`field_value_mutation` (`mutate()`), and assigns it to `payload[output_key]`.

### outbound_value_resolver plugins (`src/Plugin/OutboundValueResolver/`)

Attribute `#[OutboundValueResolver]`, interface `resolve(EntityInterface): mixed`, base
`OutboundValueResolverBase`:

- `entity_field` — a direct entity field value.
- `entity_reference_field` — value(s) traversed from referenced entities.
- `field_component` — a specific component/property of a field.
- `static_value` — a configured constant.

## Delivery — DeliveryService

`src/Service/DeliveryService.php` (`entity_webhook_broadcast.delivery_service`): JSON-encodes the
payload and Guzzle-`POST`s it to `subscription->getUrl()` with `timeout` 30s and
`http_errors: FALSE`. When the subscription has a non-empty `secret` and `signing_algorithm !==
'none'`, adds header `X-Webhook-Signature = hash_hmac($algorithm, $body, $secret)`. Returns a
`DeliveryResult` (success 2xx, http failure, or connection failure); response body is truncated to
1KB. Transport errors are caught and logged, never thrown.

## Queue worker & retry

`src/Plugin/QueueWorker/OutboundDeliveryWorker.php` (`#[QueueWorker id: 'entity_webhook_broadcast',
cron: ['time' => 60]]`): loads the subscription, calls `DeliveryService::deliver()`, updates the
delivery log. On failure, `RetryScheduler::shouldRetry($attempt, $maxAttempts)` decides whether to
schedule another attempt: `nextRetryAt()` = now + `baseDelay * 2^(attempt-1)` seconds (deterministic,
no jitter). When attempts are exhausted the log is marked `abandoned`.

`hook_cron` (`entity_webhook_broadcast.module`) takes a lock and calls
`RetryProcessor::processDue()` (`entity_webhook_broadcast.retry_processor`), which queries pending
`OutboundDeliveryLog` entries whose `next_retry_at` has passed and re-enqueues each as a new
`OutboundQueueItem` with an incremented attempt counter.

## Test form

`src/Form/TestWebhookForm.php` at
`…/broadcast/endpoints/{outbound_endpoint}/subscriptions/{outbound_subscription}/test` sends a sample
delivery for the subscription from the admin UI.
