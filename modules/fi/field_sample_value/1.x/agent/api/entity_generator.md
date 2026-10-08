<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity generator service, field config & the "prevent save" constraint

## The service

`field_sample_value.generator` → `SampleValueEntityGenerator`
(`src/SampleValueEntityGenerator.php`, interface `SampleValueEntityGeneratorInterface`). Injects
`entity_type.manager`, `entity_type.bundle.info`, `plugin.manager.field_sample_value`.

```php
/** @var \Drupal\field_sample_value\SampleValueEntityGeneratorInterface $gen */
$gen = \Drupal::service('field_sample_value.generator');

// Create a fully populated (unsaved) entity.
$node = $gen->createWithSampleValues('node', 'article', ['title' => 'Demo']);

// Or populate an entity you already built.
$gen->populateWithSampleValues($node);

// Or a single field item list.
$gen->populateWithSampleValue($node->get('field_summary'));
```

### `createWithSampleValues(string $entity_type_id, ?string $bundle = NULL, array $values = [])`
Resolves the entity type; if it has a bundle key, a `$bundle` is **required** and must exist,
else it throws `EntityStorageException` ("No entity bundle was specified" / "…does not exist").
Sets the bundle into `$values`, `create()`s the entity, populates it, and **returns it unsaved**
(the caller decides whether to `save()`).

### `populateWithSampleValues(FieldableEntityInterface $entity)`
Iterates every field definition and calls `populateWithSampleValue()` on each field item list.

### `populateWithSampleValue(FieldItemListInterface $field)`
Core of the module:
1. Calls `_field_sample_value_field_definition_has_generator_configured($field_definition)` —
   true only for a `FieldConfigInterface` whose `field_sample_value` third-party settings have a
   non-empty `id`. **If false, returns immediately and leaves the field untouched** (no generator
   configured ⇒ real default/emptiness respected).
2. Reads `third_party_settings.field_sample_value` (`id` + `configuration`), instantiates the
   generator via the manager, and calls `generateSampleValue($field)`.
3. If `generator->shouldPreventSave()` is true, stores a clone of the generated field on
   `$field->getEntity()->_sampleValues[$field_name]` for the constraint (see below).

## How the field config is written (the UI)

`field_sample_value.module`:

- `field_sample_value_form_field_config_edit_form_alter()` — on the **field_config_edit_form**,
  gets applicable generators for the field type; if any, adds a **"Set sample value"** checkbox
  and a **"Sample value"** details group containing a radios element (`sample_value[id]`) of
  generator labels plus, per generator, a container with that generator's
  `buildConfigurationForm()` subform (shown/hidden by `#states` on the selected radio). Adds a
  custom `#validate` and `#submit` handler.
- `field_sample_value_form_field_config_validate()` — if "Set sample value" is off, clears the
  third-party `id`/`configuration`. Otherwise requires a generator (`setErrorByName` if missing),
  runs the chosen generator's `validateConfigurationForm()`, and copies the selected id +
  that generator's configuration into
  `third_party_settings.field_sample_value.{id, configuration}`.
- `field_sample_value_form_field_config_submit()` — runs the chosen generator's
  `submitConfigurationForm()`.
- `_field_sample_value_get_typed_data()` builds a clean typed-data object for the field
  (via `EntityAdapter` + `typedDataManager()->create()`) so config subforms always render from a
  fresh state; it is set as the `field_item_list` context on each generator.

The result is stored as ordinary, exportable field config, e.g.:

```yaml
# field.field.node.article.field_summary.yml (excerpt)
third_party_settings:
  field_sample_value:
    id: random_text
    configuration:
      prevent_save: true
      count: '2'
      filter_format: basic_html
```

## Config schema

`config/schema/field_sample_value.schema.yml` defines
`field.field.*.*.*.third_party.field_sample_value`:

| Key | Type | Meaning |
|---|---|---|
| `id` | string | Selected generator plugin ID. |
| `configuration.prevent_save` | boolean | Block save while the generated value is unchanged. |
| `configuration.count` | string | Word/sentence/paragraph count for the text generators. |
| `configuration.filter_format` | string | Filter format for `random_text`. |

No `config/install`, no settings route, so `data.json.configure` is null.

## The "prevent save" constraint

- `hook_entity_bundle_field_info_alter()` (`field_sample_value_entity_bundle_field_info_alter`)
  adds the **`SampleValue`** constraint to every field definition that has a generator configured.
- `SampleValueConstraint` (id `SampleValue`, message *"The %name field contains automatically
  generated sample values."*) + `SampleValueConstraintValidator`.
- The validator does nothing unless the field is non-empty **and** the entity has a stashed
  `_sampleValues[$field_name]` (only set when `prevent_save` is on and the value was generated).
  If the current field value still `equals()` the stashed generated value, it adds a violation —
  so validation fails until an editor changes the placeholder. Changing the value clears the
  violation.

## Operating notes

- Nothing runs automatically on normal content creation: entities only get sample values when code
  calls the `field_sample_value.generator` service. The module just makes the per-field choice and
  the constraint available.
- `createWithSampleValues()` returns an **unsaved** entity; call `->save()` yourself if you want it
  persisted.
- `entity_reference` generation only picks **published** entities of the configured target bundles
  and uses an access-checked query, so unpublished/inaccessible entities are never referenced.
