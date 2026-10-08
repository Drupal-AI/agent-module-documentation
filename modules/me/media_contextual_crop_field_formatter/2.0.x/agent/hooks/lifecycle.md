<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks: crop cleanup, value alter, and the 1.x→2.x update

All in `media_contextual_crop_field_formatter.module` unless noted. These hooks keep `crop` entities
(from the `crop` module, via `media_contextual_crop`) consistent with the state of the referencing
field, and integrate with `media_library_media_modify` on save.

## `hook_help` — `media_contextual_crop_field_formatter_help()`

Only the `help.page.media_contextual_crop_field_formatter` route: a short About block, linking to the
`advanced_help` page if that module is enabled, otherwise to the drupal.org project.

## `..._referenced_entity_values_alter()` — value alter on save

Implements `hook_media_library_media_modify_referenced_entity_values_alter(&$values, $fields, $referenced_entity)`
(a hook owned by `media_library_media_modify`). For each field and each delta of the referenced
entity, it loops the **crop-adapter** definitions from `plugin.manager.media_contextual_crop`, and
for any item that has the adapter's `target_field_name` key it calls the adapter class's static
`processFieldData()`:

```php
$data = $plugin['class']::processFieldData($item[$target_field]);
if ($data != NULL) {
  $values[$field_name][$key][$target_field] = $data;   // normalise/keep
}
else {
  unset($values[$field_name][$key][$target_field]);     // drop empty crop data
}
```

So the adapter decides how its raw crop widget value is stored on the per-reference override.

## `hook_entity_update` — `media_contextual_crop_field_formatter_entity_update()`

Runs for any `FieldableEntityInterface`. Finds the entity's `entity_reference_entity_modify` fields
(helper below); for each, loads every `crop` whose `context` starts with this entity+field's base
context, then per crop:

- derives the reference `delta` from the crop's `context` (strip the base context);
- loads the referenced `Media` at that delta;
- if the media is gone, or the crop's `entity_id` no longer matches the media's current image
  source value, or the delta is now beyond the field's item count → `$crop->delete()`.

This is what prevents orphaned/stale crops after an editor reorders, removes, or swaps a referenced
media item. (Note: the `!$media` branch calls `return` rather than `continue`, so it stops processing
further crops for that field on the first missing media.)

## `hook_entity_delete` — `media_contextual_crop_field_formatter_entity_delete()`

For any `FieldableEntityInterface`: for each `entity_reference_entity_modify` field, load all crops
matching the base context and delete every one — cleaning up crops when the host entity is deleted.

## Private helpers

- `_media_contextual_crop_field_formatter_get_media_contextual_fields(FieldableEntityInterface $entity): array`
  — returns the names of the entity's fields whose type is `entity_reference_entity_modify`.
- `_media_contextual_crop_field_formatter_get_base_context(EntityInterface $entity, string $field_name): string`
  — builds `"{entity_type_id}:{bundle}:{id}.{field_name}."` (the crop `context` prefix; the per-item
  `delta` is appended by the crop pipeline).
- `_media_contextual_crop_field_formatter_get_crops_from_entity_field(EntityInterface $entity, $field_name): Crop[]`
  — `entityQuery('crop')` with `context LIKE "{base}%"`, `accessCheck(FALSE)`, then
  `Crop::loadMultiple()`.

## Update hook (`.install`)

`media_contextual_crop_field_formatter_update_10103(&$sandbox)` — one-time upgrade for sites coming
from 1.x. Scans every `core.entity_view_display.*` config; any field using the removed formatter
`media_contextual_crop_image` is switched to core `image`, the display is re-saved, and a full cache
flush is triggered if anything changed. This is why 2.0.x ships no formatter plugin: the crop is now
applied through the `references` use case and the crop pipeline rather than a dedicated formatter.
