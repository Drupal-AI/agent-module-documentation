# Set / read / query DER values in code

Each field item exposes three properties: `target_id` (int), `target_type` (entity type id
string) and the computed `entity` (the loaded object). The item class extends core's
`EntityReferenceItem`.

## Set a value
```php
// Explicit id + type.
$node->set('field_related', ['target_id' => $user->id(), 'target_type' => 'user']);

// Or hand it an entity object — target_type/target_id are derived.
$node->field_related->entity = $term;

// Multiple mixed values.
$node->set('field_related', [
  ['target_type' => 'node', 'target_id' => 12],
  ['target_type' => 'taxonomy_term', 'target_id' => 5],
]);
$node->save();
```

## Read a value
```php
$item = $node->field_related->first();
$id   = $item->target_id;
$type = $item->target_type;
$referenced = $item->entity;              // loaded entity (or NULL)

foreach ($node->field_related as $item) {
  $entity = $item->entity;
}
$entities = $node->field_related->referencedEntities();  // all, from the item list
```

## Query
Both columns are queryable through the entity query / typed-data API:
```php
$ids = \Drupal::entityQuery('node')
  ->condition('field_related.target_type', 'user')
  ->condition('field_related.target_id', $uid)
  ->accessCheck(TRUE)
  ->execute();
```

- Selection plugins resolve through the `plugin.manager.dynamic_entity_reference_selection`
  service (a subclass of core's entity-reference selection manager) — reuse core selection
  handlers, scoped per target entity type.
- Views: the field exposes the target type and target id, so you can filter/relate on either.
