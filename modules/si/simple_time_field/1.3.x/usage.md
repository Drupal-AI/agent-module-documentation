<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple Time Field provides a **time-only** field type — the hours and minutes (optionally seconds) without a date — for opening hours, session start times, daily schedules and anything where the date is irrelevant.

---

Drupal's datetime field always carries a date, and storing "09:00" as a datetime means inventing a date to attach it to, which then leaks into displays, sorting and timezone handling in ways nobody wants. A time-only field avoids that, which is why this recurs on venue, education and healthcare sites. The module supplies a genuinely complete field surface: the `simple_time_type` field type storing the value as a short `varchar(8)` string (`HH:MM` or `HH:MM:SS`, indexed), a `simple_time_widget` HTML5 time-picker widget with min/max and step constraints validated on the server, four formatters (one fully configurable with any PHP date format plus three fixed backward-compatibility ones), a reusable `simple_time_field_element` form element, a `TimeHelper` utility, and an optional Feeds target that normalises human-readable strings like "2pm" on import. Because the value is a plain string it sorts and filters in Views through core's field integration with no custom handler. It depends on core `field` alone, with core `^10 || ^11`. The semantics worth raising for opening hours specifically: a time without a date has no unambiguous instant, so the formatter's display-timezone setting is a fixed-date offset only and comparing times across zones is not meaningful. For real opening-hours modelling with exceptions and holidays a dedicated module fits better; this is the right tool when a plain time value is what is actually needed.

---

- Store opening hours as times.
- Record a class start time.
- Capture an appointment slot.
- Show times in 12- or 24-hour format.
- Constrain a time to a valid range with min/max.
- Restrict input to 15-minute steps for booking.
- Include seconds where precision matters.
- Sort a view by time of day.
- Filter a listing by time.
- Import times through Feeds from a messy CSV.
- Normalise "2pm" or "02:30 PM" to a stored HH:MM.
- Record a daily schedule.
- Show a display-only timezone offset alongside a time.
- Avoid inventing a date for a time value.
- Display session times on an event page.
- Record a shift pattern.
- Capture a delivery window.
- Store a broadcast time.
- Display a time with a custom PHP date format.
- Reuse the HTML5 time input element in a custom form.
- Show times consistently across a site.
