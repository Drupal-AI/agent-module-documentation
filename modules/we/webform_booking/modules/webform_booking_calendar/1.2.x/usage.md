<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Experimental submodule of Webform Booking that visualises bookings on an interactive FullCalendar calendar via a placeable block, backed by a JSON events feed of Webform Booking submissions.

---

Depends on `webform` and `webform_booking`. It provides a block plugin
`webform_booking_calendar_block` ("Webform Booking Calendar") that renders a FullCalendar.js calendar,
configured to show one or more webforms and their booking elements. The calendar is fed by a JSON
endpoint (route `webform_booking_calendar.data` = `/webform-booking-calendar-data/{webform_ids}/{element_names}`,
controller `WebformBookingCalendarController::getEvents`, permission
**`view webform booking calendar`** — `restrict access: true`), which reads booking submissions from the
database and turns each into a calendar event (using `BookingValue` to parse the stored slot). It ships
its own FullCalendar CSS/JS assets and requires the FullCalendar library. Marked `lifecycle:
experimental`. Enable with `drush en webform_booking_calendar`, then place and configure the block.

---

- Show all bookings for a webform on a month/week/day calendar.
- Give staff an at-a-glance view of upcoming appointments.
- Combine bookings from multiple webforms in one calendar.
- Restrict the calendar to specific booking elements.
- Place the calendar block on an admin or staff-only page.
- Gate calendar visibility behind the `view webform booking calendar` permission.
- Visualise slot occupancy over time.
- Provide a customer-facing (permissioned) schedule view.
- Feed a FullCalendar instance with a JSON events endpoint scoped by webform/element ids.
- Spot busy vs quiet periods for capacity planning.
- Switch between month, week, and day calendar views.
- See booking details (duration, customer info) on each calendar entry.
- Embed the calendar on a dashboard page via Block Layout.
- Give reception staff a live schedule of appointments.
- Cross-check availability visually before manually adjusting bookings.
- Display bookings from several booking elements on one form together.
- Provide a read-only schedule to a role without submission-edit access.
- Use the calendar as a quick sanity check that bookings are being recorded.
