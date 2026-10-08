<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enum Field (enum_field) — agent index

Defines two list-field types, **`enum_string`** ("Enum (text)") and **`enum_integer`**
("Enum (integer)"), whose allowed values come from a **backed PHP enum class** instead of an
`allowed_values` list typed into field settings. A computed `enum` property hands custom code
the actual `\BackedEnum` case rather than the stored scalar. Depends on core `options`. Requires
**PHP 8.1** (`php: 8.1`). Core `^9.3 || ^10 || ^11`. No settings page (`configure` null), no
permissions, no config schema.

- **The field types, the `enum_class` storage setting, options derivation, widget/formatter,
  validation** → [fields/enum-fields.md](fields/enum-fields.md)
- **Reading the enum case in code, `getOptions()`, the list↔enum Migration service** →
  [api/enum-api.md](api/enum-api.md)
- **`drush field:create --enum-class=…` integration** → [drush/field-create.md](drush/field-create.md)
- **The `enum_field` Views filter (swapped in for enum columns)** → [views/enum-filter.md](views/enum-filter.md)

Key facts:
- Field type ids: `enum_string` (extends core `ListStringItem`), `enum_integer` (extends
  `ListIntegerItem`). Both: `category = "selection_list"`, `default_widget = "options_select"`,
  `default_formatter = "list_default"`, `list_class = EnumItemList`. No custom widget/formatter —
  the module registers its types as compatible with every `list_string`/`list_integer` one via
  `hook_field_widget_info_alter` / `hook_field_formatter_info_alter`.
- Single storage setting `enum_class` (a `\BackedEnum` FQN); the core `allowed_values` /
  `allowed_values_function` settings are unset. Set through the field storage form (`enum_class`
  textfield, validated by `EnumItemTrait::validateEnumClass`) or `drush field:create --enum-class`.
- Options = `[$case->value => $case->label() ?? $case->name]` for each `$enumClass::cases()`
  (`EnumItemTrait::getOptions()`).
- Computed property `enum` (class `Drupal\enum_field\ComputedEnum`): `$item->enum` /
  `$entity->get('field')->enum` returns the `\BackedEnum` (via `tryFrom`); list method
  `EnumItemList::enums()` returns them keyed by delta.
- Migration service id `enum_field.migration` (class `Drupal\enum_field\Migration`):
  `migrateListField()` / `migrateEnumField()` convert a field storage between list and enum in place.
- Views filter plugin id `enum_field` (`Drupal\enum_field\Plugin\views\filter\EnumField`), auto-swapped
  onto enum columns by `hook_views_data_alter`; update hook `enum_field_update_80012` retrofits it.
