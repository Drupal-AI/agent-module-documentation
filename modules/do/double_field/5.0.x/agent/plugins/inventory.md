<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin inventory

The module **defines no plugin types of its own** — it supplies instances of core plugin types.
Drupal 11.3 **PHP attributes** are used throughout (`#[FieldType]`, `#[FieldWidget]`,
`#[FieldFormatter]`, `#[Hook]`), not annotations, and every plugin id is exposed as a
`public const string ID` on its class.

## Field type

| id | Class | Label | default_widget | default_formatter |
|---|---|---|---|---|
| `double_field` | `Plugin\Field\FieldType\DoubleField` (final) | Double Field | `double_field` | `double_field_unformatted_list` |

- Properties: `first`, `second`. `mainPropertyName()` returns **NULL**.
- `subfieldTypes()` → the ten storage types (`boolean`, `string`, `text`, `integer`, `float`,
  `numeric`, `email`, `telephone`, `datetime_iso8601`, `uri`).
- `isListAllowed($type)` → TRUE for all of those **except** `boolean` and `text`.
- Class constants: `DATETIME_STORAGE_TIMEZONE = 'UTC'`,
  `DATETIME_DATETIME_STORAGE_FORMAT = 'Y-m-d\TH:i:s'`, `DATETIME_DATE_STORAGE_FORMAT = 'Y-m-d'`.
- Implements `generateSampleValue()` (devel-generate friendly) and `createDate($subfield)`.
- `fieldSettingsToConfigData()` / `fieldSettingsFromConfigData()` reshape `allowed_values`
  between the flat runtime array and the `{value, label}` sequence stored in config.

## Widget

| id | Class | Label |
|---|---|---|
| `double_field` | `Plugin\Field\FieldWidget\DoubleField` (final) | Double Field |

Renders one sub-widget per subfield. The legal sub-widget list is computed by
`getSubWidgets($storage_type, $list)` — see the matrix in
[configure/field-and-display.md](../configure/field-and-display.md). `select` and `radios` are
prepended whenever that subfield's `list` setting is on. `isLabelSupported()` returns FALSE only
for `checkbox`.

## Formatters

All extend `Plugin\Field\FieldFormatter\Base` (which holds the shared per-subfield settings,
`prepareItems()` and `numberFormat()`); the two list formatters extend `ListBase`, which adds
`inline`.

| id | Class | Label | Renders via |
|---|---|---|---|
| `double_field_unformatted_list` | `UnformattedList` | Unformatted List | `#theme: double_field_item` per delta |
| `double_field_html_list` | `HtmlList` | HTML List | `item_list` (`ul`/`ol`) or `#theme: double_field_definition_list` (`dl`) |
| `double_field_details` | `Details` | Details | core `details` element; `first` → `#title`, `second` → `#value` |
| `double_field_table` | `Table` | Table | core `table` element |

`Base::prepareItems()` is where the per-subfield display logic happens, in order: `hidden` blanks
the value; a `boolean` becomes its `on_label`/`off_label`; numeric types go through
`number_format()`; a `datetime_iso8601` becomes a `#theme: time` element (converted to the site
timezone for `datetime`, left in UTC for `date`); a `list` value is swapped for its label unless
`key` is on; and `link` turns `email`/`telephone`/`uri` into `mailto:` / `tel:` / external links.

## Constraints

The module defines **no constraint plugin classes**. `DoubleField::getConstraints()` composes
core/Symfony constraints (`AllowedValues`, `Length`, `Range`, `NotBlank`, `NotEqualTo`) into a
single `ComplexData` constraint. `NotEqualTo` is not normally available as a Drupal constraint
plugin, so `Hook\Core\ValidationConstraintAlter` registers Symfony's class into the definition
list via `hook_validation_constraint_alter()`.

## Hooks implemented (all `#[Hook]` attribute classes under `src/Hook/`)

| Hook | Class | Purpose |
|---|---|---|
| `theme` | `Hook\Theme\Theme` | registers `double_field_item`, `double_field_definition_list` |
| `theme_suggestions_double_field_item` | `ThemeSuggestionsDoubleFieldItem` | `double_field_item__<field_name>` |
| `theme_suggestions_double_field_definition_list` | `ThemeSuggestionsDoubleFieldDefinitionList` | `double_field_definition_list__<field_name>` |
| `theme_suggestions_table_alter` | `ThemeSuggestionsTableAlter` | `table__double_field__<field_name>` |
| `theme_suggestions_item_list_alter` | `ThemeSuggestionsItemListAlter` | `item_list__double_field__<field_name>` |
| `theme_suggestions_details_alter` | `ThemeSuggestionsDetailsAlter` | `details__double_field__<field_name>` |
| `field_storage_config_update` | `Hook\Entity\FieldStorageConfigUpdate` | warns when a subfield's storage type changed |
| `validation_constraint_alter` | `Hook\Core\ValidationConstraintAlter` | registers `NotEqualTo` |

There is **no `double_field.api.php`** — the module invites no hooks of its own.

## Service provider

`DoubleFieldServiceProvider` sets the parameter `double_field.skip_procedural_hook_scan` to TRUE
and manually autowires the two `initial preprocess` classes
(`PreprocessDoubleFieldItem`, `PreprocessDoubleFieldDefinitionList`), which carry no `#[Hook]`
attribute and so are not auto-discovered. The module registers **no ordinary services** — there
is nothing to inject or decorate.

## Feeds integration (optional)

`src/Feeds/Target/DoubleField.php` is a `@FeedsTarget` (still annotation-based — Feeds ships no
attribute yet) with id `double_field`, adding `first` and `second` as mappable properties. It is
inert unless the contrib Feeds module is installed.
