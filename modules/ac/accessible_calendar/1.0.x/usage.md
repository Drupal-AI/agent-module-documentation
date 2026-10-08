Accessible Calendar renders Views results as keyboard- and screen-reader-friendly month or week calendar displays built from your existing content's date fields.

---

Accessible Calendar is a lightweight, Views-based calendar for Drupal 10/11 that turns any View of date-bearing content into an accessible month or week calendar without introducing a separate event entity. You add one or more date fields to a View, pick the "Calendar by month" or "Calendar by week" format, choose which date field(s) drive placement, and pair it with the matching month/week pager. The output is a semantic HTML `<table>` per period with hidden per-day summaries, `aria-current` on the current period, a navigation landmark, and (with AJAX enabled) `Drupal.announce()` messages plus focus management after navigation. It supports date, created, changed, datetime, daterange, smartdate, and timestamp field types, a configurable first day of the week, an optional work-week (hide-weekend) mode in week view, tokenized calendar and row titles, an exposed "Jump to" filter driven by a `calendar_timestamp` query argument, and optional display of the original Views rows alongside the calendar. An optional submodule, Accessible Calendar - Multiday, adds classes and metadata so events spanning several days render as one continuous run.

---

- Show a month calendar of published event nodes by adding an event date field to a View and choosing the "Calendar by month" format.
- Present a weekly agenda of sessions or appointments using the "Calendar by week" format.
- Hide Saturday and Sunday with the week view's "Hide weekend" (work-week) option for business-hours schedules.
- Start the week on Monday, Sunday, or any weekday, independent of the site's default first-day-of-week setting.
- Drive calendar placement from a core `created` or `changed` timestamp to build a "content published on" calendar with no extra field.
- Build a calendar from a `datetime` or `daterange` field so start/end dates position events correctly.
- Use a `smartdate` field as the calendar's date source for recurring or all-day event data.
- Render multiday events (a conference spanning several days) as one continuous strip by enabling the Accessible Calendar - Multiday submodule.
- Let visitors jump straight to any month or week by exposing the "Jump to" filter, which accepts human-readable dates like "next month" or "2025-12-31".
- Enable AJAX on the display so previous/next navigation swaps the calendar in place and announces the new period to screen readers.
- Provide accessible previous/next/reset navigation with descriptive `aria-label`s (for example "Next month, January 2026").
- Show a "Reset" link that returns the calendar to the current month/week whenever the visitor has navigated away.
- Set a custom calendar caption with tokens, such as `[date:custom:F Y]` for "January 2026" headings.
- Add a per-event hidden title (row title) using field/global tokens so assistive tech reads a meaningful label for each cell entry.
- Display the standard Views rows underneath the calendar as a fallback list by enabling "Display default View results".
- Combine the calendar with a contextual filter or exposed date filter so only a sensible time window loads for large datasets.
- Use offset date filters (for example "-1 week"/"+1 week") that the module automatically rebases to the currently viewed calendar period.
- Style the calendar per view or per display using the module's template suggestions (by view id and display id).
- Theme individual day cells (highlight today, weekends, past/future, empty days) using the `is-today`, `is-past`, `is-future`, `empty`, and weekday classes it emits.
- Swap in your own CSS library by overriding the `views-view-calendar.html.twig` `libraries` block instead of the bundled default skin.
- Localize captions and navigation by relying on the display's rendering language for token replacement.
- Build a public "what's on this month" page for a community, school, or venue site from existing content.
- Give editors a calendar overview of scheduled or published content inside an admin View.
