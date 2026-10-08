<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API: service + queue worker (the delete mechanism)

Two moving parts: a **service** that *enqueues* entities, and a **QueueWorker** that
*deletes* their old revisions on cron. Nothing deletes synchronously.

## Service `revision_delete_tools.remove_revisions_service`

Class `Drupal\revision_delete_tools\Services\RemoveRevisionsService` (autowired). Inject it or
`\Drupal::service('revision_delete_tools.remove_revisions_service')`.

| Method | Signature | What it does |
|---|---|---|
| `queueRevisionsByType` | `(string $entityType, int $keep = 3): void` | For each bundle of the type, find qualifying ids and enqueue them. |
| `queueRevisionsByBundle` | `(string $entityType, string $bundle, int $keep = 3): void` | Enqueue qualifying entities of one bundle. |
| `queueRevisionsByEntityId` | `(string $entityType, string $entityId, int $keep = 3): void` | Enqueue a single entity id. Creates one `remove_revisions` queue item. |
| `getEntityIds` | `(string $entityType, ?string $bundle = NULL, int $keep = 3): array` | Fast SQL: ids that have **more than** `$keep` revisions. Does not load entities. |
| `getBundleNames` | `(string $entityType): array` | Bundle machine names via `EntityTypeBundleInfoInterface`. |
| `getRevisionableEntityTypes` | `(): array` | All entity type ids where `EntityType::isRevisionable()` is true. |

`$keep` defaults come from the constant `RemoveRevisions::REVISIONS_TO_KEEP` (3).

`getEntityIds()` builds a `database->select()` on the entity type's revision data table (or
revision table), grouping by id (and langcode when a data table exists) and filtering
`HAVING COUNT(revision_key) > :keep`. Table/column names come from the entity type
**definition** (`getRevisionTable()`, `getKey('id'|'revision'|'bundle'|'langcode')`), not from
input; `$bundle` and `$keep` are passed as bound parameters. Returns `[]` if the type has no
revision table or id key.

Each queue item payload is `['entityType' => ..., 'entityId' => ..., 'keep' => ...]`.

### Example: custom retention policy

```php
$svc = \Drupal::service('revision_delete_tools.remove_revisions_service');

// Keep 10 revisions for articles, 3 for pages.
$svc->queueRevisionsByBundle('node', 'article', 10);
$svc->queueRevisionsByBundle('node', 'page', 3);

// Inspect what would qualify (ids with > 3 revisions) without queueing:
$ids = $svc->getEntityIds('media', 'image', 3);
```

## Queue worker `remove_revisions`

Class `Drupal\revision_delete_tools\Plugin\QueueWorker\RemoveRevisions`
(`@QueueWorker(id = "remove_revisions", cron = {"time" = 60})`). Core's cron gives it up to
60s per run; run manually with `drush queue:run remove_revisions`.

`processItem($data)` per queued entity:

1. Read `entityType` / `entityId` / `keep` (missing type or id → logs error, skips).
2. Load storage; skip (warn) if not a `RevisionableStorageInterface`.
3. Load the entity; skip (notice) if it cannot be loaded.
4. `deleteRevisions($entity, $keep)` — for a `TranslatableInterface` entity, loops each
   translation language; otherwise one pass with `langcode = NULL`.
5. `deleteRevisionsByChunk()`: count all revisions for the entity/langcode; if
   `total - keep <= 0`, nothing to do. Otherwise query all revision ids sorted by the
   revision key **DESC**, `range($keep, $remaining)` (skips the newest `$keep`), then
   `deleteRevision($vid)` for each id, in chunks of `REVISION_CHUNK_SIZE = 500`.

The revision query uses `->accessCheck(FALSE)->allRevisions()` — appropriate for this
cron/CLI maintenance context (revision access is not entity-content access). The **current
(default) revision is preserved** because it is among the newest `$keep`.

Errors and skips are logged to the `revision_delete_tools` logger channel.

## Operational notes

- Deletion is **irreversible**; back up before the first production run.
- Clearing the queue before cron runs cancels pending deletions (`drush queue:delete remove_revisions`); anything already processed is gone.
- Runtime cost scales with entity count (one queue item each) and revision count (chunked deletes).
