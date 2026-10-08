<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# HTTP endpoints (routing.yml)

Controller: `BookableCalendarApiController`. Entity params are upcast from the URL. All write paths
delegate to `bookable_calendar.reservation_manager` (lock + transaction + in-transaction validation).

## Booking (write) — permission `create booking contact`
| Route | Method | Path | Notes |
|---|---|---|---|
| `bookable_calendar.booking_contact.create` | GET | `/bookable-calendar/booking-calendar-opening-instance/{opening_instance}/book` | Drupal entity add form (`booking_contact.add`); hides `booking_instance`/`uid`, defaults email for logged-in users. |
| `bookable_calendar.api.booking_contact.create` | POST | `/bookable-calendar/{opening_instance}/book` | JSON. `{status, status_code, message}`. CSRF header required. |
| `bookable_calendar.api.booking_contact.multiple.create` | POST | `/bookable-calendar/api/book` | Body `{contact_info:{email,party_size}, opening_instances:[ids]}`; atomic multi-instance placement. CSRF header. |
| `bookable_calendar.ajax.booking_contact.create` | POST | `/ajax/bookable-calendar/{opening_instance}/book` | `AjaxResponse` (MessageCommand). CSRF header. |
| `bookable_calendar.ajax.booking_contact.delete` | POST | `/ajax/bookable-calendar/{opening_instance}/cancel` | Cancels the current user's own reservations on that instance. CSRF header. |

`doBook()` accepts a JSON body (`contact_info`) or POST form-data, forces `booking_instance` to the
URL's instance, and passes **only** `email` + `party_size` to the reservation manager while forcing
`uid` to the authenticated account (no client-supplied owner/check-in). `bookMultiple()` validates
every id exists (404 otherwise) and places them atomically. Result codes: 201 success, 400 bad
request, 404 missing instance, 422 validation failure, 409 lock contention.

`cancelAjax` queries `booking_contact` where `uid = currentUser` **and `uid <> 0`**, so it only
cancels a logged-in user's own bookings; anonymous (uid 0) bookings are not reachable by this path.

## Admin / staff
| Route | Method | Path | Permission | Returns |
|---|---|---|---|---|
| `bookable_calendar.api.booking_contact.check_in` | POST | `/bookable-calendar/api/{booking_contact}/check-in` | `administer booking contact` (+CSRF) | sets `checked_in = TRUE`. |
| `bookable_calendar.api.booking_contact.check_out` | POST | `/bookable-calendar/api/{booking_contact}/check-out` | `administer booking contact` (+CSRF) | sets `checked_in = FALSE`. |
| `bookable_calendar.api.booking.get` | GET | `/bookable-calendar/api/{bookable_calendar}/bookings` | `administer booking contact` | JSON rows (id, checked_in, email, date, party_size, created). Query `start`/`end` (strtotime) set the range (default today→tomorrow). |
| `bookable_calendar.booking.check_in` | GET | `/admin/bookable-calendar/{bookable_calendar}/check-in` | `edit booking contact` | staff check-in screen (`BookableCalendarCheckInController`). |

## Read — permission `view bookable calendar`
| Route | Method | Path | Returns |
|---|---|---|---|
| `bookable_calendar.openings` | GET | `/bookable-calendar/api/{bookable_calendar}/openings` | JSON of opening instances (`title,start,end,url`) for FullCalendar-style display; skips externally-busy instances. No PII. |

## Admin config / list routes
Settings form `bookable_calendar.settings_form` and `bookable_calendar.notification_preview` require
`administer bookable_calendar configuration`. The `entity.*.settings` field-UI routes and the
`bookable_calendar.list` overview are gated by the respective `administer *` (restrict-access)
permissions.

## JSON:API
When core JSON:API is enabled, the content entities are discoverable. Reservation writes to
`booking_contact--booking_contact` (POST `/jsonapi/booking_contact/booking_contact`) use the same
locking, validation, ownership, and events as the forms (guarded storage). Cookie-authenticated
writes need `X-CSRF-Token`. Server-managed fields (`uid`, `checked_in`, notification fields) are not
client-settable (entity field access). There is **no** `booking--booking` resource in 3.x. On priced
(Commerce) calendars, direct reservation writes are rejected so the API cannot bypass checkout.
