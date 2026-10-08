<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bookable Calendar — agent index

Bookable time-slot calendars built on Smart Date. Entities: Bookable Calendar → Opening →
Opening Instance (a slot); Booking Contact (a reservation) → Booking (a seat). Depends on `text`,
`views`, `smart_date`(+`smart_date_recur`). Config UI at `/admin/config/system/bookable-calendar`.

- **Settings form, entity model, capacity/party-size, notification email templates + token set** → [configure/settings.md](configure/settings.md)
- **HTTP endpoints: booking (form/JSON/AJAX), cancel, check-in/out, bookings & openings feeds** → [api/http-endpoints.md](api/http-endpoints.md)
- **The full permission set and the account-less booking access model (token/tempstore)** → [permissions/permissions.md](permissions/permissions.md)

Submodule:
- `bookable_calendar_vbo_booking` (VBO bulk booking) → [../../modules/bookable_calendar_vbo_booking/2.2.x/agent/start.md](../../modules/bookable_calendar_vbo_booking/2.2.x/agent/start.md)

Key facts:
- Booking write endpoints require permission `create booking contact` (NOT restrict-access — meant to
  be grantable to anonymous for public calendars).
- `party_size` field carries the capacity/window constraints (`CalendarOpeningVacancy`,
  `CalendarOpeningMaxPartySize`, `CalendarOpeningIsActive`, `CalendarOpeningNotInPast`,
  `CalendarOpeningTooSoon`, `CalendarOpeningTooFarAway`, `CalendarOpeningMaxBookingsClaimedByUser`,
  `CalendarOpeningMaxBookingsClaimedSitewideByUser`). `bypass booking contact checks` skips them.
- No Drush. Config schema + config translation. Default Views + optional ECA model shipped.
