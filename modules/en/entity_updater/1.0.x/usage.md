<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Updater mass-updates entities by enqueuing a plain re-save (`$entity->save()`) for each, processed on cron or via `drush queue-run`.
---
The module solves the common maintenance need to force every entity of a type/bundle through its normal save path — so that computed fields recalculate, field defaults populate, search/index hooks fire, or a data migration settles — without writing a one-off script and without exhausting memory. It exposes a tiny helper class `Drupal\entity_updater\EntityUpdater` with `enqueueAll($entity_type, $bundle)`, `enqueueUpdate($entity)` and `enqueueUpdateById($type, $id)`, plus a Drush command `entity-updater:enqueue` (alias `euq`). Enqueued items land in the reliable `entity_updater` queue; the `EntityUpdaterQueueWorker` (cron time budget 30s) loads each entity, skips it if it was deleted or changed since enqueueing (via `EntityChangedInterface::getChangedTime`), disables new-revision creation on revisionable entities, calls `save()`, then resets the storage cache to free memory.

Operationally there is **no web route, form, permission or config** — the only entry points are PHP code and the Drush command, so the attack surface is CLI/administrative only. `enqueueAll()` runs an entity query with `accessCheck()` enabled (default access check) before enqueuing IDs. Because the worker just re-saves with no field changes, it is safe to re-run; it deliberately avoids new revisions so revision history is not bloated. Typical setup is nothing more than enabling the module and running the Drush command, then forcing the queue with `drush queue-run entity_updater` (or letting cron drain it); the `queue_ui` module is recommended to watch queue depth.
---
- Enable the module: `drush en entity_updater -y`.
- Enqueue every node of a bundle: `drush entity-updater:enqueue node page`.
- Enqueue all entities of a type (no bundle filter): `drush entity-updater:enqueue taxonomy_term`.
- Enqueue all users for re-save: `drush entity-updater:enqueue user`.
- Drain the queue immediately: `drush queue-run entity_updater`.
- Let cron process the queue gradually (30s/run budget).
- From custom code, enqueue all: `EntityUpdater::create()->enqueueAll('node', 'article');`.
- Enqueue a single loaded entity: `EntityUpdater::create()->enqueueUpdate($entity);`.
- Enqueue by type + ID without loading: `EntityUpdater::create()->enqueueUpdateById('node', 42);`.
- Force recomputation of computed/derived fields across a content type.
- Repopulate a newly added field's default value on existing content.
- Trigger presave/insert hooks (search index, pathauto, cache tags) across a bundle.
- Re-save content after a data model change so entity keys settle.
- Monitor queue depth with the queue_ui module UI.
- Re-run safely — unchanged entities skip if modified after enqueue time.
- Avoid revision bloat: worker sets `setNewRevision(FALSE)` automatically.
- Batch large sites without OOM (per-item cache reset frees memory).
- Combine with cron scheduling for background, throttled processing.
- Use as a lightweight alternative to a custom update hook for mass re-saves.
