<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Date range widget & query type

## Widget — `facets_form_date_range` (`DateRangeWidget`)
Extends Facets `ArrayWidget`, implements `FacetsFormWidgetInterface`, uses `FacetsFormWidgetTrait`.

### Config (`facet.widget.config.facets_form_date_range`)
- `date_type` — `date` (default) or `datetime` (`DateRange::TYPE_DATE` / `TYPE_DATETIME`). Controls
  whether the `datetime` elements show a time component (`#date_time_element` = `none` vs `time`).
- `label.from` / `label.to` — field labels (default "From" / "To").
- `date_format.type` — a registered `date_format` id or `custom` (used for the **summary** display).
- `date_format.custom` — PHP date pattern used when `type` = `custom`.

### `build()`
Renders a `#tree` fieldset with two `#type => datetime` elements (`from`, `to`), pre-filled from the
facet's active items via `DateRange::createFromFacet()`, each carrying a `data-timezone` attribute.
Calls `checkDependentProcessors()` so a Facets "dependent" processor can hide it; sets a fake empty
`Result` so Facets' empty behavior doesn't suppress the widget. Cache contexts: `url.query_args`,
`url.path`.

### `prepareValueForUrl()`
Builds a `DateRange` from the submitted `from`/`to` values and returns `[(string) $dateRange]` (or
`[]` if empty). `getQueryType()` returns `facets_form_date_range`.

## Value object — `DateRange` (`src/DateRange.php`)
- String form: `formatFrom() . '~' . formatTo()` (delimiter `~`). Date-only → `Y-m-d`; datetime →
  ISO-8601 ATOM. Either side may be empty.
- `setFromIntervalString()` parses a `from~to` string, guessing the type from length (10 = date,
  25 = datetime); throws `InvalidArgumentException` on a missing delimiter or malformed length.
- `getFromDateAsDatetime()` / `getToDateAsDatetime()` — for date-only ranges, snap From to `00:00:00`
  and To to `23:59:59.999999`. `getFromTimezone()`/`getToTimezone()` return the `P` offset.
- `createFromFacet(FacetInterface)` — builds from the facet's first active item.

## Query type — `facets_form_date_range_query_type` (`DateRangeQueryType`)
Registered onto core Facets by `facets_form_date_range.module`
(`hook_facets_search_api_query_type_mapping_alter`). `execute()` adds a Search API condition on the
facet's field identifier:
- From only → operator `>=`, value = From timestamp.
- To only → operator `<=`, value = To timestamp.
- Both → operator `BETWEEN`, value = `[fromTs, toTs]`.
`build()` produces the summary `Result`: "Between @from and @to" / "After @from" / "Before @to",
formatted with the widget's `date_format`.
