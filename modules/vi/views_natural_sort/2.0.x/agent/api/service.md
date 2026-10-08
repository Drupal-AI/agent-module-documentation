<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `views_natural_sort.service` API

Service id `views_natural_sort.service` → `\Drupal\views_natural_sort\ViewsNaturalSortService`.
It decides what is sortable, builds `IndexRecord`s, and drives reindexing.

## Key methods

- `getSupportedEntityProperties()` — scans every entity type whose id key is an **integer** and
  collects its `string` base/field properties (skipping keys like bundle, uuid, uid, revision, …),
  returning `[entity_type => [property => ['base_table' => …, 'schema_field' => …]]]`. Runs
  `hook_views_natural_sort_supported_properties_alter()`.
- `getViewsSupportedEntityProperties()` — narrows the above to properties Views actually exposes with a
  sort whose id is `natural` (i.e. those the module upgraded). This is the authoritative "what gets
  indexed" list.
- `storeIndexRecordsFromEntity(EntityInterface $entity)` — for each supported property on the entity,
  creates and saves an `IndexRecord` (one per delta) into the `views_natural_sort` table. Called from
  `hook_entity_insert`/`hook_entity_update`.
- `createIndexRecord(array $values)` — builds an `IndexRecord` and attaches the current transformation
  pipeline (`getTransformations()`), which applies `hook_views_natural_sort_transformations_alter()`.
- `getTransformations($record)` / `getDefaultTransformations()` — the enabled transformation plugin
  instances (see [../plugins/transformations.md](../plugins/transformations.md)).
- `queueDataForRebuild(array $entry_types = [])` / `finishRebuild()` — set up the reindex batch.

## Indexing lifecycle (module hooks)

`views_natural_sort.module` wires the table to entity events:

- `hook_entity_insert` / `hook_entity_update` → `service->storeIndexRecordsFromEntity($entity)` (only
  for entity types present in the supported list).
- `hook_entity_delete` → `views_natural_sort_remove(['eid' => …, 'entity_type' => …])` deletes the
  entity's rows (optionally scoped by `field`/`delta`; omitting them is a wildcard delete).
- `hook_module_implements_alter` forces this module's `views_data_alter` to run **last** so it sees
  final Views data before swapping `standard` → `natural`.

## `IndexRecord`

`\Drupal\views_natural_sort\IndexRecord` (constructed with the DB connection + values `eid`,
`entity_type`, `field`, `delta`, `content`):

- `getTransformedContent()` — applies each transformation in order, then `mb_substr(…, 0, 255)`.
- `save()` — `MERGE` into `views_natural_sort` keyed by `(eid, entity_type, field, delta)`, writing the
  transformed `content`.
- `delete()` — delete that row.

## Programmatic examples

```php
$service = \Drupal::service('views_natural_sort.service');

// What will be indexed/sortable naturally on this site:
$props = $service->getViewsSupportedEntityProperties();   // e.g. ['node' => ['title' => [...]]]

// Re-index a single entity's rows immediately:
$service->storeIndexRecordsFromEntity(\Drupal\node\Entity\Node::load(123));

// Kick off a full rebuild batch (e.g. from a form/drush php:eval within a batch context):
$service->queueDataForRebuild();
```

Reading a stored value:

```bash
drush php:eval '
  $rows = \Drupal::database()->select("views_natural_sort", "v")->fields("v")
    ->condition("entity_type", "node")->condition("field", "title")
    ->execute()->fetchAll();
  foreach ($rows as $r) { print $r->eid . " => " . $r->content . "\n"; }
'
```
