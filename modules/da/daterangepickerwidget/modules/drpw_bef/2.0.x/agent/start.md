<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DateRangePicker BEF Plugin (drpw_bef) — agent index

Better Exposed Filters sub-module of the **daterangepickerwidget** project. Registers one BEF filter
widget, `bef_daterangepicker`, that puts the jQuery UI date range picker on a standard core Date
exposed filter. Package `Field types`. Core `^10 || ^11`. GPL-2.0-or-later. Version 2.0.x. Depends
on the base module `daterangepickerwidget` and **`better_exposed_filters`** (`^7.0`).

## What it provides

- **BEF filter widget** `bef_daterangepicker` — `DateRangePickerFilter`
  (`src/Plugin/better_exposed_filters/filter/DateRangePickerFilter.php`, extends `FilterWidgetBase`,
  uses `DateRangePickerTrait`). Annotation `@BetterExposedFiltersFilterWidget`. →
  [filter/bef-widget.md](filter/bef-widget.md).

## Facts an agent needs

- `isApplicable()` — offered only when the filter is a core `Date` filter (or has `date_handler`),
  is **not** grouped, and its operator is `between` or `not between`.
- No routes, permissions, services, config schema, Drush, or hooks.
- Client behavior lives in the base module's `js/daterangepicker.js`: it writes the picked range into
  the hidden `min` (`start 00:00:00`) and `max` (`end 23:59:59`) fields.
- Reuses the shared options form and drupalSettings writer from `DateRangePickerTrait`.
