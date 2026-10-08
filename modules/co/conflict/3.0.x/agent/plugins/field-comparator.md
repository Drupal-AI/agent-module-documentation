<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FieldComparator plugins

Conflict decides whether a field changed / how it conflicts through **FieldComparator** plugins.

- Manager service: **`conflict.field_comparator.manager`**
  (`FieldComparatorManager`, `parent: default_plugin_manager`).
- Discovery dir: `Plugin/Conflict/FieldComparator/`.
- Annotation: `Drupal\conflict\Annotation\FieldComparator`.
- Interface: `Drupal\conflict\FieldComparatorInterface`.
- Default plugin: `conflict_field_comparator_default` (`FieldComparatorDefault`), matching
  `entity_type_id="*"`, `bundle="*"`, `field_type="*"`, `field_name="*"`.

## Annotation properties (targeting)

`id`, and any of `entity_type_id`, `bundle`, `field_type`, `field_name` — each a specific value
or `"*"` (wildcard). The most specific matching comparator wins for a given field.

```php
/**
 * @FieldComparator(
 *   id = "my_geo_comparator",
 *   entity_type_id = "*",
 *   bundle = "*",
 *   field_type = "geolocation",
 *   field_name = "*",
 * )
 */
class MyGeoComparator extends PluginBase implements FieldComparatorInterface { ... }
```

## Interface methods

| Method | Purpose |
|---|---|
| `hasChanged($field_item_list_a, $field_item_list_b, $langcode, $entity_type_id, $bundle, $field_type, $field_name)` | Whether the field value differs between two entity versions. |
| `getConflictType($local, $server, $original, $langcode, $entity_type_id, $bundle, $field_type, $field_name)` | Classify the conflict: returns a `ConflictTypes` constant — `CONFLICT_TYPE_REMOTE` (`conflict_remote`, only the server changed → auto-mergeable) or `CONFLICT_TYPE_LOCAL_REMOTE` (`conflict_local_remote`, both changed → real clash). |

Implement these to give a field type bespoke comparison (e.g. treat semantically-equal values as
unchanged, or force a field to always/never conflict). Place the class in your module's
`src/Plugin/Conflict/FieldComparator/`, add the annotation, and `drush cr`.
