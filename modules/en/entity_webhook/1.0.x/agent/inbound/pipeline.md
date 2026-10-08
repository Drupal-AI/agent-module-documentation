<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Inbound receive & processing pipeline

## Receiver route & controller

`entity_webhook.routing.yml` → `entity_webhook.receive`: path
`/webhook/{endpoint_name}/{source_type}`, `methods: [POST]`, handled by
`WebhookController::receive()` (`src/Controller/WebhookController.php`).

`receive()` steps (each failure returns a JSON error with a status code):

1. `WebhookRequestValidator::parsePayload($request)` — decode JSON body; **400** on invalid JSON.
2. Load the `webhook_endpoint` by name; **404** if missing.
3. Load the `webhook_source_type` by name; **404** if missing.
4. `isSourceTypeAllowed($endpoint, $source_type)` — the source type must be listed on the endpoint;
   **404** otherwise.
5. `runVerification()` — builds the source type's configured `webhook_verification` plugin and runs
   it through `VerificationChain::verify()`; **403** on failure. Configure a verifier on each source
   type so requests are authenticated.
6. Build a `WebhookQueueItem` (endpoint, source, payload, `receivedAt`, `source: 'webhook'`) and
   either process it synchronously (`$endpoint->isSync()`) or enqueue it (default).

Sync returns **200** with the result array (or **422** on processing failure); async enqueues and
returns **200** `{"status":"queued"}`.

## Queue & worker

`WebhookQueueService` (`entity_webhook.webhook_queue`) enqueues `WebhookQueueItem` (serialized via
`toArray()`/`fromArray()`). Worker `WebhookQueueWorker` (`#[QueueWorker id: 'entity_webhook_processor',
cron: ['time' => 60]]`) deserializes each item and calls `WebhookProcessor::process()`. Async
endpoints therefore need **cron** or a queue runner.

## WebhookProcessor

`src/Service/WebhookProcessor.php` orchestrates one item; all failures are caught and returned as
`WebhookProcessResult` (no exceptions escape):

- Reloads endpoint + source type; re-checks the association.
- If the source type has a `payload_processor`, `processBatch()` splits the payload into sub-payloads,
  runs each, and dispatches `entity_webhook.batch_complete`. Otherwise `runOperation()`.
- `runOperation()` branches on `operation`: `delete` → `processDelete()`, else → `processItem()`.
- `extractFieldValues()` — for each `FieldMapping`, instantiates the `resolver` plugin and calls
  `resolve($payload)`; if non-null, applies the `mutation_plugin` via `mutate()`. Resolver/mutation
  errors are logged and skip that value.

### processItem (upsert)

`EntityUpsertService::resolveEntity()` → `applyFieldValues()` → dispatch
`entity_webhook.pre_save` (a subscriber may `abort()`, which returns an error result) → `save()` →
dispatch `entity_webhook.post_save`. Result operation is `created` or `updated`.

### processDelete

Resolves the entity from identifier mappings; if none matches, returns success `skipped`
(idempotent). Otherwise `delete()` and returns `deleted`.

## Entity resolution

- `EntityUpsertService` (`src/Service/EntityUpsertService.php`): `resolveEntity()` builds identifier
  criteria from identifier-flagged mappings, looks up an existing entity, else creates a new one of
  the target type/bundle. `applyFieldValues()` writes each mapped value with `$entity->set()`,
  skipping the entity ID and bundle keys.
- `EntityLookupService` (`src/Service/EntityLookupService.php`): `findEntity()` runs an entity query
  with `accessCheck(FALSE)`, adds one `condition()` per identifier (AND logic / composite key), and
  returns the first match or NULL.

## JSONPath extraction

`JsonPathExtractor` (`src/Service/JsonPathExtractor.php`, service
`entity_webhook.json_path_extractor`) wraps `Flow\JSONPath\JSONPath` (softcreatr/jsonpath).
`extract($payload, $expression)` returns the single match, an array of matches, or NULL (and NULL on
`JSONPathException`). Used by the `json_path` value resolver.

## Events

`EntityWebhookEvents` (`src/Event/EntityWebhookEvents.php`):

- `entity_webhook.pre_save` (`EntityWebhookPreSaveEvent`) — before save; `abort()` prevents it.
- `entity_webhook.post_save` (`EntityWebhookPostSaveEvent`) — after a successful save (informational).
- `entity_webhook.batch_complete` (`WebhookBatchCompleteEvent`) — after all sub-payloads of a
  processor batch; carries the `results[]` for reconciliation.
