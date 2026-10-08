<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions & account-less booking access

## Permissions (`bookable_calendar.permissions.yml`)
Each entity type has an `administer <thing> settings` (`restrict access: true`, also the entity
`admin_permission`) plus CRUD-style grants. Notable ones:

- `create booking contact` — **not** restrict-access. Required by all booking write endpoints
  (form/JSON/AJAX book + cancel, and the JSON:API create). Grant to `anonymous`/`authenticated` for
  a public booking calendar.
- `view booking contact`, `edit booking contact`, `delete booking contact` — booking-contact CRUD.
- `access booking contact overview` — the admin overview page of booking contacts.
- `administer booking contact` (restrict-access) — gates check-in/out, the bookings JSON feed, and
  server-managed field edits.
- `bypass booking contact checks` (restrict-access) — book outside the validation constraints
  (e.g. in the past / over limits).
- `view bookable calendar` — required by the openings feed and calendar view access.
- `edit booking contact` — required by the staff check-in screen route.

### Calendar ownership ("own") model — new in 3.1
Each Bookable Calendar has an **owner** (`uid`, `EntityOwnerTrait`). To let teachers/schedule
managers maintain only their own calendars, the permission set adds owner-scoped grants used by the
access handlers:

- `create bookable calendar`, `edit own bookable calendar`, `delete own bookable calendar`.
- `create own bookable calendar opening`, `edit own bookable calendar opening`,
  `delete own bookable calendar opening`.

`BookableCalendarAccessControlHandler::checkOwnerAccess()` grants update/delete when the
non-anonymous account owns the calendar (`uid === account id`) AND holds the matching "own"
permission. Owners cannot reassign ownership (`uid` field is `administer bookable calendar` only),
move an opening to another user's calendar, or edit notification recipients/templates (those calendar
fields require `edit/administer bookable calendar`). Global (non-own) `edit/delete bookable calendar`
and the `administer *` permissions bypass the owner check. Opening-instance and Commerce/external
settings keep their separate administrative permissions. (Calendars created before the 3.1 update are
left unassigned; an admin selects an owner.)

## Access handlers (summary)
- **Bookable Calendar**: `view` → `view bookable calendar`; `update`/`delete` → global perm OR owner
  ("own") access. Field access restricts `uid` and all notification fields.
- **Opening Instance**: `view` → `view bookable calendar opening instance`; update/delete → perms.
- **Booking Contact**: `view`/`update`/`delete` → the matching perm OR `administer booking contact`
  OR **ownership** (`uid === account id`, non-anonymous) OR the signed-token/session path below.
  `checkCreateAccess` → `create booking contact` / `administer booking contact`. Field access:
  `uid`, `notifications`, `created`, `changed` are server-managed (edit forbidden); `checked_in`
  requires `administer booking contact`.

## Account-less ("manage your booking") access model
`BookingContactAccessControlHandler::checkAlternateAccess()` grants view/update/delete to a
non-account holder when either:
1. **Signed token** — the request `?login_token=` validates against
   `BookingContactAccessToken::validate()` for that reservation. The token is an HMAC
   (`Crypt::hmacBase64` over entity type + UUID + lowercased email + a random per-booking
   `generation` + `expires`), keyed by the site private key, compared with `hash_equals`, and
   expiring after 30 days; it is stored in non-exported key-value storage and revoked on cancel. The
   emailed link (`[booking_contact:hashed_login_url]`) points at the edit form with that token.
2. **Session tempstore** — the creating session is remembered in `tempstore.private`
   (`booking_contact` collection) by the reservation manager, so the booker who just placed the
   reservation can manage it in that session. A successful token check also seeds this.

Both paths are non-cacheable (`login_token` query context + `session`, max-age 0). Ownership by
`uid` covers logged-in bookers separately.
