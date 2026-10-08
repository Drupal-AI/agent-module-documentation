<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Month Year Range (month_year_range) — agent index

Provides two **form widgets** (not a field type of its own) that let editors pick a date at
**month + year** (or **year only**) granularity instead of a full day. It ships no field type, no
formatter and no storage: values are stored and displayed by core `datetime` / `datetime_range`.
Each widget renders core `datelist` selects whose `#date_part_order` is reduced to `['year','month']`
(or `['month','year']`, or `['year']`), then in `massageFormValues()` fills in the missing day —
first or last day of the month, configurable — and formats the value to `Y-m-d` (for a
date-only field) or `Y-m-d\TH:i:s` (for a datetime field) before it is saved.

Two widgets: `month_year_range` targets the core **`daterange`** field type (extends
`datetime_range`'s `DateRangeDatelistWidget`) and handles a start + end value; `month_year_datetime`
targets the core **`datetime`** field type (extends `datetime`'s `DateTimeDatelistWidget`) and
handles a single value. You select a widget per field on the entity's **Manage form display** page —
there is no site-wide settings page. Each widget adds its own settings on top of the inherited
datelist settings.

- Depends on: `drupal:datetime`, `drupal:datetime_range` (both core).
- Core: `^8 || ^9 || ^10 || ^11`. Package: `Field types`.
- No settings page / `configure` route. Configuration is **per field widget** (form display).
- No permissions, no services, no routes, no drush, no plugin types, **no config schema** (widget
  settings are not backed by a `*.schema.yml`).
- Only hook: `hook_help()` on `help.page.month_year_range`.

## What you'd do → where

- **Turn a `daterange` or `datetime` field into a month/year (or year-only) picker, and set day
  handling / year range / part order** → [fields/widgets.md](fields/widgets.md)

## Key facts (real machine names)

- Field widgets:
  - `month_year_range` — field type `daterange`,
    `src/Plugin/Field/FieldWidget/MonthYearRangeWidget.php`, extends
    `Drupal\datetime_range\Plugin\Field\FieldWidget\DateRangeDatelistWidget`.
    Settings: `date_order` (`YM`|`MY`|`Y`, default `YM`), `year_range` (default `''`),
    `day_option_start` (`first`|`last`, default `first`), `day_option_end` (`first`|`last`,
    default `last`) + inherited datelist settings.
  - `month_year_datetime` — field type `datetime`,
    `src/Plugin/Field/FieldWidget/MonthYearDatetimeWidget.php`, extends
    `Drupal\datetime\Plugin\Field\FieldWidget\DateTimeDatelistWidget`.
    Settings: `date_order` (`YM`|`MY`|`Y`, default `YM`), `year_range` (default `''`),
    `day_option` (`first`|`last`, default `first`) + inherited datelist settings.
- Render element used: core `datelist` with `#date_part_order` and (when `year_range` is set)
  `#date_year_range`.
- No routes, services, permissions, drush commands, config schema, or plugin types.
