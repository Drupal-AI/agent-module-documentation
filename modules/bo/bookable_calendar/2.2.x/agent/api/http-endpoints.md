<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# HTTP endpoints (routing.yml)

Controller: `BookableCalendarApiController`. Entity params are upcast from the URL.

## Booking (write) — permission `create booking contact`
| Route | Method | Path | Notes |
|---|---|---|---|
| `bookable_calendar.booking_contact.create` | GET | `/bookable-calendar/booking-calendar-opening-instance/{opening_instance}/book` | Drupal entity add form (`booking_contact.add`). |
| `bookable_calendar.api.booking_contact.create` | POST | `/bookable-calendar/{opening_instance}/book` | JSON. Returns `{status, message}`. |
| `bookable_calendar.api.booking_contact.multiple.create` | POST | `/bookable-calendar/api/book` | Body `{contact_info, opening_instances:[...]}`. |
| `bookable_calendar.ajax.booking_contact.create` | POST | `/ajax/bookable-calendar/{opening_instance}/book` | AjaxResponse (MessageCommand). |
| `bookable_calendar.ajax.booking_contact.delete` | POST | `/ajax/bookable-calendar/{opening_instance}/cancel` | Deletes the current user's contacts on that instance. |

`doBook()` accepts a JSON body (`contact_info`) or POST form-data, forces `booking_instance` to the
URL's instance, requires `email` + `party_size`, runs entity `validate()` (the party_size
constraints), then saves. `bookMultiple()` loops `opening_instances`.

Cancel (`cancelAjax`) deletes `opening_instance->getBookingContactsByCurrentUser()`, which queries
`booking_contact` by `uid = currentUser` **and `uid <> 0`** — so it only affects logged-in users'
own bookings; anonymous (uid 0) bookings are excluded from this path.

## Admin / staff — permission `administer booking contact` (restrict-access)
| Route | Method | Path | Returns |
|---|---|---|---|
| `bookable_calendar.api.booking_contact.check_in` | POST | `/bookable-calendar/api/{booking_contact}/check-in` | sets `checked_in = TRUE`. |
| `bookable_calendar.api.booking_contact.check_out` | POST | `/bookable-calendar/api/{booking_contact}/check-out` | sets `checked_in = FALSE`. |
| `bookable_calendar.api.booking.get` | GET | `/bookable-calendar/api/{bookable_calendar}/bookings` | JSON rows (id, checked_in, email, date, party_size, created). Query `start`/`end` (strtotime) set the range (default today→tomorrow). |

`bookable_calendar.booking.check_in` (`/admin/bookable-calendar/{bookable_calendar}/check-in`,
permission `edit booking contact`) renders the staff check-in screen.

## Read — permission `view bookable calendar`
| Route | Method | Path | Returns |
|---|---|---|---|
| `bookable_calendar.openings` | GET | `/bookable-calendar/api/{bookable_calendar}/openings` | JSON of opening instances (`title,start,end,url`) for FullCalendar-style display. |

## Admin config/list routes
Settings form `bookable_calendar.settings_form` and the `entity.*.settings` field-UI routes are all
gated by `administer *` (restrict-access) permissions; the overview list is
`bookable_calendar.list` (`administer bookable calendar`).
