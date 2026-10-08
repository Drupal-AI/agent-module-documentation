<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BEF Date filters (bef_date_filters) — agent index

Adds ONE **Better Exposed Filters** widget, `bef_year_month_between` ("Year and month for date range"),
for a Views **date "Is between"** exposed filter. It replaces the native min/max date text inputs with a
**Year** select (current year back through ten prior years) and a **Month** select; client-side JS maps the
picked year/month to the hidden min/max date range, so the visitor picks a period instead of typing dates.

- Depends on `better_exposed_filters` (which brings Views). Core `^10 || ^11`.
- No settings page (`configure` is null), no routes, no permissions, no services, no `config/`.
- The widget is selected per exposed filter in the Views UI, under that filter's BEF settings.

Solutions:
- **Enable / understand the year-month range widget** → [plugins/year_month_widget.md](plugins/year_month_widget.md)

Key facts:
- Plugin: `@BetterExposedFiltersFilterWidget` id `bef_year_month_between`, class
  `Drupal\bef_date_filters\Plugin\better_exposed_filters\filter\YearMonthBetween` (extends BEF `FilterWidgetBase`).
- `isApplicable()`: Views `filter\Date` handler (or any filter with a `date_handler`) that is **not** a grouped filter.
- Adds elements `year_between` and `month_between` (both `#type: select`); hides the filter's native `min`/`max` inputs (`visually-hidden`).
- Library `bef_date_filters/year-month-between` (deps `core/drupal`, `core/once`); JS behavior `befDateFilterYearMonthBetween`.
- `drupalSettings.bef_date_filters.ids[]` holds each target filter's field id (underscores → dashes).
- The widget defines no options of its own — nothing beyond BEF's standard widget advanced settings.
