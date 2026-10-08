<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Bookable Calendar

## Entity model
- **Bookable Calendar** (`bookable_calendar`) — container; holds `title`, `description`,
  `slots_per_opening`, `success_message`, and per-calendar notification override (`notifications`).
- **Bookable Calendar Opening** (`bookable_calendar_opening`) — an open period; uses Smart Date
  (+ recurrence) to describe when it is open, plus optional `slots`.
- **Bookable Calendar Opening Instance** (`bookable_calendar_opening_inst`) — a single bookable slot,
  auto-generated from an Opening's dates (batch `bookable_calendar_process_opening_instances`).
- **Booking Contact** (`booking_contact`) — one person's reservation: `email` (required), `party_size`
  (required, default 1), `booking_instance` (ref to an instance), `uid`, `checked_in`, `booking`
  (refs), `notifications`. On save it auto-creates/removes `Booking` children to match `party_size`.
- **Booking** (`booking`) — one seat; created/deleted to keep the party size in sync.

Manage entities at `/admin/structure/bookable-calendar` (calendars/openings/instances) and
`/admin/content/bookable-calendar/...` (contacts/bookings). Each entity type has its own
settings/field-UI route (`entity.<type>.settings`).

## Capacity & booking-window rules
Enforced as validation constraints on `Booking Contact::party_size`:
`CalendarOpeningVacancy`, `CalendarOpeningMaxPartySize`, `CalendarOpeningIsActive`,
`CalendarOpeningNotInPast`, `CalendarOpeningTooSoon`, `CalendarOpeningTooFarAway`,
`CalendarOpeningMaxBookingsClaimedByUser`, `CalendarOpeningMaxBookingsClaimedSitewideByUser`.
A user with `bypass booking contact checks` (restrict-access) may book outside these rules.

## Global settings form
Route `bookable_calendar.settings_form` → `/admin/config/system/bookable-calendar`
(permission `administer bookable_calendar configuration`). Config `bookable_calendar.settings`:

- `email_settings.admin_email`: `subject`, `body`, `subject_cancel`, `body_cancel` — emails to admins
  on create/cancel.
- `email_settings.user_email`: `subject`, `body`, `subject_cancel`, `body_cancel` — emails to the
  person who booked. Default user body includes `[booking_contact:hashed_login_url]`.
- `sitewide_settings.max_open_bookings` (default `0` = unlimited) and `one_click_booking` (bool).

Emails are sent via `hook_mail` key `bookable_calendar_notification` (from = site mail) by the
`bookable_calendar.notification` service, on booking create and on booking-contact delete.
Config translation is supported (`bookable_calendar.settings_form`).

## Tokens (for email templates)
Types `bookable_calendar` (`title`, `description`), `booking` (`date`, `created`, `values`), and
`booking_contact`:
`url`, `email`, `party_size`, `values` (raw multi-line summary), `hashed_login_url` (tokenized
manage-booking link), `calendar_title`, `instance_id`, `instance_title`, `date`, `created`.
The settings and calendar forms show a token browser when the `token` module is enabled.

## Front-end display
`bookable_calendar` renders instances with availability and a book link (extra fields
`instances`, `availability`, `book_link`). Views shipped: `bookable_calendar`, `bookings`,
`booking_contact`, `booking_notifications`, `bookable_calendar_opening`,
`bookable_calendar_opening_instances`. An optional ECA process model ships under `config/optional`.
