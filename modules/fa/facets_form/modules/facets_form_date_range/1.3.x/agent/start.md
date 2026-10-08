<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Facets Form Date Range — agent index

Adds a "Date range (inside form)" facet widget (`facets_form_date_range`) with From/To pickers, plus
a Search API query type that filters by the interval. Depends on `facets_form`. No config page, no
permissions, no Drush. Ships config schema for the widget.

- **Widget config, value serialization (`from~to`), and the query-type operator logic** →
  [plugins/date-range.md](plugins/date-range.md)

Key facts:
- Widget `DateRangeWidget` (extends Facets `ArrayWidget`, uses `FacetsFormWidgetTrait`); query type
  `facets_form_date_range_query_type` mapped via `hook_facets_search_api_query_type_mapping_alter()`.
- Widget id returned by `getQueryType()` = `facets_form_date_range`.
- `DateRange` value object: `~`-delimited string; `Y-m-d` (date) or ISO-8601 ATOM (datetime).
  Query operators: `>=` (From only), `<=` (To only), `BETWEEN` (both); values as timestamps
  (date-only From = start of day, To = end of day).
- Config: `date_type` (date|datetime), `label.from`/`label.to`, `date_format.type`/`date_format.custom`.
