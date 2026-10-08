<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search Api Daterange Filter provides a date-range exposed filter for Search API date-type fields, for filtering results by a date range.

---

Search Api Daterange Filter adds a date-range exposed filter for Search API date fields — so a Views
search can expose a "from/to" date-range filter that users apply to narrow results by date. It depends on
the Search API module and is in the Views package. This fills a gap for range-based date filtering on
Search API indexes.

Use it on Search API-backed Views where users should filter by a date range (events after X, content
between two dates). It is a site-search/Views feature shaping the query; results still respect the index
and entity access, and it has no access-control role. Add the exposed filter to the search View.

---

- Filter Search API by date range.
- Expose a from/to date filter.
- Narrow results by date.
- Apply to Search API date fields.
- Depend on the Search API module.
- Filter events after a date.
- Filter content between dates.
- Shape the search query.
- Respect index and entity access.
- Have no access-control role.
- Add to a search View.
- Provide range date filtering.
- Expose the filter to users.
- Filter by date range.
- Support Search API date types.
- Refine results by date.
- Add a date-range filter.
- Configure the exposed filter.
- Filter search results.
- Handle date ranges.
