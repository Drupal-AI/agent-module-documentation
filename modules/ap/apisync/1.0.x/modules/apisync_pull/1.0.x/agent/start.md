<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API Sync Pull (apisync_pull) — agent index

Submodule of [apisync](../../../../1.0.x/agent/start.md). Imports remote OData records into Drupal. Package `Apisync`, core `^9.1 || ^10 || ^11`. Depends on `apisync_mapping`.

## Services (apisync_pull.services.yml)
- `apisync_pull.queue_handler` = `QueueHandler` — queries updated remote records for a mapping and enqueues `PullQueueItem`s into the `apisync_pull` DB queue. Methods incl. `getUpdatedRecords()`, `getUpdatedRecordsForMapping()`, `getSingleUpdatedRecord()`.
- `apisync_pull.delete_handler` = `DeleteHandler` — `processDeletedRecords()` removes Drupal entities for deleted remote records (uses `apisync_id_provider` / `apisync_delete_provider`).
- `apisync_pull.event_subscriber` = `PullEventSubscriber`.

## Queue workers (Plugin/QueueWorker)
- `PullBase` — abstract worker: reads a `PullQueueItem`, loads/creates the `apisync_mapped_object`, and pulls remote field values into the mapped Drupal entity (`ApiSyncMappedObject::pull()`).
- `CronPull` (`id = apisync_pull`, cron time) — the concrete pull queue worker.

## Cron
`apisync_pull_cron()` — returns early if `apisync.settings:standalone`; else if the provider is token-based and has no token, returns; otherwise `QueueHandler::getUpdatedRecords()` + `DeleteHandler::processDeletedRecords()`.

## Routes (apisync_pull.routing.yml) — all `_access_system_cron: 'TRUE'` (site cron key)
- `apisync_pull.endpoint` — `/apisync_pull/endpoint/{key}` → `PullController::endpoint`.
- `apisync_pull.endpoint.apisync_mapping` — `/apisync_pull/{apisync_mapping}/endpoint/{key}`.
- `apisync_pull.endpoint.single_record` — `/apisync_pull/{apisync_mapping}/endpoint/{key}/record/{id}`.
`PullController::endpoint()` re-checks `{key} == state('system.cron_key')`, requires standalone (global or per-mapping `doesPullStandalone()`), populates + processes the queue (30s default limit), and returns 204 (or redirects to `?destination`).

## Drush (drush.services.yml → ApiSyncPullCommands)
`apisync_pull:pull-query`, `apisync_pull:pull-reset`, `apisync_pull:pull-set` (+ inherited `odata:read-object`).

## Exceptions
`PullApiException`. Progress/errors dispatched as `ApiSyncNoticeEvent` / `ApiSyncErrorEvent` (logged by `apisync_logger`).
