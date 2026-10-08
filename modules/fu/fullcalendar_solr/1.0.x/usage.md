<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
FullCalendar Solr provides a Views display style that renders a Search API (Solr) result set as an interactive year calendar using the FullCalendar JavaScript library.

---

The problem it addresses is that core Views' calendar options do not work against a Search API index — Solr results are documents, not entities, and Search API does not support SQL-style aggregation. This module implements a `StylePluginBase` style (`fullcalendar_solr`) that reads a configured string date field (`YYYY-MM-DD`) and a year contextual filter, counts results per date in PHP, and re-queries the index with a `search_api_facets` option to build the list of years that actually have content (populating a year dropdown). Highlighted dates can link to a companion "day" view, or directly to a single result when a date has only one item. It requires a Search API backend that advertises the `search_api_facets` feature.

Two operational notes matter. First, the calendar view's path must end in a `year` component and the year contextual filter is typically fed from the URL, so path structure is part of the configuration, not just cosmetics. Second — a supply-chain consideration — the FullCalendar library is declared as an external asset loaded from `https://www.unpkg.com/fullcalendar@6.1.5/index.global.min.js` (no Subresource Integrity hash), so the calendar pulls third-party JavaScript from a CDN at render time; sites with a strict CSP or offline requirement should vendor the library locally. The module exposes no routes, permissions or write endpoints of its own.

---

- Render a Solr/Search API index as an interactive year calendar
- Add a FullCalendar Solr display style to a Search API view
- Highlight every date that has indexed content
- Populate a year dropdown containing only years that actually have results
- Map a `YYYY-MM-DD` string date field to the calendar
- Feed the initial year from a URL-derived contextual filter
- Link highlighted dates to a companion day view (same path ending in `day`)
- Jump straight to a single item when a date has only one result
- Customise the date-highlight colour
- Set the maximum number of months per row in the year view
- Set the minimum month width in pixels
- Customise the calendar heading with a `<year>` placeholder template
- Choose whether to render an empty calendar when there are no results
- Add extra CSS classes for theming the calendar
- Build a calendar-link block that jumps to the oldest/latest year with results
- Integrate with the Facets module for faceted event browsing
- Vendor the FullCalendar library locally to satisfy a strict CSP
- Combine multiple contextual filters (e.g. per organisation) with the year filter
