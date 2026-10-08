<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bookable Calendar — agent index

Capacity-aware appointment/event reservations built on Smart Date, rewritten for Drupal 11+ (3.x).
Entities: **Bookable Calendar → Opening → Opening Instance** (a slot); **Booking Contact** (a
reservation, carrying `party_size`). Depends on `text`, `views`, `smart_date`(+`smart_date_recur`).
Requires PHP 8.3+ with ext-sodium and Smart Date `^4.3`. Config UI at
`/admin/config/system/bookable-calendar`.

- **Entity model, fields, reservation manager, capacity/window constraints, notifications** → [entities/entities.md](entities/entities.md)
- **Global settings form, email templates + token set, config schema** → [configure/settings.md](configure/settings.md)
- **HTTP endpoints: booking (form/JSON/AJAX), cancel, check-in/out, bookings & openings feeds, JSON:API** → [api/http-endpoints.md](api/http-endpoints.md)
- **Full permission set, calendar ownership ("own") model, account-less signed-token booking access** → [permissions/permissions.md](permissions/permissions.md)
- **Submodules: Commerce checkout, external sync, Google, Microsoft, VBO bulk booking** → [integrations/integrations.md](integrations/integrations.md)

Key facts:
- `booking_contact` entity type ID is retained from 2.x; the separate 2.x `booking` (per-seat) entity
  is **removed** in 3.0 — one reservation is now one `booking_contact` with a `party_size` integer.
- All module-owned writes (form, one-click, custom API, JSON:API, check-in, delete, VBO, Commerce
  holds) route through `bookable_calendar.reservation_manager` (`ReservationManager`): persistent
  per-instance lock → DB transaction → in-transaction `validate()` → commit → post-commit events.
  A guarded storage (`BookingContactStorage`) blocks direct entity saves that bypass it.
- Booking write endpoints require permission `create booking contact` (NOT restrict-access — meant to
  be grantable to anonymous for public calendars); cookie-authenticated custom POSTs also require
  `X-CSRF-Token`.
- `party_size` carries the capacity/window constraints (`CalendarOpeningVacancy`,
  `CalendarOpeningMaxPartySize`, `CalendarOpeningIsActive`, `ExternalCalendarAvailability`,
  `CalendarOpeningNotInPast`, `CalendarOpeningTooSoon`, `CalendarOpeningTooFarAway`,
  `CalendarOpeningMaxBookingsClaimedByUser`, `CalendarOpeningMaxBookingsClaimedSitewideByUser`).
  `bypass booking contact checks` (restrict-access) skips them.
- Account-less "manage your booking" links use an **HMAC signed, expiring** token
  (`BookingContactAccessToken`, keyed by the site private key) — not a guessable hash.
- Notifications are queued and deduplicated, HTML-capable, language-aware, with a preview form;
  reminders are an optional ECA/BPMN.iO integration. No Drush. Config schema + config translation.
