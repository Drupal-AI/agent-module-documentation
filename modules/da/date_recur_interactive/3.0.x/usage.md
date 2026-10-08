<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Date Recur Interactive Widget replaces the raw RRULE textarea on a Date Recur field with a visual, JavaScript recurrence editor.

---

Date Recur Interactive Widget adds one field widget (`date_recur_interactive_widget`) for `date_recur` fields, provided by the Recurring Dates Field (`date_recur`) module. Instead of asking editors to type an iCalendar RRULE, it renders an in-form editor built on a bundled copy of rrule.js and jQuery UI: choose a frequency and interval, pick by-weekday / "on the Nth weekday" / by-month constraints, set an end condition (never, after N occurrences, or on a date), and add explicit include/exclude dates, all while a live human-readable summary and the generated RRULE update as you edit. The widget plugin `DateRecurInteractiveWidget` extends date_recur's `DateRecurBasicWidget`, so the start date, time, timezone and rrule storage and their server-side validation are unchanged — only the input UI differs. It requires Recurring Dates Field 3.x and Drupal 10.3, 11 or 12, and is in the Field types package. Select it per view form-display on Manage form display for any date_recur field.

---

- Give content editors a visual recurrence builder instead of a raw RRULE textarea on a `date_recur` field.
- Let editors pick yearly / monthly / weekly / daily / hourly / minutely / secondly frequencies from a dropdown.
- Set an interval ("every N …") for the chosen frequency.
- Build weekly recurrences by ticking specific weekdays (Mon–Sun).
- Build monthly recurrences on the "first/second/third/fourth/fifth/last" weekday of the month.
- Restrict a monthly recurrence to specific months of the year.
- Choose an end condition: never, after a set number of occurrences, or on a specific date.
- Add extra one-off include dates (RDATE) to a recurrence.
- Add exclude dates (EXDATE) to skip specific occurrences.
- Show editors a live plain-language summary of the rule they are building.
- Show the generated RRULE text live for editors who want to verify it.
- Toggle recurrence on/off per field with a "Repeat?" checkbox that hides the editor when unchecked.
- Seed the editor from an existing saved RRULE when editing existing content.
- Default a new weekly rule to the start date's weekday.
- Keep timezone-aware include/exclude dates by resolving them through the field's selected timezone.
- Fall back to a jQuery UI datepicker on browsers without native `<input type="date">` support.
- Provide a translation-ready UI (all labels run through `Drupal.t`).
- Swap the interactive widget for date_recur's basic widget per form display without changing stored data.
- Migrate an existing date_recur field to a friendlier input UI without re-modelling content.
- Reduce editor errors from hand-writing iCalendar RRULE strings.
- Support event, schedule and booking content types that use recurring dates.
