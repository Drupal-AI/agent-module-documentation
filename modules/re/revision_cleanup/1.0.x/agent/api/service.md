<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cleanup service API

Service id `revision_cleanup.revision_cleanup_service` →
`Drupal\revision_cleanup\Services\RevisionCleanupService`. Injected:
`entity_type.manager`, `database`, `logger.channel.revision_cleanup`, `config.factory`,
`module_handler`, `queue`. Cron is the normal caller, but the public method can be called directly.

## Public methods

| Method | Signature | Behavior |
|--------|-----------|----------|
| `addEntitiesToQueue` | `(int $keep_revisions_newer_than_in_days, int $number_of_revisions_to_keep_per_month): int` | Builds the delete set for entity type `node`, calls `deleteQueue()` on `revision_cleanup_processor` to clear stale items, enqueues one item per node that has vids to delete, and returns the number of entities examined. |
| `getEntities` | `(string $entity_type, int $days, int $per_month): array` | Returns `[$id => ['entity_type','id','vids'=>[vid=>vid,...],'default_vids'=>[...]]]`. `vids` is every revision id **minus the ones to keep**; `default_vids` are the protected ids. |

`getDefaultRevisionId()` and `revisionsToKeep()` are `private`.

Call it directly (e.g. from a custom drush command / hook):

```php
$service = \Drupal::service('revision_cleanup.revision_cleanup_service');
$count = $service->addEntitiesToQueue(90, 1); // then: drush queue-run revision_cleanup_processor
```

## How the delete set is computed

Only entity type **`node`** is processed (`$entity_type = 'node'` is hardcoded in
`addEntitiesToQueue`; the `getEntities`/`revisionsToKeep` SQL targets `node_revision` /
`node_field_revision`). For each node:

- `vids` starts as every revision id (`revisionIds()`).
- **Keep set** = union of:
  - **Per month:** group revisions by `nid`, `langcode`, `%Y-%m` (of `revision_timestamp`, over rows
    with `revision_translation_affected = 1`); keep the `revisions_per_month` newest vids in each
    group. Skipped when `revisions_per_month == 0`.
  - **Recent:** every revision with `revision_timestamp >= now - days_to_keep*86400`. Skipped when
    `days_to_keep == 0`.
  - Whatever `hook_revisions_cleanup_keep_alter` adds — see [../hooks/keep_alter.md](../hooks/keep_alter.md).
- The keep set is removed from `vids`, leaving the delete candidates.
- `default_vids` (never deleted, enforced again in the worker) = per translation language: the latest
  translation-affected revision id, the loaded entity's current revision id, and the default/current
  revision id (`->currentRevision()` query). So the published/default revision and each language's
  newest revision are always protected.

Timezone: when `use_site_timezone` is set, both the month bucket (`CONVERT_TZ`) and the day cutoff are
shifted to `system.date` `timezone.default`; otherwise UTC.

The worker `RevisionCleanUpQueueProcessor::processItem($data)` iterates `$data['vids']` and calls
`EntityStorage::deleteRevision($vid)` for each vid not in `$data['default_vids']`.
