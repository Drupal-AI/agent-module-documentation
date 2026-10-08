# Views Date Range Filters — manual setup guide

**Views Date Range Filters** (`views_daterange_filters`) teaches Views how to
filter on a *span of time* rather than a single date. Drupal's core date filter
looks at one date column, but a **date range** field (`daterange`) or a
recurring-date (`date_recur`) field has both a start and an end. This module adds
range-aware operators so a View can answer questions like "which events are
happening on this day?" or "which contracts overlap next week?"

Once the module is enabled, it attaches itself **automatically**. Whenever you add
a date-range field's start column as a filter in the Views UI, it gains six extra
operators with no per-view setup on your part:

- **Includes** — ranges that contain a single given date.
- **Includes (Unbound)** — like Includes, but also matches open-ended ranges where
  the start or end is empty.
- **Includes (Unbound Indexed)** — the same as Unbound, but written to bind the
  date as a query parameter so it can use a database index (better for large
  datasets).
- **Overlaps** — takes a min and max date and finds ranges that intersect that
  window.
- **Ends by** — ranges whose end is at or before a given date.
- **Not ended** — ranges whose end is at or after a given date (including
  open-ended ones).

Input values are converted from the active timezone to UTC storage exactly the way
core's date filter does, so behavior is consistent. There is no admin settings
form, no permission, and no configure route — everything happens in the Views UI
by picking one of the new operators.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is nothing to configure globally. The new operators appear in the Views UI
under **Structure → Views** whenever you add a date-range field as a filter
criterion.

## How to use it

1. Edit (or create) a View that has a `daterange` or `date_recur` field available.
2. Under **Filter criteria**, click **Add** and choose the date-range field's date
   filter.
3. In the operator dropdown, pick one of the new operators — **Includes**,
   **Overlaps**, **Ends by**, **Not ended**, or one of the two **Unbound**
   variants.
4. Provide the value(s): single-value operators take one date; **Overlaps** takes a
   min and a max. You can also expose the filter so front-end visitors can choose
   the operator and dates themselves.
5. Save the View.

A few practical examples: use **Includes** with "now" to show events that are
ongoing right this moment; use **Overlaps** with two dates for a "what's on
between these days" report; use **Not ended** with today's date for an "upcoming
and ongoing" listing.

> **Optional end dates:** if your date-range fields sometimes have no end date,
> the companion module [`optional_end_date`](https://www.drupal.org/project/optional_end_date)
> lets the end value be empty, and the "Unbound" / "Not ended" operators treat
> those as open-ended ranges.
