<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# currency_field field type, widget & formatter

## Install
`composer require drupal/currency_field` then `drush en currency_field`. No config import, no
permissions, no settings page.

## Add the field
Manage fields → Add field → "Currency" (`currency_field`). Then:
- **Manage form display** → the "Currency widget" (`currency_widget`) renders a `select`.
- **Manage display** → the "Currency formatter" (`currency_formatter`) prints the stored string.

## Storage: one string column
`CurrencyField::schema()` defines a single column `value` of type `varchar` length `255`.
`propertyDefinitions()` marks `value` a required string. `isEmpty()` is true when `value` is `NULL`
or `''`. So the field stores exactly one currency identifier as text — whatever column the `display`
setting selects (see below) — not a numeric amount.

## The `display` storage setting
`defaultStorageSettings()` sets `display => 'Currency'`. `storageSettingsForm()` exposes a required
`select` titled "Value to show while selecting" with three options:
- `AlphabeticCode` → "Alphabetic Code" (e.g. `USD`)
- `Entity` → "Country Name" (e.g. `UNITED STATES OF AMERICA`)
- `Currency` → "Currency Name" (e.g. `US Dollar`)

This single setting drives **both** the option labels and the stored value. In
`CurrencyWidget::formElement()` the widget calls
`currency_field_currency_options(!$element['#required'], ['AlphabeticCode' => $display])`, meaning
options are keyed by `AlphabeticCode` and labelled by the chosen `$display` column. Note: because
`array_combine` keys options by `AlphabeticCode`, distinct rows that share the same alphabetic code
(e.g. every country using `EUR`) collapse to one option, and the submitted/stored `value` is the
alphabetic code — the label just reflects the chosen column for that code's row. The blank first
option is added only when the field is **not** required (`!$element['#required']`).

## Formatter output
`CurrencyFormatter::viewValue()` returns `nl2br(Html::escape($item->value))` per item — the raw
stored string, HTML-escaped, with newlines converted to `<br>`. There are no formatter settings
(`defaultSettings()`, `settingsForm()`, `settingsSummary()` are stubs).

## Plugin wiring
The `@FieldType` annotation sets `default_widget = "currency_widget"` and
`default_formatter = "currency_formatter"`, so the widget/formatter are pre-selected when the field
is added. `generateSampleValue()` returns a random `AlphabeticCode` for content generation.
