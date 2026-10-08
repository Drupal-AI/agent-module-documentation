<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Calendar View adds two Views style plugins -- **Calendar by month** (`calendar_month`) and **Calendar by week** (`calendar_week`) -- that render a View's results as an HTML-table calendar, placing each row on the day of a chosen Date field.

---

Calendar View is a lightweight, Views-native way to show any date-bearing content on a calendar. Instead of a third-party JS library, it renders results into a plain, themeable `<table>` (one cell per day) using the style plugins `calendar_month` and `calendar_week`. To use it you build a normal View of any entity, add at least one supported **Date field** to the View's fields, then set the display's Format to *Calendar by month* (or week) and tick that date field under the style's `calendar_fields` setting. Supported field types are `date`, `created`, `changed`, `datetime`, `daterange`, `smartdate`, and `timestamp`. The module also provides matching **pager** plugins for previous/next month or week navigation, a **"Jump to"** exposed filter (`calendar_view_timestamp`) so visitors can navigate to any date via a `?calendar_timestamp=` query, and options for the first weekday, default date, sort order, and a token-driven calendar title/caption. It has no global settings page -- everything lives in the Views UI per display. The bundled **calendar_view_multiday** submodule improves the display of events that span several days, and **calendar_view_demo** ships ready-made example calendars.

---

- Show a monthly calendar of published Article nodes by their authored (created) date.
- Build an events calendar from a content type with a `datetime` date field.
- Render a calendar of events that use a `daterange` field so multi-day spans appear on every day.
- Display a weekly agenda view with the `calendar_week` style instead of a full month.
- Add previous/next month navigation to a calendar using the `calendar_month` pager.
- Add previous/next week navigation with the `calendar_week` pager.
- Let visitors jump to an arbitrary month via the `calendar_view_timestamp` "Jump to" exposed filter.
- Deep-link a calendar to a specific month with a `?calendar_timestamp=2025-12-31` URL.
- Show a calendar of user registrations by the `created` date on the user entity.
- Display last-modified activity by putting the `changed` timestamp field on the calendar.
- Build a content editorial/publishing calendar from a scheduled-publish date field.
- Present a calendar of Smart Date (`smartdate`) events.
- Set the calendar to start the week on Monday (or any weekday) via `calendar_weekday_start`.
- Hide weekends in a week calendar using the `calendar_week` style's work-week option.
- Give the calendar a dynamic caption/title with date tokens like `[date:custom:F Y]`.
- Also render the standard row output beneath the calendar via `calendar_display_rows`.
- Filter which content appears on the calendar with normal Views filters (e.g. by taxonomy term).
- Embed a calendar block on a dashboard by adding a Block display to the calendar View.
- Show a public "what's on" calendar of upcoming events on a landing page.
- Build a room/resource booking calendar from bookings that carry a date field.
- Create a per-user "my events" calendar by combining a contextual filter with the calendar style.
- Theme individual day cells (today, past, future, has-results) with the CSS classes the style emits.
- Override the day-cell markup with the `calendar_view_day` theme hook / template.
- Restrict the visible window with a date filter and let the calendar timestamp drive it relatively.
- Display a project deadlines calendar keyed off a due-date field.
- Combine with calendar_view_multiday to render conference sessions spanning multiple days.
- Sort same-day events ascending or descending within a cell via `calendar_sort_order`.
