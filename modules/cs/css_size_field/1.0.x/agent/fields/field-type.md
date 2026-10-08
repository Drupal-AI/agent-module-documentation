<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `css_size` field type, widget, formatter, and element

## Install & enable

```bash
composer require drupal/css_size_field
drush en css_size_field -y
```

No dependencies beyond Drupal core; no submodules, permissions, Drush commands, or admin config
page. Core `^10 || ^11 || ^12`.

## The field type — `CssSizeItem`

`src/Plugin/Field/FieldType/CssSizeItem.php`, `#[FieldType(id: 'css_size', …)]`,
`default_widget: css_size_default`, `default_formatter: css_size_default`.

Properties (`propertyDefinitions()`) and storage columns (`schema()`):

| Property | Type | Storage column |
|---|---|---|
| `number` | string | `numeric`, precision 19, scale 6 |
| `unit`   | string | `varchar(255)`, default `''` |

- `mainPropertyName()` returns `NULL` (no single main property — always the pair).
- `isEmpty()` → TRUE when `number` is `NULL`/`''` **or** `unit` is empty.
- `getConstraints()` adds a `ComplexData` constraint applying `Regex`
  `/^[+-]?((\d+(\.\d*)?)|(\.\d+))$/i` to `number` (signed integer or decimal, incl. leading-dot
  like `.5`). Note: **`unit` has no field-level constraint** — via the Field API a caller could set
  an arbitrary unit string; the widget/element restricts it to the known list, and validity can be
  enforced in code with `SizeUnit::assertExists()`.

Add it via UI: *Structure → (bundle) → Manage fields → Add field → "CSS Size"*. There are no
field-storage or field-instance settings beyond the standard ones (the storage/value schema
mappings in `config/schema/css_size_field.schema.yml` are empty/minimal).

## The widget — `CssSizeDefaultWidget`

`src/Plugin/Field/FieldWidget/CssSizeDefaultWidget.php`, `id: css_size_default`, label *Default*,
`field_types: ["css_size"]`.

`defaultSettings()`:

| Setting | Default | Meaning |
|---|---|---|
| `default_unit` | `''` | Pre-selected unit for a new/empty value. |
| `available_units` | `[]` | Units to offer in the selector. Empty = **all** units. |

- `settingsForm()`: `default_unit` is a single `select`; `available_units` is a multiple `select`
  (size 10) with the description *"Select the units to display, selecting none will display all."*
  Both use `SizeUnit::getLabels()` as options.
- `settingsSummary()`: shows *"Default unit: …"* (when set) and *"Available units: All"* or the
  comma-joined list.
- `formElement()`: when the item is empty, seeds `number = NULL` and `unit = default_unit`, then
  builds a `#type: css_size` element with `#default_value => $items[$delta]->getValue()`. If
  `array_filter(available_units)` is non-empty it passes them as `#available_units`.

Config-schema for these settings lives at `field.widget.settings.css_size_default`
(`default_unit` string, `available_units` sequence of strings).

## The formatter — `CssSizeDefaultFormatter`

`src/Plugin/Field/FieldFormatter/CssSizeDefaultFormatter.php`, `id: css_size_default`, label
*Default*, `field_types: ["css_size"]`.

`viewElements()` loops the items and emits, per delta:

```php
$element[$delta] = ['#markup' => "{$item->number}{$item->unit}"];
```

i.e. the number and unit concatenated into a CSS length string (e.g. `20px`). It is `#markup`, so
core applies its admin XSS filter at render time. There are no formatter settings
(`field.formatter.settings.css_size_default` is an empty mapping). Select it on *Manage display*.

## The reusable form element — `CssSize`

`src/Element/CssSize.php`, `#[FormElement('css_size')]`. Use it in any form (config forms, custom
build forms) without the Field API:

```php
$form['size'] = [
  '#type' => 'css_size',
  '#title' => $this->t('Size'),
  '#default_value' => ['number' => '1.90', 'unit' => 'px'],
  '#size' => 60,          // passed to the number sub-input
  '#maxlength' => 128,    // passed to the number sub-input
  '#available_units' => ['px', 'rem'], // optional; [] or omitted = all units
  '#required' => TRUE,
];
```

Behavior (`getInfo()` / `processElement()`):

- `#available_units` defaults to `[]` (all units); must be an array or `processElement()` throws
  `\InvalidArgumentException('The #available_units key must be an array.')`.
- A `#default_value`, if given, must be an array with **both** `number` and `unit` keys
  (`validateDefaultValue()`), else throws; a non-empty `unit` is checked with
  `SizeUnit::assertExists()`.
- Sets `#tree = TRUE`; adds class `form-type-css-size`. Builds a child `number` (`#type: number`)
  and a `unit` element.
- **Single available unit** → `unit` becomes `#type: value` and its label is shown as the number
  input's `#field_suffix` (no dropdown). **Multiple** → `unit` is a `#type: select` of the
  filtered `SizeUnit::getLabels()`, with the current default kept selectable.
- Attaches library `css_size_field/widget` (the widget CSS). The submitted value is the tree
  `['number' => …, 'unit' => …]`.

## The unit value class — `SizeUnit`

`src/SizeUnit.php`, `final class SizeUnit implements UnitInterface`
(`src/UnitInterface.php`). Constants → values:

`CENTIMETER=cm`, `MILLIMETER=mm`, `QUARTER_MILLIMETER=Q`, `INCH=in`, `PICAS=pc`, `POINT=pt`,
`PIXEL=px`, `RELATIVE_ELEMENT=em`, `RELATIVE_ROOT_ELEMENT=rem`, `VIEWPORT_WIDTH=vw`,
`VIEWPORT_HEIGHT=vh`, `PERCENT=%`.

Static API:

- `getLabels()` — array of translated labels keyed by unit (used for all option lists).
- `getAllUnits()` — flat array of every unit string.
- `assertExists($unit)` — throws `\InvalidArgumentException` if `$unit` is not one of the twelve
  (message text says *"Invalid weight unit …"* — a copy-paste artifact; it is a CSS size unit).

`UnitInterface` declares `getLabels()` and `assertExists()`, so alternate unit sets can be provided
by implementing it.

## Config-schema summary

`config/schema/css_size_field.schema.yml`:

- `field.storage_settings.css_size` — empty mapping.
- `field.value.css_size` — `number` (string), `unit` (string).
- `field.widget.settings.css_size_default` — `default_unit` (string), `available_units` (sequence
  of strings).
- `field.formatter.settings.css_size_default` — empty mapping.

## Notes / caveats

- The default formatter emits raw `#markup`; it is admin-XSS-filtered by core, but if you place the
  value directly into a CSS context (inline `style`, a CSS custom property) in your own template,
  sanitize/whitelist as appropriate for that context — CSS injection rules differ from HTML.
- The `number` column is `numeric(19,6)`; values are validated as decimals by the regex constraint
  but stored/formatted as their string form, so trailing precision is whatever was entered.
- Only the widget/element restrict `unit`; there is no field-storage list of allowed units, so
  programmatic writes bypass the unit list unless you call `SizeUnit::assertExists()`.
