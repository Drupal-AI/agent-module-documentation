<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Quick pickers

## Widget — `facets_form_date_range_extended` (`DateRangeExtendedWidget`)
Extends `DateRangeWidget`, so all base config (`date_type`, `label.from/to`, `date_format.*`) and the
`facets_form_date_range` query type apply unchanged. This widget adds **only** UI presets — no new
query behavior.

## Config (`facet.widget.config.facets_form_date_range_extended`)
Extends the base date-range schema with an `extended_filters` mapping of four booleans:
- `extended_filter_this_week`
- `extended_filter_this_month`
- `extended_filter_last_week`
- `extended_filter_last_month`

Shown in the widget config form as a "Enable quick filters" details group of checkboxes.

## Preset computation (`getExtendedFiltersSettings()`)
For each enabled preset a `min`/`max` is computed from `DrupalDateTime` relative expressions and
formatted with the site's `html_date` pattern:
- this-week → `monday this week midnight` … `sunday this week midnight`
- this-month → `first day of this month midnight` … `last day of this month midnight`
- last-week → `monday last week midnight` … `sunday last week midnight`
- last-month → `first day of last month midnight` … `last day of last month midnight`

## Render (`build()` / `buildExtendedFilters()`)
When at least one preset is enabled, a `#type => radios` element (wrapper class
`ff-date-range-filters-list`) is added inside the facet fieldset. Each option carries
`data-date-range-min` / `data-date-range-max` and row/item classes
(`ff-date-range-filters-row`, `ff-date-range-filter-item`). If the current active range equals a
preset's min/max, that radio is preselected (`#default_value`). The library
`facets_form_date_range_extended/extended-filters` is attached.

## JS (`js/facets_form_date_range_extended.js`, `core/drupal` + `core/once`)
Behavior `dateRangeExtendedFilters` scoped to
`[data-drupal-facets-form-widget="facets_form_date_range_extended"]`:
- Choosing a preset radio copies its `data-date-range-min`/`-max` into the `#<facet>-from-date` /
  `#<facet>-to-date` inputs.
- Changing/blurring the date inputs re-checks whichever preset matches the current values.
No server round-trip until the form is submitted (then the base widget's `prepareValueForUrl()` /
query type handle it).
