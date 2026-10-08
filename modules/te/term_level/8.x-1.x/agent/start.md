<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Term level field (term_level) — agent index

One **field type** that stores a **taxonomy term reference plus an integer level** in a single
field item. Package `Taxonomy`. Depends only on core **`taxonomy`**. Core requirement
`^9.1 || ^10 || ^11`. License GPL-2.0-or-later. Version 8.x-1.x. No permissions, no routes, no
Drush, no hooks, no config UI of its own — everything is configured through the standard Field UI.

- **The field type, widget, formatter, level-list format, storage settings, config schema and HAL
  normalizer** → [fields/term_level.md](fields/term_level.md)

## What it provides (from source)

- **Field type** `term_level` — `src/Plugin/Field/FieldType/TermLevelItem.php`, extends core
  `EntityReferenceItem`. `defaultStorageSettings()` forces `target_type => taxonomy_term` and adds
  a `levels` string setting. Adds a `level` property/column (unsigned int, indexed) next to
  `target_id`. `default_widget = term_level_widget`, `default_formatter = term_level_formatter`,
  `category = "reference"`, `list_class = EntityReferenceFieldItemList`.
- **Widget** `term_level_widget` — `src/Plugin/Field/FieldWidget/TermLevelWidget.php`, extends
  `EntityReferenceAutocompleteWidget`. Renders the term autocomplete plus a **Level `<select>`**
  whose options come from the field's `levels` setting.
- **Formatter** `term_level_formatter` — `src/Plugin/Field/FieldFormatter/TermLevelFormatter.php`,
  extends `EntityReferenceLabelFormatter`. After each term label it appends ` : <level label>`
  when the stored level key still exists in the field settings.
- **HAL normalizer** `term_level.normalizer` — `src/Normalizer/TermLevelItemNormalizer.php`
  (service, priority 100), extends `hal`'s `FieldItemNormalizer`. Adds `level` to normalized HAL
  output. Only usable when the **`hal`** module is installed (it is not a declared dependency).
- **Config schema** — `config/schema/term_level.data_types.schema.yml` defines
  `field.storage_settings.term_level` (`levels` text), `field.field_settings.term_level`, and
  `field.value.term_level` (adds `level` int).

## Levels format

Storage setting `levels` is a textarea, one line per level as `level-key|label`, where `level-key`
must be a positive integer (validated by `TermLevelItem::validateLevels()` /
`preg_match('/^\d+$/')`). `TermLevelItem::extractLevels()` parses it into `[key => label]`. The
field stores the numeric key; the label is looked up for display and is re-resolved from settings
so renamed/removed levels degrade gracefully. See [fields/term_level.md](fields/term_level.md).
