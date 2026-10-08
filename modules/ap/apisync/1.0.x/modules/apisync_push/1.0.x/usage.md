<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Pushes Drupal entity create/update/delete operations to the remote OData API based on API Sync mappings, in real time or via an async queue.

---

`apisync_push` exports Drupal changes to the remote system. Core entity hooks (`apisync_push_entity_insert/update/delete`) find push-enabled mappings for the changed entity, honor the mapping's sync triggers, and — unless a `PushAllowed` event vetoes it — either push in real time (`ApiSyncMappedObject::push()` / `pushDelete()`) or enqueue the operation into that mapping's async push queue. Real-time failures fall back to the queue automatically. The `PushQueue` service (`queue.apisync_push`) processes queued items through `ApiSyncPushQueueProcessor` plugins (the shipped `rest` processor calls the OData client), on cron (`apisync_push_cron`) or via a cron-key-protected standalone endpoint (`/apisync_push/endpoint/{key}`). Mapped objects, mappings, and syncing entities are never themselves pushed, preventing loops. Push limits, retries, and frequency are configured per mapping and globally (`global_push_limit`).

---

- Push Drupal entity inserts/updates/deletes to the remote OData API.
- React to entity CRUD via `hook_entity_insert/update/delete`.
- Push in real time on save, with automatic fallback to the async queue.
- Queue push operations per mapping for batched async processing.
- Process the push queue on cron.
- Process the push queue via a standalone endpoint (cron-key protected).
- Honor per-mapping sync triggers (create/update/delete).
- Let event subscribers veto a push (`PushAllowed` event).
- Delete the remote object when a mapped Drupal entity is deleted.
- Prevent sync loops (skip syncing entities and mapping/mapped-object entities).
- Enforce a global push limit and per-mapping limits/retries/frequency.
- Extend push transport with custom `apisync_push_queue_processor` plugins.
- Record failed pushes on the mapped object (status, log message) and retry.
- Requeue or inspect the push queue via `drush apisync_push:push-queue` / `apisync_push:requeue`.
- Emit error events (logged by `apisync_logger`) on push failures.
