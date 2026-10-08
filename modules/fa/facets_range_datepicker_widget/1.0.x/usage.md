<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Renders a Facets date facet as an HTML5 date picker (single day or from/to range) instead of a list of individual date links.

---

Facets Range Datepicker Widget extends the Facets module with two widget/processor pairs so a date facet can be filtered with a calendar control. The `datepicker` widget shows one date input and filters results to the selected day; the `range_datepicker` widget shows a from/to pair and filters to a span. Each widget is bound to a matching Facets processor of the same id (enforced by `isPropertyRequired()`), and both declare the `range` query type. When Facets builds the facet, the processor's `build()` stage writes a single result URL containing placeholder tokens (`(min:__datepicker_min__)` or `(min:__range_datepicker_min__,max:__range_datepicker_max__)`); the module's `js/datepicker.js` reads that server-supplied URL from `drupalSettings`, substitutes the picked date(s) as UNIX timestamps, and redirects the browser. On the follow-up request the processor's `preQuery()` stage parses the timestamps back out with a strict numeric regex and rewrites the active facet items into a min/max range for the search query. Labels for the date input(s) and an optional `visually-hidden` label class are configurable per facet through the facet widget config schema. The module supports facet source fields whose storage type is `datetime`, `created`, `changed` (single) or `datetime`, `created`, `updated` (range). It has no routes, permissions, config forms, services, entities or Drush commands of its own — everything is configured on the individual facet in the Facets admin UI.

---

- Filter a faceted search result set to a single calendar day using the `datepicker` widget.
- Filter a faceted search result set to a from/to date span using the `range_datepicker` widget.
- Replace a long list of individual date facet links with a compact calendar input.
- Add a date-range control to search over events, articles by publish date, or timestamped records.
- Let visitors pick "documents from this day" on a date facet without scrolling a list.
- Let visitors pick a start and end date to narrow results to an interval.
- Support single-ended ranges: choose only a minimum ("on or after") or only a maximum ("on or before") date.
- Attach a date picker to a facet built on a `datetime` field exposed by a Search API index.
- Attach a date picker to a facet built on the node `created` timestamp.
- Attach a date picker to a facet built on the `changed`/`updated` timestamp.
- Customize the label shown above the date input (per facet, e.g. "Select Date").
- Customize both the minimum ("Initial Date") and maximum ("Closing Date") labels on a range facet.
- Hide the date labels visually while keeping them for screen readers via the `visually-hidden` option.
- Auto-submit the search when the visitor changes the date input (no separate apply button).
- Provide a date-range facet experience similar to the one offered by major search engines.
- Combine a date picker facet with other Facets widgets (checkboxes, links) on the same search page.
- Configure the required `datepicker` / `range_datepicker` processor automatically alongside the widget.
- Use the widget on any Facets facet source that exposes a supported date/timestamp field type.
- Translate the date-input labels through Drupal's configuration translation system.
- Offer accessible, native browser date inputs (`<input type="date">`) rather than a JS-only calendar.
- Enable the module and select the widget per facet with no central configuration page to manage.
- Remove the picker at any time by switching the facet back to a standard widget.
