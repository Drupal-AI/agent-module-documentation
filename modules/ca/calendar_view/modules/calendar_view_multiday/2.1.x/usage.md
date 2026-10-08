<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Submodule of Calendar View that improves how events spanning multiple days are rendered on a calendar, drawing them as a continuous bar across the day cells they cover.

---

Calendar View - Multiday (`calendar_view_multiday`) is a zero-configuration companion to the parent `calendar_view` module. When enabled, its preprocess hooks attach the `calendar_view_multiday/multiday` asset library (CSS + JS, depending on `core/drupal` and `core/once`) and decorate each rendered result inside a day cell with `data-calendar-view-instance` / `data-calendar-view-instances` attributes and `is-multi`, `is-multi--first`, `is-multi--middle`, and `is-multi--last` classes. Those hooks fire on `template_preprocess_views_view_calendar` and `template_preprocess_calendar_view_day`, so a `daterange` (or other spanning) event that Calendar View places in several day cells is styled as one connected event rather than repeated blocks. It depends on `calendar_view` and has no settings form, config entity, permissions, or Drush commands — enabling the module is the entire setup.

---

- Render a multi-day conference or festival as a single continuous bar across the calendar.
- Style the first day of a spanning event differently from its middle and last days.
- Show `daterange`-field events that cover several days without repeating a separate block per day.
- Improve the readability of overlapping multi-day bookings on a month calendar.
- Target `is-multi--first` / `is-multi--last` in CSS to round the start/end caps of an event bar.
- Use the `data-calendar-view-instance(s)` attributes in custom JS to position multi-day events.
- Add continuous vacation/leave bars to an HR availability calendar.
- Display project phases that span weeks as connected bars on a monthly Calendar View.
- Render hotel/room reservations that check in and out on different days as one span.
- Show course or training sessions that run across a work week on a weekly calendar.
- Distinguish an event's opening day from its closing day with the first/last classes.
- Highlight the middle days of a long event separately with `is-multi--middle`.
- Combine with the `daterange` field type so start and end drive the span automatically.
- Style a maintenance-window banner stretching across the affected days.
- Present sprint iterations as continuous bars across a team planning calendar.
- Read `data-calendar-view-instances` to know how many days an event covers for JS effects.
- Enable it alongside a monthly Calendar View without changing any View configuration.
- Give multi-day exhibitions a single connected block instead of one box per day.
- Represent shipping/delivery windows as a continuous range on a logistics calendar.
