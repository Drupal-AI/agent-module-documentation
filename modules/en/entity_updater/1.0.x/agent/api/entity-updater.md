<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Updater — API & Drush

## Code API — `Drupal\entity_updater\EntityUpdater`
Instantiate with `EntityUpdater::create()` (static factory, no DI args).

- `enqueueAll(string $entity_type_id, ?string $bundle = NULL): int` — runs `\Drupal::entityQuery($type)` with `->accessCheck()`, optionally filtered by the bundle key, and enqueues each ID. Throws `\InvalidArgumentException` on an unknown entity type. Returns the count enqueued.
- `enqueueUpdate(EntityInterface $entity): void` — enqueues one loaded entity.
- `enqueueUpdateById(string $entity_type_id, mixed $id): void` — enqueues by type + ID; each queue item is `['id', 'type', 'created' => requestTime]`.

## Queue worker
`@QueueWorker id=entity_updater`, `cron = {time = 30}`. `processItem()`:
1. Loads `storage($type)->load($id)`; returns if gone.
2. If `EntityChangedInterface` and `getChangedTime() > $data['created']`, skips (already updated).
3. If `RevisionableInterface`, `setNewRevision(FALSE)`.
4. `$entity->save()`, then `resetCache([$id])`.

## Drush
```
drush entity-updater:enqueue node page   # enqueue all page nodes
drush queue-run entity_updater           # process now (else cron drains it)
```
Aliases: `euq`, `entity_updater:enqueue`. Watch depth with the `queue_ui` module.
