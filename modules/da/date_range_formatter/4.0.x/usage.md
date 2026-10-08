<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Date Range Formatter formats core date-range fields flexibly, letting you control how the start and end are displayed — collapsing a same-day range, formatting each end differently, and choosing separators.

---

A date range like "10 June 2026 – 12 June 2026" is rarely wanted verbatim. An event on a single day should read "10 June 2026", not "10 June 2026 – 10 June 2026". A range within one month might read "10–12 June 2026". Core's date-range formatter is rigid about this; getting the natural rendering means either a custom formatter or a Twig template. This module makes those choices configuration on the field's display.

It depends on core **Datetime Range** and is purely a display formatter — it changes how the stored range renders, not the data. That makes it low-risk and broadly useful anywhere date ranges are shown: events, exhibitions, opening periods, availability. The main thing to get right is the format configuration, since the value of the module is precisely in matching the human way of writing the range.

For any site displaying date ranges, it turns awkward default output into natural dates. Configure the same-day collapse and the separators to match your locale and content.

---

- Format a date range naturally.
- Collapse a same-day range.
- Show '10–12 June 2026'.
- Format start and end separately.
- Choose a range separator.
- Display event dates cleanly.
- Format exhibition periods.
- Format opening periods.
- Avoid a custom formatter.
- Configure range display.
- Render availability ranges.
- Match a locale's date style.
- Format a date-range field.
- Improve event listings.
- Show a single-day event as one date.
- Configure separators.
- Depend on Datetime Range.
- Keep the data, change the display.
- Format ranges across months.
- Present dates the human way.