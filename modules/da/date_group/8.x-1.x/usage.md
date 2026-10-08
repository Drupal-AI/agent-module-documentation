<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Date Group is a field formatter for core `daterange` fields that collapses the parts a start and end date share into one readable string — "May 01-03, 2016" instead of "May 01, 2016 - May 03, 2016".

---

The module adds one field formatter, id `date_group`, selectable in Manage Display for any Date range (`daterange`) field. It extends core's `DateRangeDefaultFormatter`, so it reuses the standard settings — a date **format type**, a **separator** (default `-`), a **timezone override** and a **from/to** control — and adds one of its own, a **time separator** (default `:`). At render time it puts both dates in the current default timezone, then decides: if the start and end timestamps are identical it just renders the single date; otherwise it picks one of three merge strategies from the parsed date parts. **Different years** produces the full start, the separator, and the full end ("August 27, 2016-May 14, 2017"). **Same month** merges the day into a range and keeps the month and year once ("May 01-03, 2016"). **Same year, different month** keeps the year once at the end ("May 05-June 06, 2016"). It does the merge by splitting the chosen date-format pattern character by character and reassembling it, then formatting through Drupal's date formatter, and it emits the result as plain `#markup` with a `timezone` cache context. Because the pattern is taken apart by hand, this is a display-only convenience with real edges: the maintainer's own recommendation is to choose a **date-only format with no time component** — time is only partially handled in the same-month branch and not at all in the others — and the inherited `from_to` setting is ignored once grouping kicks in. The grouped path also compares in the request's default timezone rather than the formatter's own `timezone_override`, so a range crossing midnight can group differently than a reader expects. None of this touches access or storage; it changes only how an already-access-checked date value is printed.

---

- Render an event's date range as "12-15 March 2026" instead of repeating the month and year.
- Collapse a single-day range that has equal start and end into one date.
- Show a same-month multi-day range with the day collapsed to a range.
- Show a cross-month, same-year range with the year printed once.
- Show a cross-year range as two full dates joined by a separator.
- Format a conference's run compactly in a listing.
- Render an exhibition's opening and closing dates.
- Show a course's start and end on a catalog card.
- Format a festival's dates for a teaser.
- Render a campaign or promotion period.
- Show a booking or availability window.
- Format a membership or subscription period.
- Render a job posting's application window.
- Show a report's coverage period.
- Configure a custom separator between the two dates (e.g. an en dash).
- Choose the site date format used to build the grouped string.
- Pick a date-only format so grouping stays clean (maintainer's recommendation).
- Keep a single formatter across day, month, and year spans without per-case theming.
- Replace a hand-written preprocess function that compared the two dates piece by piece.
- Apply consistent date-range typography across every entity type that has a daterange field.
