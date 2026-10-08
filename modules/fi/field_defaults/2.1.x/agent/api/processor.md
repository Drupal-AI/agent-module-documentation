<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API: the processor service & PreserveChangedItem

## Service `field_defaults.processor`

Class `Drupal\field_defaults\Service\FieldDefaultsProcessor`
(args: `@entity_type.manager`, `@config.factory`). This is the programmatic entry point used
by both the field-edit form and the Drush command.

```php
$processor = \Drupal::service('field_defaults.processor');
$fieldConfig = \Drupal::entityTypeManager()->getStorage('field_config')
  ->load('node.article.field_region');           // a FieldConfigInterface
$fieldValues = $fieldConfig->get('default_value')[0];   // the configured default value
$processor->processFieldForm($fieldConfig, [
  'update_defaults'      => TRUE,
  'update_defaults_lang' => [],      // e.g. ['de' => 'de', 'fr' => 'fr']
  'no_overwrite'         => FALSE,   // TRUE = only fill empty fields
], $fieldValues);
// processFieldForm() calls batch_set(); run the batch (drush_backend_batch_process() /
// batch_process()) to actually save the entities.
```

`processFieldForm(FieldConfigInterface $fieldConfig, array $fieldDefaults, $fieldValues): void`
- Normalises entity-reference values: unwraps `target_id`, and for a `media` handler splits a
  `media:ID` target down to the ID.
- Reads `retain_changed_date` from `field_defaults.settings` into a `$preserve` flag.
- Builds a `BatchBuilder` with one operation (`processEntityBatch`) and a finish callback.

## Batch operation `FieldDefaultsProcessor::processEntityBatch()` (static)

For the field's target entity type + bundle:
- Queries **all** entities of that type/bundle (`accessCheck(FALSE)`), 10 per pass; bundle
  condition is skipped for entity types with no bundle key (e.g. `user`).
- For each entity: sets `$entity->{$fieldName} = $fieldValues` **unless** `no_overwrite` is TRUE
  and the field is already non-empty (`->isEmpty()` gate).
- For each language in `update_defaults_lang` that is checked: does the same on the existing
  translation (only if the translation exists).
- If `$preserve` (retain_changed_date) and the entity has a `changed` field: sets
  `$entity->changed->preserve = TRUE` (and `setSyncing(TRUE)` for `SynchronizableInterface`
  entities) so the changed timestamp is **not** bumped, then `$entity->save()`.

The finish callback reports "Default values were updated for N entities."

## `PreserveChangedItem` (changed-timestamp preservation)

`hook_field_info_alter()` swaps the `changed` field type's class to
`Drupal\field_defaults\Decorated\PreserveChangedItem` (extends core `ChangedItem`). It adds a
`preserve` boolean property; its `preSave()` returns early (skipping the normal timestamp
refresh) when `preserve` is TRUE. This is how "Retain original entity updated time" keeps mass
updates from re-dating content. It applies site-wide once the module is enabled, but only
takes effect when something sets the `preserve` flag (the processor does, when
`retain_changed_date` is on).

## Notes / limits

- `@todo`s in source: no pluggable per-field-type handling yet; batch range (10) is not
  configurable.
- The value applied is always the field's stored `default_value[0]` — there is no API to pass
  an arbitrary ad-hoc value; set the field's default first.
