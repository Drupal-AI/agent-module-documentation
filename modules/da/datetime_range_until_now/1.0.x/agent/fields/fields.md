<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Until now" Date Range field

This module has no config page. Everything is done in the Field UI on a Date Range field, plus the
`until_now` storage setting. There are two field types in play but they resolve to the same classes.

## Two ways it applies

1. **Retrofit of core Date Range (primary).** `datetime_range_until_now.module` rebinds core's own
   plugins to this module's classes, so an existing/new core **Date Range** (`daterange`) field gains
   the option with no field-type change:
   - `datetime_range_until_now_field_info_alter()` → `daterange` type class becomes
     `DateRangeUntilNowItem` (`.module:13`).
   - `datetime_range_until_now_field_widget_info_alter()` → `daterange_default` widget class becomes
     `DateRangeUntilNowWidget` (`.module:31`). Note: the docblock above it mislabels the hook as
     `hook_field_formatter_info_alter`, but the function name makes it a widget-info-alter — it fires
     correctly.
   - `datetime_range_until_now_field_formatter_info_alter()` → `daterange_default` formatter class
     becomes `DateRangeUntilNowFormatter` (`.module:22`).
2. **Standalone field type `daterange_until_now`.** Selectable in the field UI as "Date range until
   now"; `default_widget = daterange_until_now`, `default_formatter = daterange_default` (which is the
   swapped class). Same runtime behavior as the retrofit.

## Enable the option (storage setting)

The boolean storage setting is `until_now`. Enable it on *Field storage* / *Manage fields → the field
→ Field settings* — the checkbox is labelled "Provide until now"
(`DateRangeUntilNowItem::storageSettingsForm()`, item file `:106`). Defaults to `FALSE`
(`defaultStorageSettings()`, `:37`). Config schema: `field.storage_settings.daterange` adds
`until_now: boolean` (`config/schema/datetime_range_until_now.schema.yml`). The settings form also
adds an "All Day" option (`DATETIME_TYPE_ALLDAY = 'allday'`) to `datetime_type`.

From code, set it on a field storage:

```php
$storage = \Drupal\field\Entity\FieldStorageConfig::loadByName('node', 'field_period');
$storage->setSetting('until_now', TRUE)->save();
```

## Data model

`DateRangeUntilNowItem` extends core `DateTimeItem` and defines (`propertyDefinitions()`, `:47`):
`value` (start, required), `start_date` (computed), `end_value` (end, **not** required), `end_date`
(computed), and `until_now` (`any`, "Provide Until now option"). `schema()` (`:79`) adds:

| Column | Type | Notes |
|---|---|---|
| `end_value` | datetime | `not null` set to FALSE (nullable), indexed |
| `until_now` | `int` `tiny` | `not null`, default `0`, indexed |

`isEmpty()` (`:144`) treats the item empty only when the **start** `value` is null/empty — an ongoing
row with no end is therefore never dropped as empty.

## Widget — the "Until now" checkbox

`DateRangeUntilNowWidget` (extends `DateRangeWidgetBase`). `formElement()` (`:59`) sets
`$element['end_value']['#required'] = FALSE` and appends an `until_now` checkbox
(`#type => checkbox`, `#title => "Until now"`, `#default_value => $items->until_now`, `:100`). It
injects the html_date/html_time formats and, for `datetime_type` of `date`/`allday`, drops the time
element. Constructor injects the `date_format` entity storage via `entity_type.manager`.

## Formatter — rendering "Until now"

`DateRangeUntilNowFormatter` (extends `DateTimeDefaultFormatter`, uses `DateTimeRangeTrait`). Adds one
setting `separator` (default `-`) via `settingsForm()`/`settingsSummary()` (`:42`, `:58`).
`viewElements()` (`:71`) branches per item:

- `until_now` truthy → `start_date` + `separator` + an `end_date` rendered as a `#theme => 'time'`
  element whose `#text` is `t('Until now')`, cache-context `timezone` (`:84`).
- otherwise, if a distinct `end_date` exists → normal `start – end` (`:99`).
- otherwise → just the start date (`:106`).

Output looks like `01.01.2022 - Until now`. Because "now" is decided at render, an ongoing field is a
live statement — the `timezone` cache context is the only expiry hint, so if you later add a real end
date be sure the render cache clears.

## Install / update behavior

- `hook_install()` (`datetime_range_until_now.install:13`) walks every existing `daterange`
  `field_storage_config`, then for each of its storage tables (from
  `entity.storage_schema.sql` key/value) makes `<field>_end_value` nullable and **adds**
  `<field>_until_now` (tinyint, default 0) via `Database::schema()->changeField()`/`addField()`, and
  writes the updated schema back to key/value. This migrates fields created before the module existed.
- `hook_update_8001()` (`.install:48`) re-saves any `daterange` field storage whose `until_now`
  setting is not yet a boolean, normalizing older configs.
