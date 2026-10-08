<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enum field types

Two field types, defined as thin subclasses of core `options` list items that swap out the
`allowed_values` storage setting for a single `enum_class` pointing at a **backed PHP enum**.

## Machine names

| Surface | Machine name | Class / source |
|---|---|---|
| Field type | `enum_string` ("Enum (text)") | `EnumStringItem extends ListStringItem` (`src/Plugin/Field/FieldType/EnumStringItem.php`) |
| Field type | `enum_integer` ("Enum (integer)") | `EnumIntegerItem extends ListIntegerItem` (`src/Plugin/Field/FieldType/EnumIntegerItem.php`) |
| Item list class | (both) | `EnumItemList` (`src/Plugin/Field/FieldType/EnumItemList.php`) |
| Shared logic | (both) | `EnumItemTrait` (`src/Plugin/Field/FieldType/EnumItemTrait.php`) |
| Default widget | `options_select` | core `options` (no custom widget) |
| Default formatter | `list_default` | core `options` (no custom formatter) |
| Annotation category | `selection_list` | (< Drupal 10.2 remapped to "Number"/"Text" by `hook_field_info_alter`) |

The module defines **no widget or formatter of its own**. `enum_field.module`
`hook_field_widget_info_alter()` and `hook_field_formatter_info_alter()` append `enum_integer` to
every widget/formatter that lists `list_integer`, and `enum_string` to every one that lists
`list_string`. So all core options widgets (`options_select`, `options_buttons`) and formatters
(`list_default`, `list_key`) work on enum fields unchanged; output escaping is core's.

## The `enum_class` storage setting

`EnumItemTrait::defaultStorageSettings()` starts from the parent list settings, adds
`enum_class` (default `''`), and **unsets** `allowed_values` and `allowed_values_function`. So an
enum field has exactly one distinctive setting: `enum_class`, the fully-qualified name of a backed
enum (e.g. `App\Enum\Status`).

Configure it via the field storage settings form — `storageSettingsForm()` renders an `enum_class`
textfield ("Backed enum class to get the allowed values from") — or non-interactively (see
`../drush/field-create.md`, or set the storage config directly):

```php
\Drupal\field\Entity\FieldStorageConfig::create([
  'field_name' => 'field_status',
  'entity_type' => 'node',
  'type' => 'enum_string',            // or 'enum_integer'
  'settings' => ['enum_class' => \App\Enum\Status::class],
])->save();
```

### Validation

`EnumItemTrait::validateEnumClass()` is an `#element_validate` on the textfield. An empty value is
allowed; otherwise it errors unless BOTH hold: `enum_exists($enumClass)` is true, and
`is_a($enumClass, \BackedEnum::class, TRUE)` is true. A pure (non-backed) enum or a missing class is
rejected — the stored scalar must round-trip through the case's `value`.

### Config schema

The module ships **no `config/schema/`**. `enum_class` inherits no dedicated schema key; it rides
on the core field-storage settings mapping.

## Allowed values / options

`EnumItemTrait::getOptions(string $enumClass): array` is the single source of the option set. For a
valid backed enum it returns `[$case->value => $label]` over `$enumClass::cases()`, where `$label`
is `$case->label()` if the enum defines a `label()` method, otherwise `$case->name`. An invalid or
empty `enum_class` yields `[]`. It backs `getSettableOptions()` (the widget option list),
`generateSampleValue()` (devel-generate picks `array_rand()`), and the Views filter.

Give the enum a `label()` method for human-readable, translatable option labels:

```php
enum Status: string {
  case Draft = 'draft';
  case Published = 'published';
  public function label(): string {
    return match ($this) {
      self::Draft => (string) t('Draft'),
      self::Published => (string) t('Published'),
    };
  }
}
```

## Setting values

`EnumItemTrait::setValue()` accepts a `\BackedEnum` (or array of them) and stores each `->value`
before delegating to the parent, so `$item->setValue(Status::Draft)` and
`$item->value = 'draft'` are equivalent. Reading the case back is covered in `../api/enum-api.md`.
