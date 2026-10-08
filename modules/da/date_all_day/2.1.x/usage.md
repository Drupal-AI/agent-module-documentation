<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Date All Day adds an "All day" checkbox to core Datetime Range (`daterange`) field widgets and ships matching formatters that print a date-only string when a range covers a whole day.

---

The module does not define a field type of its own — it works on core's `daterange` fields. It provides one widget, `daterange_all_day` ("Date and time range with All day"), which extends core's `DateRangeDefaultWidget` and injects an **All day** checkbox plus a small JavaScript behaviour: when the box is ticked the time inputs are hidden and the start/end times are forced to `00:00:00` and `23:59:59`. `massageFormValues()` re-applies those times server-side so the stored values are always exactly midnight-to-one-second-before-midnight. There is no flag column in storage: "all day" is **derived**, by `DateRangeAllDayHelper::isAllDay()`, which returns TRUE when the start time formats to `00:00:00` and the end is either empty or formats to `23:59:59` in the site's default timezone. Three formatters — `daterange_all_day_default`, `daterange_all_day_custom` and the deprecated `daterange_all_day_plain` — subclass their core equivalents and add a `date_only_format` setting used *instead of* the normal format whenever the item is all-day; the module installs a locked `date_all_day` date-format entity (pattern `Y-m-d`) as that setting's default. The formatters also tolerate an empty end date (core's do not) and render each bound as a `<time datetime="…">` element. The widget honours the field's core `optional_end_date` setting, relabelling the end date "End date (optional)" and dropping its required flag. An `update_8001` hook exists to migrate sites off the module's own legacy `daterange_all_day` field type onto core `daterange`.

---

- Let editors mark a conference session as running the whole day instead of typing 00:00 and 23:59.
- Render an all-day event as just "2026-07-24" while timed events still show hours and minutes.
- Store all-day events with exact `00:00:00` / `23:59:59` boundaries so date queries behave predictably.
- Add an "All day" toggle to an existing core Datetime Range field without changing its storage.
- Use a custom PHP date pattern (e.g. `l, j F Y`) just for all-day occurrences via the Custom (All day) formatter.
- Keep timed and all-day entries in the same field and view mode.
- Hide the time inputs on the node form when the editor ticks "All day".
- Allow open-ended ranges (no end date) with core's `optional_end_date` setting and still render them correctly.
- Display an all-day range in a teaser view mode with a short date-only format and in full view with a long one.
- Feed a calendar view where all-day rows must not show a time component.
- Give a "holiday closure" field a whole-day representation.
- Model museum/venue opening exceptions that last a full day.
- Produce `<time datetime="…">` markup for all-day dates for SEO/structured data.
- Avoid writing a custom widget just to add an all-day checkbox to a daterange field.
- Migrate a legacy site that used the module's own `daterange_all_day` field type onto core `daterange` via `update_8001`.
- Show "24 July 2026 – 26 July 2026" for a multi-day all-day event without stray 00:00 times.
- Configure a different date-only format per view mode on the same field.
- Let a booking system distinguish full-day bookings from hourly ones with no extra field.
- Render all-day dates using the module's locked `date_all_day` (`Y-m-d`) format entity for machine-readable output.
- Combine with Views date filters where all-day ranges must span the entire day.
- Reduce editor error by removing meaningless time entry for all-day items.
- Apply an all-day-aware formatter to a paragraph or media entity's daterange field.
- Support RTL/localised output by picking any existing core date format as the date-only format.
- Detect all-day-ness in custom code with `DateRangeAllDayHelper::isAllDay($item)`.
