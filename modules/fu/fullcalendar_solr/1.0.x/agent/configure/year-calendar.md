<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Building a FullCalendar Solr year view

1. Add a View whose *Show* is a Solr/Search API index; add a **Page** display.
2. Set the display format to **FullCalendar Solr**.
3. Give the page a path ending in `year` (e.g. `/events/year`); the last
   component **must** be `year` or `render()` aborts with a warning.
4. Add a string **Date field** in `YYYY-MM-DD` (must be indexed).
5. Add a **year contextual filter** (`YYYY`), usually defaulted from
   *Raw value from URL*.
6. Under *Format → FullCalendar Solr Settings* map the Date Field and Year
   Field, and optionally: highlight colour, months-per-row, min month width,
   heading template (`<year>` placeholder), *Navigation Links to Day View*,
   *Link to Item* (+ Item URL Field), and "display even if no results".

**Day view / single-item linking:** enable *Navigation Links*, then create a
second display with the same path but ending in `day`. With *Link to Item*
enabled and a date having a single result, clicks go straight to that item.

**How years are populated:** `getYearFacets()` clones the executed Search API
query, strips the year `=` condition, sets a `search_api_facets` option on the
year field and re-runs it, so the dropdown lists only years with results.
Requires a backend advertising `search_api_facets`.
