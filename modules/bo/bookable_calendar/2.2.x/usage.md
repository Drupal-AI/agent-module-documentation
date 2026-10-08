<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bookable Calendar lets you publish calendars of bookable time slots that visitors can reserve, with configurable capacity, party size, booking windows, email notifications and admin check-in.

---

The module defines a small entity model built on Smart Date: a **Bookable Calendar** (the container, with slots-per-opening and messages), **Bookable Calendar Opening** (a recurring/one-off open period whose Smart Date recurrence generates **Opening Instances** — the individual bookable slots), **Booking Contact** (a person's reservation: email, party size, reference to an instance) and **Booking** (one seat per party member, auto-created/removed to match `party_size` on save). Visitors book via a Drupal form (`booking_contact` add form at `/bookable-calendar/.../book`) or via JSON/AJAX endpoints; capacity, party-size, active-window, not-in-past, too-soon/too-far and per-user/site-wide booking limits are enforced by field validation constraints on `party_size`. Booking confirmation and cancellation emails are sent through `hook_mail` using admin-editable templates with tokens (a rich `booking_contact`/`bookable_calendar`/`booking` token set, including a `hashed_login_url` "manage your booking" link for account-less users). Admins get overview Views (bookings, contacts, notifications, opening instances), a per-calendar check-in screen, and check-in/check-out and bookings JSON APIs. It ships default Views and an optional ECA model, integrates with `fullcalendar_block`-style output via an openings endpoint, and provides a settings form for the notification templates and site-wide max-open-bookings / one-click booking. A submodule, `bookable_calendar_vbo_booking`, adds Views Bulk Operations actions to bulk-book or bulk-remove bookings on opening instances. Global settings live at `/admin/config/system/bookable-calendar`; entities are managed under `/admin/structure/bookable-calendar` and `/admin/content/bookable-calendar/...`.

---

- Publish a calendar of appointment slots visitors can reserve online.
- Let anonymous visitors book a time slot by entering their email and party size.
- Run event registration where each slot has a fixed number of seats (slots per opening).
- Cap the party size per booking and reject over-capacity requests via validation.
- Define recurring weekly openings (via Smart Date recurrence) that auto-generate bookable instances.
- Prevent bookings in the past, too soon, or too far in the future with built-in constraints.
- Limit how many open bookings a single user may hold (per-calendar and site-wide).
- Send an automatic confirmation email to the person who books, with a manage-booking link.
- Send admins a notification email whenever a booking is created or cancelled.
- Customize all email subjects/bodies using booking tokens on the settings form.
- Let account-less visitors view/edit/cancel their booking through a tokenized "manage booking" link.
- Provide a check-in screen for staff to mark attendees as checked in on the day.
- Check attendees in/out programmatically via JSON API endpoints.
- Expose a bookings JSON feed for a given calendar and date range (admin) for dashboards.
- Feed opening times to a FullCalendar-style front-end via the openings endpoint.
- Book a slot over a JSON API (`POST /bookable-calendar/{instance}/book`) from a decoupled front end.
- Book multiple opening instances in one API call (`POST /bookable-calendar/api/book`).
- Book and cancel via AJAX without a full page reload.
- Offer one-click booking on the calendar display (site-wide toggle).
- Bulk-book many opening instances at once for staff via the VBO submodule.
- Bulk-remove all bookings on selected opening instances via the VBO submodule.
- Translate calendar titles/descriptions and notification settings (config translation).
- Restrict who can create/view/edit bookings and calendars via the granular permission set.
- Reserve resources (rooms, equipment) as time slots with capacity.
- Manage community class or workshop sign-ups with attendance tracking.
- Automatically keep individual Booking records in sync with the requested party size.
- Drive follow-up workflows from booking events using the shipped ECA model.
