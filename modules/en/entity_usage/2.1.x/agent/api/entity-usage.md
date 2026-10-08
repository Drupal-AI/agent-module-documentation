# Read/write usage data in code

Service `entity_usage.usage` (`Drupal\entity_usage\EntityUsageInterface`).

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

- `listSources($target_entity, $nest_results = TRUE, $limit = 0)` — all sources pointing at a
  target. Pass `$nest_results = FALSE` for a flat indexed array of raw DB rows.
- `listTargets($source_entity, $vid = NULL)` — all targets referenced by a source (optionally
  one revision).
- `registerUsage($target_id, $target_type, $source_id, $source_type, $source_langcode,
  $source_vid, $method, $field_name, $count = 1)` — add/update a record (`$count <= 0`
  deletes). Honors settings and `hook_entity_usage_block_tracking()`.
- `deleteBySourceEntity()`, `deleteByTargetEntity()`, `deleteByField($source_type,
  $field_name)`, `bulkDeleteSources($source_type)`, `bulkDeleteTargets($target_type)` — removal.
- `listTargetEntitiesByFieldAndMethod(...)` — targets for one source field + method.

- Deprecated (removed in 3.0): `listUsage()`, `listReferencedEntities()` — use
  `listSources()` / `listTargets()`.
- Usage data can also be exposed in **Views** (see `entity_usage.views.inc`).
- Related service: `entity_usage.entity_update_manager` orchestrates tracking on entity
  create/update/delete; the `plugin.manager.entity_usage.track` manager runs the plugins.
