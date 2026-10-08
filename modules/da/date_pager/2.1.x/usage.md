<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Date Pager is a Views pager that moves through time — next month, previous week — instead of through numbered pages of results.

---

For date-organised content, numbered paging is the wrong metaphor: nobody asks for page 3 of an events listing, they ask for next month. Date Pager replaces the standard Views pager with one whose unit of navigation is a **time period**, so the view shows what falls in the current period and the links jump to the adjacent one, giving a stable URL per period — `?date=2026-09` rather than `?page=2` — which is what makes the page linkable, bookmarkable and indexable. To use it, edit a view whose base entity has a date field, set the **Pager** to **Date Pager**, then choose a **granularity** (Year, Month, Day, Hour or Minute), pick the **date field** to page on, and set the **default time** shown when no period is selected (`earliest`, `current`, or `latest`). It works with core `datetime`, `daterange`, `changed` and `created` fields, and with **Smart Date** `smartdate` fields; internally it constrains the query to the active period with a date-range condition (rather than a large `OFFSET`) and renders a nested year → month → day → hour → minute list of links. It depends only on core **views**, is version **2.1.2** on `^10 || ^11`, has no settings page (everything is configured in the view's pager options), and adds no permissions.

---

- Page an events listing by month.
- Navigate an archive by year.
- Move week by week through a calendar.
- Give each month a stable, bookmarkable URL.
- Make a content archive indexable by search engines.
- Replace numbered paging on a blog.
- Browse a news archive by period.
- Show this week's or this month's schedule by default.
- Link directly to a specific month's events.
- Page a programme or agenda by day.
- Drill down from year to month to day to hour.
- Page Smart Date event fields by period.
- Page on the node changed/created timestamp.
- Navigate historical records by year.
- Show a rota or roster by week.
- Browse meeting minutes by month.
- Page a publications list by year.
- Show a season's fixtures by month.
- Default the view to the earliest or latest period with content.
- Reverse the period order to show newest first.
