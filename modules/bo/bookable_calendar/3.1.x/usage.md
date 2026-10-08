<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bookable Calendar lets you publish calendars of bookable time slots that visitors can reserve, with configurable capacity, party size, booking windows, queued email notifications, admin check-in, optional paid checkout through Drupal Commerce, and optional two-way sync with Google Calendar and Microsoft Outlook. Version 3.x is a Drupal 11+ rewrite around a transactional reservation model.

---

The module defines an entity model built on Smart Date: a **Bookable Calendar** (the container, holding capacity defaults, booking policies, ownership and notification settings), a **Bookable Calendar Opening** (a one-off or recurring open period whose Smart Date recurrence generates individual slots), a **Bookable Calendar Opening Instance** (a single reservable slot — the capacity and locking boundary), and a **Booking Contact** (one reservation, carrying the customer email, `party_size`, the booked instance, owner, check-in state, and notification history). The separate 2.x per-seat `booking` entity is removed; a reservation is now one Booking Contact with a party size. Visitors book through a Drupal form, custom JSON/AJAX endpoints, or JSON:API — and every module-owned create, update, check-in, or cancellation passes through the transactional `ReservationManager`, which holds a persistent per-instance lock, opens a database transaction, re-validates capacity/window/limit constraints inside the lock, saves atomically (all instances in a multi-booking request or none), and dispatches events only after commit. A guarded storage prevents integrations from bypassing capacity with a direct save. Capacity, max party size, active window, not-in-past, too-soon/too-far, per-user and site-wide booking limits, and external-calendar availability are enforced as validation constraints on `party_size`; `bypass booking contact checks` skips them. Confirmation and cancellation emails are queued, deduplicated, HTML-capable, language-aware, and previewable, using admin-editable templates and a rich token set (including a signed, expiring `hashed_login_url` "manage your booking" link for account-less customers). Calendar ownership lets non-admin schedule managers maintain only their own calendars. Optional submodules add Drupal Commerce checkout with capacity-safe payment holds, and per-calendar, per-reservation private-event sync (plus opt-in inbound busy-time blocking) with Google Calendar and Microsoft Outlook via OAuth. Global settings live at `/admin/config/system/bookable-calendar`; entities are managed under `/admin/structure/bookable-calendar` and `/admin/content/bookable-calendar/...`, including a per-calendar staff check-in screen. A `bookable_calendar_vbo_booking` submodule adds Views Bulk Operations bulk booking, and optional ECA/BPMN.iO integration drives time-based reminders.

---

- Publish a calendar of appointment slots visitors can reserve online.
- Let anonymous visitors book a slot by entering their email and party size (grant `create booking contact`).
- Run event registration where each slot has a fixed number of seats (slots per opening).
- Cap the party size per booking and reject over-capacity requests via server-side validation.
- Treat slots as parties so a fixed number of groups (each up to the party-size limit) can claim a slot.
- Define one-off or recurring weekly openings with Smart Date that auto-generate bookable instances.
- Prevent bookings in the past, too soon, or too far in the future with built-in constraints.
- Limit how many open bookings a single user may hold (per-calendar and site-wide).
- Prevent concurrent requests from overbooking the same opening through persistent per-instance locks.
- Send queued, deduplicated confirmation and cancellation emails with HTML templates and tokens.
- Give account-less customers a signed, expiring "manage your booking" link to view, edit, or cancel.
- Preview saved email templates before going live, and override templates per calendar.
- Let non-admin schedule managers own and manage only their own calendars and openings.
- Provide a staff check-in screen and check attendees in/out programmatically via JSON endpoints.
- Book a slot over JSON (`POST /bookable-calendar/{instance}/book`) from a decoupled front end.
- Book multiple opening instances atomically in one API call (`POST /bookable-calendar/api/book`).
- Book and cancel via AJAX without a full page reload, and offer one-click booking for logged-in users.
- Create, read, update, and delete reservations through Drupal JSON:API with the same locking and access rules.
- Feed opening times to a FullCalendar-style front end via the openings endpoint or the FullCalendar module.
- Take payment for reservations through Drupal Commerce checkout with capacity-safe payment holds.
- Charge once per reservation or per attendee, releasing held capacity when checkout expires or is cancelled.
- Sync each confirmed reservation to Google Calendar or Outlook as a private event inviting only that customer.
- Add a unique Google Meet or Microsoft Teams online meeting to each reservation event.
- Block booking of slots that conflict with busy events on a connected Google or Outlook calendar (opt-in).
- Bulk-book or bulk-remove reservations across many opening instances via the VBO submodule.
- Drive day-before reminder workflows from booking events using the optional ECA integration.
- Translate calendar titles, descriptions, and notification settings with config translation.
- Reserve rooms, equipment, or other limited resources as capacity-limited time slots.
