<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Facets Form Date Range Extended — agent index

Adds the `facets_form_date_range_extended` widget: the base date-range widget plus one-click quick
pickers (This week, This month, Last week, Last month). Subclass of `DateRangeWidget`; **reuses** the
`facets_form_date_range` query type — no new filtering logic. Depends on `facets_form_date_range`.
No config page, no permissions, no Drush. Ships config schema.

- **Quick-picker config, how presets are computed, and the JS wiring** →
  [configure/quick-pickers.md](configure/quick-pickers.md)

Key facts:
- `DateRangeExtendedWidget extends DateRangeWidget`; adds config group `extended_filters` with 4
  booleans: `extended_filter_this_week` / `_this_month` / `_last_week` / `_last_month`.
- Enabled presets render as a `radios` element with `data-date-range-min`/`-max` (computed from
  `DrupalDateTime` relative strings, `html_date` pattern); library
  `facets_form_date_range_extended/extended-filters` (`core/drupal`, `core/once`) syncs radios ↔
  From/To inputs.
- Config schema extends `facet.widget.config.facets_form_date_range`.
