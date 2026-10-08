<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `daterangepicker` field type, widget and formatter

## Install & enable

```bash
drush en drpw_field -y   # base daterangepickerwidget is enabled automatically as a dependency
```

Then add a **jQuery UI Date Range Picker** field to a bundle (*Manage fields*), keep the default
form widget on *Manage form display*, and pick the format on *Manage display*.

## Field type — `DateRangePickerItem`

`src/Plugin/Field/FieldType/DateRangePickerItem.php`,
`#[FieldType(id: 'daterangepicker', label: 'jQuery UI Date Range Picker', cardinality: 1,
default_widget: 'daterangepicker_default', default_formatter: 'daterangepicker_default',
module: 'drpw_field')]`.

- `schema()` — one column `value`: `varchar` length **255**, `not null => FALSE`.
- `propertyDefinitions()` — a single `value` string property ("Date range value").
- `isEmpty()` — empty when `value` is `NULL` or `''`.
- Stored content is a JSON string: `{"start":"yy-mm-dd","end":"yy-mm-dd"}`.

## Widget — `DateRangePickerDefaultWidget` (id `daterangepicker_default`)

`src/Plugin/Field/FieldWidget/DateRangePickerDefaultWidget.php`, extends `WidgetBase`, uses
`DateRangePickerTrait`, `multiple_values: FALSE`.

- `formElement()` builds a `textfield` (class `daterangepicker`, `autocomplete=off`), attaches
  library `daterangepickerwidget/jquery-ui-daterangepicker`, hard-pins `alt_format = 'yy-mm-dd'`,
  and writes mapped JS options to `drupalSettings.daterangepicker[<field name>]`. It computes the
  drupalSettings key differently in the **field default-value form** (`field_config_edit_form`,
  parents start `default_value_input`) vs a normal entity form. Returns `['value' => $element]`.
- `defaultSettings()` = `DateRangePickerTrait::getDateRangePickerDefaultOptions()` + parent.
- `settingsForm()` renders the shared options form (`buildDateRangePickerOptionsForm()`) and adds
  `validateSettingsForm()` → `validateDateRangePickerOptions()` (enforces
  `step_months <= number_of_months`; inline errors need the `inline_form_errors` module to display
  the message).
- `settingsSummary()` appends `DateRangePickerTrait::getSummary()` lines.

Widget settings are validated by config schema `field.widget.settings.daterangepicker_default`
(`config/schema/drpw_field.schema.yml`): `initial_text`, `apply_button_text`, `clear_button_text`,
`cancel_button_text`, `range_splitter`, `date_format`, `alt_format`, `number_of_months` (int),
`show_week` (bool), `max_date`/`min_date` (string, nullable), `month_dropdown`/`year_dropdown`
(bool), `first_day` (int), `default_date`, `goto_current` (bool), `step_months` (int), `year_range`,
`disable_preset_ranges` (bool).

## Formatter — `DateRangePickerDefaultFormatter` (id `daterangepicker_default`)

`src/Plugin/Field/FieldFormatter/DateRangePickerDefaultFormatter.php`, extends `FormatterBase`.

- `viewElements()` `Json::decode()`s each item's `value`, builds two `DrupalDateTime`s from
  `start`/`end`, and renders `<div class="daterange">` containing a `<time class="daterange_start"
  datetime="Y-m-d">`, the `range_splitter` markup, and a `<time class="daterange_end">`. Displayed
  text uses the configured PHP `date_format`.
- `defaultSettings()` — `date_format => 'j M, Y'`, `range_splitter => ' - '`.
- `settingsForm()` — `date_format` (PHP date format) and `range_splitter` textfields.
- `settingsSummary()` — shows the format, a live example, and the splitter.

Formatter settings schema: `field.formatter.settings.daterangepicker_default` (`date_format`,
`range_splitter`).

## Notes

- `range_splitter` in the formatter is emitted as `#markup` (raw); it is an admin-configured
  formatter setting, not visitor input.
- The widget's `alt_format` / internal storage is fixed at `yy-mm-dd`; changing it breaks stored
  values and the Views handlers.
