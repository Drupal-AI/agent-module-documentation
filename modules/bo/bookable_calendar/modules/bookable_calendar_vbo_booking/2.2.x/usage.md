<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bookable Calendar VBO Booking adds Views Bulk Operations actions that let staff bulk-create Booking Contacts for (or bulk-remove bookings from) many Bookable Calendar Opening Instances at once.

---

This submodule of Bookable Calendar depends on Views Bulk Operations (VBO). On a View that lists
`bookable_calendar_opening_inst` entities you add a VBO field and enable its actions:
`bookable_calendar_vbo_booking` ("Book Opening Instances", a VBO action derived from
views_bulk_edit that collects contact/party details and books each selected instance),
`remove_bookings_on_opening` ("Remove Bookings On Opening Instance", which deletes the Booking Contacts
attached to each selected instance), and an `entity:book_action` deriver-based action. There is also a
manual booking form at `/admin/content/bookable-calendar/booking-contact-multiple/add`. Access is gated
by a `use views bulk booking` permission and, per-action, by `update` access on the target opening
instance entities. The README warns it is a modified clone of views_bulk_edit and should only be used on
Opening Instance views. It has no config form, schema, or Drush.

---

- Book the same contact into many opening instances in one bulk operation.
- Bulk-create bookings across a week of slots from an admin Opening Instances view.
- Remove all bookings on selected opening instances at once (e.g. cancel a day).
- Give staff a VBO-driven manual multi-booking form.
- Pre-fill the booking email/uid from the logged-in staff user during bulk booking.
- Set up recurring staff workflows that reserve capacity in bulk.
- Clear out test or erroneous bookings across multiple slots quickly.
- Combine with Views filters to target only specific openings for bulk booking.
- Restrict bulk booking to trusted staff via the `use views bulk booking` permission.
- Respect per-instance update access when bulk-acting on opening instances.
- Book blocks of instances for an offline/phone reservation entered by staff.
- Free up capacity by bulk-removing bookings before republishing a schedule.
- Use the confirm-step form to enter party size/contact for the whole selection.
- Manage large calendars where per-slot booking would be tedious.
- Support event teardown by mass-removing attendees from past instances.
