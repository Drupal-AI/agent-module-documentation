<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# YMD Date field type, widget & formatter

## Install & enable

```bash
composer require drupal/ymd_date
drush en ymd_date -y
```

No hard module dependencies (`.info.yml` declares none); the field type builds on core Field API.
No permissions, no config-install objects, no update/install hook.

## Storage format (the key idea)

`src/Plugin/Field/FieldType/YMDDateFieldItem.php`:

- `schema()` — one column `value`, `type => 'int'`, `length => 50`, plus an index on `value`.
  Note the **property** is defined as a `string` in `propertyDefinitions()` ("Date value"), so the
  value is handled as a fixed-width string even though the DB column is integer.
- The stored value is an **8-character `YYYYMMDD` string**. Unknown month and/or day are stored as
  `00`: `18470000` = year 1847, `19120300` = March 1912, `20240115` = 15 Jan 2024. Zero-padding
  keeps values sortable as plain strings/ints.
- `setValue()` — when the widget submits a `ymd_date` sub-array it concatenates
  `year . month . day` into `value` before storing.
- `isEmpty()` — a value of `NULL`, `''` **or `'00000000'`** counts as empty.
- `defaultFieldSettings()` — `begin_year => ''`.
- `fieldSettingsForm()` — one **required** textfield **`begin_year`** ("Beginning year", size 6):
  the lowest year offered by the widget's year select.

## Widget — `ymd_date_field_widget_default`

`src/Plugin/Field/FieldWidget/YMDDateFieldWidgetDefault.php` (extends `WidgetBase`,
injects `date.formatter`). This is the field type's **default widget**.

`formElement()` builds a `container-inline` fieldset `ymd_date` with three `select`s:

- **year** — options from `yearOptions($begin)` = `range($begin, date('Y'))`; empty option
  `['0000' => '--']`. `$begin` comes from the `begin_year` field setting; if empty or non-numeric
  it falls back to **1900**.
- **month** — `monthOptions()` = `01`…`12`, labels are full month names via
  `dateFormatter->format(gmmktime(0,0,0,$month,2,1970),'custom','F')`; empty option `['00' => '--']`.
- **day** — `dayOptions()` = `01`…`31`; empty option `['00' => '--']`.

Current values are split back into the three selects with
`preg_match('@(\d{4})(\d{2})(\d{2})@', $value, $match)`. Leaving month or day as `--` stores `00`
there (year-only or year+month precision).

## Formatter — `ymd_date_field_formatter_default`

`src/Plugin/Field/FieldFormatter/YMDDateFieldFormatterDefault.php` (extends `FormatterBase`,
injects `date.formatter`, the `date_format` entity storage, and `logger.factory`). This is the
field type's **default formatter**.

- `defaultSettings()` — three settings, each a **core date-format machine name**:
  `format_type_year_only` = `html_year`, `format_type_year_month` = `html_month`,
  `format_type_ymd` = `html_date`.
- `settingsForm()` — three `select`s populated from all `date_format` config entities
  (`dateFormatStorage->loadMultiple()`), each shown with a live sample of the current time.
- `settingsSummary()` — shows a formatted sample for each of the three precisions.
- `viewElements()` — for each item, `preg_match('@(\d{4})(\d{2})(\d{2})@', $item->value, $match)`
  extracts year/month/day. Month and day are only used when not `00`. It then chooses the format:
  year-only value → `format_type_year_only`; year+month → `format_type_year_month`; full →
  `format_type_ymd`. It builds a `DrupalDateTime::createFromArray($values)` (wrapped in try/catch;
  failures are logged to the `ymd_date` logger channel) and renders
  `#markup => dateFormatter->format($date->getTimestamp(), $format_type, '', NULL)`.

Because the value is reduced to digits by the regex before a date is built, and the output comes
from core's `DateFormatter` using an admin-selected `date_format`, the rendered markup is a plain
formatted date string.

## Config schema (`config/schema/ymd_date.schema.yml`)

- `field.value.ymd_date_field_type` — default-value **sequence** of `{ value: string }`.
- `field.field_settings.ymd_date_field_type` — `begin_year` typed as `list_integer`.
- `field.formatter.settings.ymd_date_field_formatter_default` — the three format-type `label`s.

## Configure it (UI + config)

1. *Structure → (bundle) → Manage fields → Add field* → **YMD Date** (type
   `ymd_date_field_type`).
2. On the field settings, set **Beginning year** (required) — the earliest year in the widget.
3. *Manage form display* uses the **YMD Date** widget automatically.
4. *Manage display* uses the **YMD Date** formatter; open the gear to pick the three date formats.

Example formatter settings in a view display:

```yaml
# core.entity_view_display.node.article.default
content:
  field_event_date:
    type: ymd_date_field_formatter_default
    label: above
    settings:
      format_type_year_only: html_year
      format_type_year_month: html_month
      format_type_ymd: html_date
```

The three format machine names must be existing `date_format` entities (core ships `html_year`,
`html_month`, `html_date`, or use your own).
