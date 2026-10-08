<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Facets Form Date Range Extended adds a "Date range with quick filters (inside form)" facet widget that extends the plain date-range widget with one-click predefined ranges — This week, This month, Last week, Last month.

---

The submodule provides the `facets_form_date_range_extended` Facets widget (`DateRangeExtendedWidget`), a subclass of `facets_form_date_range`'s `DateRangeWidget`, so it inherits all From/To picker behavior, config (date type, labels, summary format) and the same `facets_form_date_range` query type — it adds no new query logic. Its extra config is an "Enable quick filters" details group with four checkboxes (`extended_filter_this_week`, `extended_filter_this_month`, `extended_filter_last_week`, `extended_filter_last_month`). When any are enabled, `build()` injects a `radios` element of the enabled presets next to the date fields, each carrying `data-date-range-min`/`data-date-range-max` computed from `DrupalDateTime` relative expressions (e.g. "monday this week midnight") formatted with the `html_date` pattern, and attaches the `facets_form_date_range_extended/extended-filters` JS library. That vanilla JS (`core/drupal` + `core/once`) wires the radios to the From/To inputs: choosing a preset fills the date fields, and editing the date fields re-highlights a matching preset. The active preset is preselected server-side when the current range matches. Depends on `facets_form_date_range`.

---

- Give users one-click "This week" / "This month" date filters in a facets form.
- Add "Last week" / "Last month" quick pickers to a date-range facet.
- Let editors filter recent content without manually typing two dates.
- Enable only the quick presets you want per facet via four config checkboxes.
- Keep full manual From/To control while also offering shortcuts.
- Auto-fill the From/To date inputs when a preset radio is chosen (client-side).
- Auto-highlight the matching preset when the user edits the dates manually.
- Preselect the active preset server-side when the current filter matches its range.
- Reuse all base date-range behavior (date/datetime type, labels, summary format, BETWEEN/`>=`/`<=`).
- Provide a fast "recent items" filter on a news/events Search API listing.
- Combine quick date presets with other in-form facets in one submit.
- Localize preset labels (This week / This month / …) via translation.
- Offer bookmarkable date filters where presets resolve to concrete `from~to` URLs on submit.
- Base a custom set of relative-date shortcuts on this widget's pattern.
- Avoid writing JavaScript to sync preset buttons with date inputs.
- Present an accessible radio-based preset picker rather than instant-apply links.
