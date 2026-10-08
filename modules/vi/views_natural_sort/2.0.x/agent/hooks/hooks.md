<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks (`views_natural_sort.api.php`)

Four hooks let you widen what is naturally sortable and change how strings are normalized.

## `hook_views_natural_sort_supported_properties_alter(array &$supported_properties)`

Add (or remove) entity properties eligible for natural sorting. Auto-detection only covers integer-id
entities' `string` base properties, so use this for configured fields or edge cases.

```php
function my_module_views_natural_sort_supported_properties_alter(array &$supported_properties) {
  $supported_properties['node']['field_vns_field'] = [
    'base_table' => 'node__field_vns_field',
    'schema_field' => 'field_vns_field_value',
  ];
}
```

After adding a property, its Views sort must resolve to id `natural` for it to actually index; rebuild
the index afterward.

## `hook_views_natural_sort_transformations_alter(array &$transformations, IndexRecord $record)`

Change the transformation pipeline for a given record (e.g. a different pipeline for a particular
entity type / field, or to inject a custom `IndexRecordContentTransformation` plugin).

```php
function my_module_views_natural_sort_transformations_alter(array &$transformations, $record) {
  if ($record->getEntityType() === 'user' && $record->getField() === 'timezone') {
    $transformations = ['timezone']; // use only your custom 'timezone' transformation plugin
  }
}
```

## `hook_views_natural_sort_get_entry_types()`

Return the `IndexRecordType` objects (entity_type + property) the module should index. The module's own
implementation derives these from `getViewsSupportedEntityProperties()`. Implement to limit or extend
the set considered during a rebuild.

## `hook_views_natural_sort_queue_rebuild_data(IndexRecordType $entry_type)`

Provide/alter the queue population for a rebuild of a given entry type. The module's implementation
queues every entity id of that type into the `views_natural_sort_entity_index` queue worker. Implement
to customize which entities get requeued.

## Related non-hook extension points

- Transformation **plugins**: `@IndexRecordContentTransformation` (see
  [../plugins/transformations.md](../plugins/transformations.md)).
- Plugin-definition alter: `views_natural_sort_vns_transformation_info`.
- Queue worker: `views_natural_sort_entity_index` (processes `['entity_type', 'entity_id']` items during
  a rebuild).
