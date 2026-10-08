# Field type: reference_value_pair

`\Drupal\reference_value_pair\Plugin\Field\FieldType\ReferenceValuePair`, id `reference_value_pair`.
It **extends core `EntityReferenceItem`**, so it is a normal entity-reference field with one extra
column: a required scalar `value`. The reference half behaves exactly like core entity reference
(selection handlers, autocreate, `ValidReference` constraint, config dependency calc).

```
@FieldType(
  id = "reference_value_pair",
  default_widget = "reference_value_autocomplete_widget",
  default_formatter = "reference_value_formatter",
  list_class = "\Drupal\Core\Field\EntityReferenceFieldItemList"
)
```

## Properties (`propertyDefinitions()`)

| Property    | Type                     | Notes |
|-------------|--------------------------|-------|
| `value`     | string (DataDefinition)  | Required. `case_sensitive` mirrors the storage setting. |
| `target_id` | integer (unsigned) or string | `integer` when the target entity's ID base field is integer; else `string`. |
| `entity`    | computed entity reference | Computed from `target_id`; `EntityType` constraint on `target_type`. |

## Stored columns (`schema()`)

| Column      | DB type | Detail |
|-------------|---------|--------|
| `target_id` | `int` unsigned, **or** `varchar_ascii` | int when target ID is integer & fieldable; otherwise varchar_ascii (length 255, or `EntityTypeInterface::BUNDLE_MAX_LENGTH` when the target is a bundle-of entity). |
| `value`     | `varchar` or `varchar_ascii` | `varchar_ascii` iff `is_ascii` TRUE. `length` = `max_length`. `binary` = `case_sensitive`. |

Index: `target_id` on the `target_id` column.

## Storage settings (`defaultStorageSettings()`, on the "Field storage" tab)

| Key             | Default | Meaning |
|-----------------|---------|---------|
| `max_length`    | `255`   | Max characters of the `value` column (also caps the widget textfields). Locked once the field has data. |
| `is_ascii`      | `FALSE` | Store `value` as ascii varchar. |
| `case_sensitive`| `FALSE` | Binary (case-sensitive) storage/compare of `value`. |
| `target_type`   | `node` if node module exists, else `user` | Entity type the reference points to. Locked once the field has data. |

The storage form (`storageSettingsForm()`) exposes only `max_length` and `target_type`
(a `number` and a `select` of entity-type labels); both are `#disabled` when `$has_data`.

## Field settings (`defaultFieldSettings()`, on the "Field" tab)

| Key                | Default   | Meaning |
|--------------------|-----------|---------|
| `handler`          | `default` | Entity-reference selection plugin group. |
| `handler_settings` | `[]`      | Selection-handler config (target bundles, sort, auto_create, etc.). |

`fieldSettingsForm()` reuses the core entity-reference selection-handler UI (reference method +
handler settings, with the same AJAX process/validate helpers as core).

## Constraints (`getConstraints()`)

- Inherits the parent entity-reference constraints, then **removes** `AllowedValuesConstraint`
  (entity references already validate via `ValidReference`).
- Adds a `ComplexData` → `Length` constraint on `value` (`max` = `max_length`) with message
  `"%name: may not be longer than @max characters."`.
- The autocomplete widget additionally enforces "reference required when a value is provided"
  at form level — see [widgets.md](widgets.md).

## Runtime behavior worth knowing

- `isEmpty()` → TRUE only when BOTH the reference is empty (`isEntityEmpty()`) AND `value` is
  `NULL`/`''`. So a delta needs a reference *and* a value to be stored.
- `preSave()` saves an autocreated referenced entity and back-fills `target_id`, matching core
  entity-reference autocreate behavior.
- `calculateDependencies()` / `calculateStorageDependencies()` / `onDependencyRemoval()` track the
  target entity type's provider module and referenced-bundle config, same as core entity reference.
- `getPreconfiguredOptions()` returns `[]` (no "Reference: <entity type>" shortcuts in the field
  add UI; you always pick the type via storage settings).

## Set up a field with Drush/PHP

The field is configured through standard `field_storage_config` / `field_config` entities — nothing
module-specific. Example (attach to nodes of bundle `article`, referencing taxonomy terms):

```php
\Drupal\field\Entity\FieldStorageConfig::create([
  'field_name' => 'field_rvp',
  'entity_type' => 'node',
  'type' => 'reference_value_pair',
  'settings' => ['target_type' => 'taxonomy_term', 'max_length' => 255],
  'cardinality' => -1,
])->save();
\Drupal\field\Entity\FieldConfig::create([
  'field_name' => 'field_rvp',
  'entity_type' => 'node',
  'bundle' => 'article',
  'settings' => ['handler' => 'default', 'handler_settings' => ['target_bundles' => ['tags' => 'tags']]],
])->save();
```

Then assign a widget (`reference_value_autocomplete_widget` or `reference_value_select`) on the
form display and `reference_value_formatter` on the view display.

## Feeds integration

Provides a Feeds target plugin (id `reference_value_pair`, class `…\Feeds\Target\ReferenceValuePair`,
extends `FieldTargetBase`) that exposes both properties for mapping:

```php
FieldTargetDefinition::createFromFieldDefinition($field_definition)
  ->addProperty('target_id')
  ->addProperty('value');
```

Feeds is NOT a dependency; the target only activates when the contrib Feeds module is installed.

## Config schema keys

`field.storage_settings.reference_value_pair` (`max_length`, `is_ascii`, `case_sensitive`,
`target_type`) and `field.field_settings.reference_value_pair` (`handler`,
`handler_settings` → `entity_reference_selection.default`).
