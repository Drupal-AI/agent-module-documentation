<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Facets Form Date Range adds a "Date range (inside form)" facet widget that renders From/To date (or date-and-time) pickers inside a Facets Form and filters Search API results by the selected interval.

---

The submodule provides the `facets_form_date_range` Facets widget (`DateRangeWidget`, extends the Facets `ArrayWidget` and uses `FacetsFormWidgetTrait`) plus a matching Search API query type (`facets_form_date_range_query_type`, `DateRangeQueryType`), wired to core Facets via `hook_facets_search_api_query_type_mapping_alter()`. The widget builds a fieldset with two `datetime` form elements ("From"/"To"); its config offers a date type (Date only vs Date and time), custom From/To labels, and a summary date format (any registered date format, or a custom PHP pattern). Selected values are serialized into a single active-filter string of the form `<from>~<to>` (`DateRange` value object, `~` delimiter, `Y-m-d` or ISO-8601 `datetime`), and the query type turns that into a Search API condition using operator `>=`, `<=`, or `BETWEEN` depending on which bounds are present (dates are converted to timestamps; "date only" From is start-of-day and To is end-of-day). The widget honors the Facets "dependent" processor so it can be conditionally shown, and sets fake results when empty so Facets' empty-behavior doesn't hide it. The active filter is rendered in the summary as "Between … and …", "After …", or "Before …". Depends on `facets_form`.

---

- Filter a Search API listing by a start/end date range chosen inside a facets form.
- Let users pick "From" and "To" dates and apply them together on submit.
- Filter by date-and-time (not just date) by setting the widget's date type to "Date and time".
- Filter events/content published after a given date (open-ended From only → `>=`).
- Filter content before a given date (open-ended To only → `<=`).
- Filter content strictly within an interval (both bounds → `BETWEEN`).
- Customize the From/To field labels shown in the form.
- Control how the active date filter reads in the facets summary via a chosen or custom date format.
- Provide a booking/archive date filter for a Search API + Views results page.
- Conditionally show the date-range facet using the Facets dependent processor.
- Combine a date-range facet with checkbox/dropdown facets in the same submit-driven form.
- Filter a timestamp/date Search API field by human-picked calendar values.
- Serialize a date interval into a shareable, bookmarkable facet URL (`from~to`).
- Show "Between X and Y" style summaries for the active date filter.
- Use as the base for the extended date-range widget (quick pickers) submodule.
- Keep the date facet visible-but-editable even when the current result set is empty.
