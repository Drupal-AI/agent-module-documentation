<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Read/write usage data in code

Service `entity_usage.usage` (`Drupal\entity_usage\EntityUsageInterface`, class
`Drupal\entity_usage\EntityUsage`, backed by the `entity_usage` DB table).

```php
/** @var \Drupal\entity_usage\EntityUsageInterface $usage */
$usage = \Drupal::service('entity_usage.usage');

// Where is $media used? (sources referencing this target)
$sources = $usage->listSources($media);        // nested: [source_type][source_id][] = record
// [ 'node' => [ 123 => [ ['source_langcode'=>'en','source_vid'=>'128',
//   'method'=>'entity_reference','field_name'=>'field_image','count'=>'1'] ] ] ]

// What does $node reference? (targets of this source)
$targets = $usage->listTargets($node);         // optional 2nd arg: $vid
```

Key methods on `EntityUsageInterface`:

- `listSources(EntityInterface $target_entity, $nest_results = TRUE, int $limit = 0)` — all
  sources pointing at a target. Pass `$nest_results = FALSE` for a flat indexed array of raw DB
  rows. Only rows with `count > 0` are returned; the query is tagged `entity_usage_list_sources`.
- `listTargets(EntityInterface $source_entity, $vid = NULL)` — all targets referenced by a
  source (optionally one revision). Query tagged `entity_usage_list_targets`.
- `registerUsage($target_id, $target_type, $source_id, $source_type, $source_langcode,
  $source_vid, $method, $field_name, $count = 1): void` — add/update a record via a `merge()`
  (`$count <= 0` deletes via `delete()`). Honors `track_enabled_target_entity_types` and
  `hook_entity_usage_block_tracking()`, and dispatches `Events::USAGE_REGISTER`.
- `deleteBySourceEntity()`, `deleteByTargetEntity()`, `deleteByField($source_type,
  $field_name)`, `bulkDeleteSources($source_type)`, `bulkDeleteTargets($target_type)`,
  `truncateTable()` — removal (each dispatches its own event).
- `listTargetEntitiesByFieldAndMethod($source_id, $source_entity_type_id, $source_langcode,
  $source_vid, $method, $field_name)` — `"$type|$id"` targets for one source field + method.
- Bulk path (`EntityUsageBulkInterface`): `enableBulkInsert(?string $table)`, `isBulkInserting()`,
  `bulkInsert()` — buffer inserts and flush in one query (used by the batch rebuild against the
  `entity_usage_bulk` staging table). Entities with non-integer or >10-digit IDs are stored in
  the `*_id_string` columns.

- Deprecated (removed in 3.0): `listUsage()`, `listReferencedEntities()` — use
  `listSources()` / `listTargets()`.
- Usage data can also be exposed in **Views** (see `entity_usage.views.inc`).
- Related services: `entity_usage.entity_update_manager` (`EntityUpdateManager`) orchestrates
  tracking on entity create/update/delete; `plugin.manager.entity_usage.track` runs the
  plugins; `entity_usage.batch_manager` (`EntityUsageBatchManager`) rebuilds everything. URL
  changes are recorded via `PreSaveUrlRecorder` + `UrlToEntity` and the
  `Events::URL_TO_ENTITY` event.
