<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Date Range Filters adds range-aware operators (Includes, Overlaps, Ends by, Not ended, and two "Includes unbound" variants) to the Views filter for `daterange` and `date_recur` fields, so a View can filter on the span between a start and end value rather than a single date column.

---

The module replaces the standard Views date filter on `daterange`/`date_recur` start columns with its own `views_daterange_filters_daterange` filter plugin, which extends core's `datetime` Date filter and adds six extra operators. It attaches itself automatically: `hook_field_views_data_alter()` rewrites the `filter.id` of every non-`_end_value` column of a daterange/date_recur field to `views_daterange_filters_daterange`, so any daterange field added as a Views filter gains the new operators with no per-view configuration. Each operator builds a WHERE expression that pairs the field's `_value` (start) column with its derived `_end_value` (end) column — the plugin computes the end column name by replacing the `_value` suffix with `_end_value`. "Includes" finds ranges that contain a single date; the "Includes (Unbound)" and "Includes (Unbound Indexed)" variants also match open-ended ranges where the start or end is NULL, the indexed variant using bound parameters for better index use; "Overlaps" takes a min/max pair and finds ranges intersecting it; "Ends by" matches ranges whose end is at or before a date; "Not ended" matches ranges whose end is at or after a date (or NULL/open-ended). Input values are converted from the active timezone to UTC storage format the same way core's date filter does. There is no admin settings form, no permission, and no configure route — everything is done in the Views UI by picking one of the new operators on a daterange filter.

---

- Filter a View of events to those that are ongoing on a specific day using the **Includes** operator.
- Show sessions happening "right now" by filtering with **Includes** against the current date via a contextual/exposed value.
- Include open-ended ranges (no end date) in a "current" listing with **Includes (Unbound)**.
- Use **Includes (Unbound Indexed)** on a large dataset so the query binds the date as a parameter and can use an index on the date columns.
- Build a "what's on between two dates" report with the **Overlaps** operator taking a min and max date.
- Find events that overlap a user-selected date range in an exposed filter form.
- List projects that **end by** a deadline with the **Ends by** operator.
- Show subscriptions or contracts that have **Not ended** as of today, including open-ended ones.
- Filter a room-booking View for conflicts by finding bookings whose range overlaps a requested slot.
- Expose a single date box that returns all multi-day events covering that date.
- Drive an "upcoming and ongoing" events block by combining **Not ended** with a date value of now.
- Filter `date_recur` recurring-event fields by range, not just their start instant.
- Report memberships expiring on or before a chosen date with **Ends by**.
- Power a calendar sidebar that lists everything active in the displayed month via **Overlaps**.
- Give editors an exposed operator dropdown so they can switch between Includes/Overlaps/Ends by on the front end.
- Filter conference talks that span a lunch break by checking the range includes a fixed time.
- Exclude finished promotions from a storefront listing using **Not ended**.
- Handle events with optional end dates (via the `optional_end_date` module) so unbounded ranges still match "current" filters.
- Query availability windows (e.g. "open now") for venues stored as daterange fields.
- Add a "still valid" filter to coupons or licenses whose validity is a daterange.
- Build an admin View of tasks whose scheduled window overlaps this week.
- Filter travel itineraries whose trip range includes a given day.
- Show only ranges that have already concluded by combining **Ends by** with today's date.
- Let a contextual filter pass a date so a block shows ranges including that date.
- Replace hand-written custom Views filter handlers for daterange spans with a maintained plugin.
