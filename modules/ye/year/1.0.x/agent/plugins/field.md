# Year — field type, widgets, formatter, Feeds target

## Field type `year` (`YearItem` extends `NumericItemBase`)

- Storage schema: one column `value`, `int`, `unsigned`, normal length.
- `default_widget = year_default`, `default_formatter = year_default`, `list_class = YearFieldItemList`.
- `defaultFieldSettings()`: `min => 1900`, `max => ''`.
- Property: `value` integer, required.

### Field settings form (`fieldSettingsForm`)
- `min` — number, required. Minimum valid year (integer > 0).
- `max` — textfield, required. Either a specific year **or** a PHP relative-time expression
  (`now`, `+5 years`, …) — see php.net relative formats. Resolved to a year with
  `strtotime()` + `date('Y')` in `calculateYear()`.

### Validation (`getConstraints`)
Adds two `ComplexData`→`Range` constraints on `value`: a `min` bound and a `max` bound, using the
resolved `getYearRange()` (`min` cast to int, `max` resolved from the possibly-relative string).

### Default value
`YearFieldItemList::defaultValuesForm()` exposes a "Default year" textfield that also accepts a
relative expression (e.g. `now`, `+5 years`); validated against min/max in
`defaultValuesFormValidate()`.

## Widgets

- **`year_default`** (`YearDefaultWidget`, label "Textfield") — a `textfield` with a
  "Enter a year from @min to @max" description. `YearWidgetBase::getFieldSettings()` resolves a
  relative `max` to a concrete year for the description.
- **`year_select`** (`YearSelectWidget`, label "Select list") — a `select` whose options are
  `range(min, max)`. Extra setting `sort_order` (`asc` default | `desc`); descending reverses the
  option list. `#required` follows the field definition. Schema:
  `field.widget.settings.year_select` (`sort_order`).

## Formatter

- **`year_default`** (`YearDefaultFormatter`) — renders each item as `#type => markup` of the stored
  integer value (values are validated unsigned integers, so no markup concern).

## Feeds target

`src/Feeds/Target/Year.php` provides a Feeds target so the field can be mapped and populated during
a Feeds import.

## Config schema highlights (`year.schema.yml`)

- `field.field_settings.year`: `min` (integer), `max` (string).
- `field.value.year`: `value` (string).
- `field.storage_settings.year`: `unsigned` (bool), `size` (string).
