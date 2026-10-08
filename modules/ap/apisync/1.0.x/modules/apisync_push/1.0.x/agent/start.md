<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API Sync Push (apisync_push) — agent index

Submodule of [apisync](../../../../1.0.x/agent/start.md). Exports Drupal entity CRUD to the remote OData API. Package `Apisync`, core `^9.1 || ^10 || ^11`. Depends on `apisync_mapping`.

## Entity hooks (apisync_push.module)
`apisync_push_entity_insert/update/delete` → `apisync_push_entity_crud($entity, $op)`:
- Skips entities that are syncing (`SynchronizableInterface::isSyncing()`) or are `ApiSyncMappedObject`/`ApiSyncMapping`/`ApiSyncMappedObjectType` (loop prevention).
- Loads push mappings via `loadPushMappingsByProperties()`, checks `$mapping->checkTriggers([$op])`.
- Per mapping (`apisync_push_entity_crud_mapping`): loads/creates the `apisync_mapped_object`, dispatches `ApiSyncPushAllowedEvent` (subscriber may `disallowPush()`), then:
  - if `$mapping->async` → `apisync_push_enqueue_async()` (queue item `{name, entity_id, op, mapped_object_id}`);
  - else real-time `push()` / `pushDelete()`, enqueuing async on failure and recording `last_sync_status`/`revision_log_message`.

## Services (apisync_push.services.yml)
- `queue.apisync_push` = `PushQueue` (implements `PushQueueInterface`; extends DB queue). `processQueues()` / `processQueue($mapping)` / `createItem()` / `deleteItemByEntity()` / `setName()`.
- `plugin.manager.apisync_push_queue_processor` = `PushQueueProcessorPluginManager` — plugin type **`apisync_push_queue_processor`** (dir `Plugin/ApiSyncPushQueueProcessor`, interface `PushQueueProcessorInterface`).

## Push queue processor plugin
- `Plugin/ApiSyncPushQueueProcessor/Rest` — `@Plugin(id="rest", label="REST Push Queue Processor")`; processes queued items by pushing through the OData client.

## Cron
`apisync_push_cron()` — returns early if `apisync.settings:standalone`; else `loadCronPushMappings()` + `PushQueue::processQueues($mappings)`.

## Routes (apisync_push.routing.yml) — `_access_system_cron: 'TRUE'`
- `apisync_push.endpoint` — `/apisync_push/endpoint/{key}` → `PushController::endpoint` (requires global `standalone`).
- `apisync_push.endpoint.apisync_mapping` — `/apisync_push/{apisync_mapping}/endpoint/{key}` → `mappingEndpoint` (requires `doesPushStandalone()` or global standalone).

## Drush (drush.services.yml → ApiSyncPushCommands)
`apisync_push:push-queue`, `apisync_push:requeue`.

## Related
Push params/values are built by `apisync_mapping` (`PushParams`, `PushActions`, `ApiSyncMappedObject::push()`); events `ApiSyncPushEvent`, `ApiSyncPushParamsEvent`, `ApiSyncPushOpEvent`, `ApiSyncPushAllowedEvent`.
