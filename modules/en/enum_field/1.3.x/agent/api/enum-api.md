<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Developer API: reading enum cases & migrating fields

## Getting the enum case out of a field

The whole point of the module: consuming code gets a typed `\BackedEnum`, not a scalar.

Each field item gains a computed property `enum` (defined in
`EnumItemTrait::propertyDefinitions()` as a `DataDefinition::create('any')`, computed, class
`Drupal\enum_field\ComputedEnum`). Access it directly on an item, or on the field (first-delta
magic):

```php
$case  = $entity->get('field_status')->enum;      // \BackedEnum|null (delta 0)
$case  = $entity->get('field_status')[0]->enum;   // same, explicit delta
$cases = $entity->get('field_status')->enums();    // \BackedEnum[] keyed by delta (multi-value)
```

`ComputedEnum::getValue()` resolves lazily: if the stored value is already an instance of the
`enum_class` it is returned; otherwise, for an int/string value and a real `enum_class`, it returns
`$enumClass::tryFrom($value)` — so an unknown/removed stored value yields `null`, not an error. The
result is memoized until `setValue()` is called. `EnumItemList::enums()` (`src/Plugin/Field/FieldType/EnumItemList.php`)
maps `$item->enum` across every delta, preserving keys.

Now `match` over the case with static analysis instead of comparing magic strings:

```php
$label = match ($entity->get('field_status')->enum) {
  Status::Draft     => 'Not live',
  Status::Published => 'Live',
  default           => 'Unknown',
};
```

## Building the option list yourself

`EnumStringItem::getOptions($enumClass)` (from `EnumItemTrait`, also callable on
`EnumIntegerItem`) returns the `[value => label]` map used everywhere. Reuse it in custom forms:

```php
$options = \Drupal\enum_field\Plugin\Field\FieldType\EnumStringItem::getOptions(\App\Enum\Status::class);
```

## Migration service — convert list ⇄ enum in place

Service id **`enum_field.migration`** (also autowire-aliased to the FQN
`Drupal\enum_field\Migration`). Class `src/Migration.php`, constructed with `config.factory`,
`entity_field.manager`, `entity.last_installed_schema.repository`. It rewrites an existing field
storage's `type` between the list and enum variants without deleting data
(`FIELD_TYPE_MAP`: `enum_integer↔list_integer`, `enum_string↔list_string`).

| Method | Direction | Notes |
|---|---|---|
| `migrateListField(string $entityTypeId, string $fieldName)` | `list_*` → `enum_*` | sets storage `module` to `enum_field`; throws `\Exception('Not a list field')` if the source isn't a list type |
| `migrateEnumField(string $entityTypeId, string $fieldName)` | `enum_*` → `list_*` | sets storage `module` to `options`; throws `\Exception('Not an enum field')` otherwise |

Both are no-ops if already the target type. Internally `doMigrateField()` updates the
last-installed schema definitions, clears cached field definitions, rewrites
`field.storage.<entity>.<field>` and every `field.field.<entity>.<bundle>.<field>` config's type,
and recalculates dependencies. Call from an `hook_update_N` / deploy hook:

```php
\Drupal::service('enum_field.migration')->migrateListField('node', 'field_status');
```

After `migrateListField`, set the new field's `enum_class` storage setting (see
`../fields/enum-fields.md`) — migration changes the type, it does not populate `enum_class`.

## Exception

`Drupal\enum_field\Exception\InvalidEnumException extends \InvalidArgumentException` is declared for
integrators but is not thrown by the module's own code paths in this release.
