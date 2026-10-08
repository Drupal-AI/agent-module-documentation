# Field Tools — services (call these instead of the UI)

Four public services do the real work. Get them with `\Drupal::service('<id>')` or inject them.
Defined in `field_tools.services.yml`.

## `field_tools.field_cloner` — `\Drupal\field_tools\FieldCloner`

```php
$cloner = \Drupal::service('field_tools.field_cloner');
$field = \Drupal\field\Entity\FieldConfig::loadByName('node', 'article', 'field_foo');
$cloner->cloneField($field, 'node', 'page');
```

`cloneField(FieldConfigInterface $field_config, string $destination_entity_type_id, string $destination_bundle): void`

- Duplicates the `FieldConfig` onto the destination bundle (`createDuplicate()` + set `bundle`, save).
- If the **destination entity type differs** from the source: it reuses an existing
  `field_storage_config` of the same name **if the field type matches**, otherwise creates a new
  storage; if a storage of that name exists with a **different type** it throws `FieldException`.
- After saving, it copies the field's **form and view display settings** onto destination displays
  whose **view-mode name matches** the source (`copyDisplayComponents()` for both
  `entity_form_display` and `entity_view_display`). Displays/modes absent on the destination are skipped.
- The caller is expected to ensure no field of that name already exists on the destination bundle.

## `field_tools.display_cloner` — `\Drupal\field_tools\DisplayCloner`

`cloneDisplay(EntityDisplayBase $source_entity_display, string $destination_bundle): void`

Clones/merges a whole form or view display into another bundle of the **same entity type**. Fields on
the source but not the target are ignored; fields on both are overwritten; fields only on the target
are left untouched.

## `field_tools.display_settings_copier` — `\Drupal\field_tools\DisplaySettingsCopier`

`copyDisplaySettings(FieldDefinitionInterface $field_definition, EntityDisplayBase $source_entity_display, string $destination_bundle): void`

Copies **one field's** widget/formatter settings from a single source display to the matching-named
display on another bundle.

## `field_tools.references.info` — `\Drupal\field_tools\FieldToolsReferencesInfo`

Read-only introspection over reference fields (powers the references report).

- `getReferenceFields(bool $include_files = TRUE, bool $include_owner = TRUE, bool $include_config_targets = FALSE): FieldDefinitionInterface[]`
  — keys look like `ENTITY_ID:BUNDLE:FIELD_NAME`; mixes base and config fields.
- `getReferenceFieldStorages(): array`
- `getReferencedTypes(FieldStorageDefinitionInterface $storage): string[]` — target entity type ids.

## Also available

- `field_tools.field_options` — `FieldOptions`: builds field/bundle select options for the forms.
- `field_tools.config_importer_factory` — used by the Multiple import form.

There is **no Drush command**; scripting is done by calling these services from `drush php:eval`.
