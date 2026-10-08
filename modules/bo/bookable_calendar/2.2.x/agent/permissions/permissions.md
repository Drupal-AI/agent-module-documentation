<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions & account-less booking access

## Permissions (`bookable_calendar.permissions.yml`)
Per entity type there is an `administer <thing> settings` (`restrict access: true`) plus CRUD-style
grants. Notable ones:

- `create booking contact` — **not** restrict-access. Required by all booking write endpoints
  (form/JSON/AJAX book + cancel). Grant to `anonymous`/`authenticated` for a public booking calendar.
- `view booking contact`, `edit booking contact`, `delete booking contact` — booking-contact CRUD.
- `administer booking contact` (restrict-access) — admin of contacts; also gates check-in/out and the
  bookings JSON feed; also the entity `admin_permission`.
- `bypass booking contact checks` (restrict-access) — book outside the validation constraints
  (e.g. in the past / over limits).
- `view bookable calendar` — required by the openings feed.
- `edit booking contact` — required by the staff check-in screen route.
- Calendar / opening / opening-instance / booking each have their own
  `administer/access overview/create/view/edit/delete` permissions (most `administer *` are
  restrict-access).

## Account-less ("manage your booking") access model
`BookingContactAccessControlHandler` grants view/update/delete when the account has the relevant
permission, OR when `checkAccessAlt()` passes for a non-logged-in visitor, which is TRUE if either:
1. **Tempstore** — `tempstore.private` `booking_contact` has this contact id set to TRUE. The creator
   is granted this on save via `BookingContact::tempGrantAccess()` (session-scoped).
2. **Token** — the request `?email=` and `?login_token=` query params satisfy
   `BookingContact::validateLoginToken($email,$token)`.

`generatePublicLoginLink()` builds the emailed URL
`/bookable-calendar/booking-contact/{id}/edit?email=<email>&login_token=<token>` (token
`[booking_contact:hashed_login_url]`). The booking-contact entity's own `access()` additionally allows
owners (matching `uid`) and holders of `access user profiles`.
