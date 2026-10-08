<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Created Date Views Filters adds two Views filter handlers on the entity `created` timestamp: a **Year** dropdown (the last six years) and a **Month** dropdown (January–December). Each matches rows whose creation date falls in the chosen year or calendar month.

---

The module is deliberately small: `hook_views_data()` attaches two filter plugins to the `views` pseudo-table against the `created` field, and both extend the plain `FilterPluginBase` — so there is no operator, no min/max, just a single `<select>`. **Year** offers `date('Y')-5` through the current year (default: current year) and generates `EXTRACT(YEAR FROM FROM_UNIXTIME(<table>.created)) = :year`. **Month** offers the twelve month *names*, converts the chosen name to a number with `strtotime()`, and generates `EXTRACT(MONTH FROM FROM_UNIXTIME(<table>.created)) = :month`. The month filter matches *every* year's occurrence of that month, and the two filters combine (AND) when both are added, so "March 2023" needs both. Values are bound with named placeholders, so input is parameterized. Two real caveats. The `EXTRACT(... FROM FROM_UNIXTIME(...))` expression is **MySQL/MariaDB-specific** — it is not portable to PostgreSQL or SQLite. And the target table is `array_key_first($query->tables)`, the View's *first* table, not the table that actually holds `created`; on a View whose base table is not `node`/the timestamp's owner (or whose first table is aliased), the emitted SQL can point at the wrong or a nonexistent column. There are no settings, no schema, and no admin form — everything is configured per-View in the Views UI, and the filters can be exposed like any other.

---

- Filter a content View to items created in a chosen year.
- Filter a content View to items created in a chosen calendar month.
- Expose the Year dropdown so visitors pick a year on the front end.
- Expose the Month dropdown as a front-end month picker.
- Combine Year + Month to scope a listing to one month of one year.
- Build a "this year's articles" listing without hand-writing a date offset.
- Give editors a simple year picker over a node admin View.
- Add a month selector to an archive/blog index View.
- Let users browse posts by the month they were published.
- Scope a report View to a single calendar year.
- Add a quick year facet to a search-results View.
- Filter a comments or submissions View by creation year.
- Provide a "born in month X" style filter over any entity with `created`.
- Narrow a large content list to one year to reduce rows shown.
- Offer a year dropdown limited to the last six years on a recent-content View.
- Match every March across all years for a seasonal listing.
- Add year/month filters to a media library View.
- Build a yearly digest View driven by an exposed year filter.
- Let an editorial dashboard filter activity by month.
- Replace a fiddly core relative-date filter with a plain named dropdown for whole-year/whole-month scoping.
- Combine with other Views filters (status, type) to slice content by creation period.
