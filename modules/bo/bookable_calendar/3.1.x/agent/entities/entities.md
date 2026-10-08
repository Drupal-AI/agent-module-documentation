<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity model & reservation flow

## Entity types
- **Bookable Calendar** (`bookable_calendar`) — revisionable, translatable container. Uses
  `EntityOwnerTrait` (`uid` = **owner**, new in 3.1). Fields include `title`, `description`,
  `success_message`, capacity/policy fields (`slots_per_opening`, `max_party_size`,
  `max_open_bookings`, `slots_as_parties`, `book_in_progress`, `one_click_booking`, `active`,
  `status`), booking-window fields (`booking_lead_time`, `booking_future_time`), and per-calendar
  notification fields (`notification_email`, `notification_email_override`,
  `notification_email_subject[_cancel]`, `notification_email_body[_cancel]`,
  `admin_notification_email`, `notify_email_recipient_role`, `notify_email_recipients`).
- **Bookable Calendar Opening** (`bookable_calendar_opening`) — an open period; Smart Date
  (+ recurrence) describes when it is open, plus optional `slots`. References its parent calendar.
- **Bookable Calendar Opening Instance** (`bookable_calendar_opening_inst`) — a single reservable
  slot, generated from an Opening by `OpeningInstanceSynchronizer`
  (`bookable_calendar.opening_instance_synchronizer`). This is the capacity + locking boundary.
  Fields: `title`, `booking_opening` (ref), `date` (smartdate), computed `available_slots` /
  `max_slots`, optional per-instance `slots`, and internal `external_calendar_busy` (set by inbound
  availability sync).
- **Booking Contact** (`booking_contact`) — one reservation. Fields: `email` (required),
  `party_size` (required, default 1, min 1, carries all booking constraints), `booking_instance`
  (ref to an instance, required), `uid` (owner, server-managed), `checked_in` (admin-only),
  `reservation_state` (`confirmed` | `pending_payment`, internal), `hold_expires` (internal, for
  Commerce holds), `notifications` (internal, dedup history), `created`, `changed`. The 2.x per-seat
  `booking` entity is **gone**; `party_size` replaces it.

Manage at `/admin/structure/bookable-calendar` (calendars/openings/instances field-UI settings) and
`/admin/content/bookable-calendar/...` (contacts). Public canonical paths are hyphenated, e.g.
`/bookable-calendar/{bookable_calendar}` and
`/bookable-calendar/booking-contact/{booking_contact}`.

## Capacity math
`BookableCalendarOpeningInstance::slotsAvailable()` = `max_slots − claimed`. `max_slots` resolves
per-instance `slots` → parent opening `slots` → calendar `slots_per_opening`. If
`slots_as_parties` is on, `claimed` is the count of reservations; otherwise it is the sum of
`party_size`. An externally-busy instance reports 0 available and is not accepting bookings.

## Reservation manager (the write boundary)
Service `bookable_calendar.reservation_manager` (`ReservationManager`, interface
`ReservationManagerInterface`). Every module-owned mutation goes through it:

- `place($instance, $values)` / `placeMultiple($instances, $values)` — create reservation(s);
  multi is atomic (all instances locked in sorted order, one transaction, all-or-nothing).
- `save($reservation)` — create/update with re-validation under lock.
- `cancel($reservation)` — delete under lock; revokes the access token and dispatches a cancel
  event if it was confirmed.
- `setCheckedIn($reservation, bool)` — toggle attendance + event.
- `hold($reservation, $expires)` / `confirm($reservation)` — Commerce `pending_payment` holds and
  post-payment confirmation (holds count capacity but do not notify or sync until confirmed).

Mechanism per write: acquire persistent lock `bookable_calendar:opening-instance:{id}` (timeout 30s,
one retry after a 5s wait, else `ReservationLockException`) → reset instance cache → `startTransaction`
→ `normalizeOwner` (sets `uid` from the current account on new rows) → entity `validate()` →
`rawSave` → commit or rollback → dispatch domain events **after commit**
(`ReservationPlacedEvent`, `ReservationUpdatedEvent`, `ReservationCancelledEvent`,
`ReservationCheckInChangedEvent`). `BookingContactStorage` is a guarded storage that only permits
writes originating inside a `ReservationWriteContext`, so a direct `->save()` cannot bypass the
capacity/lock path.

## Validation constraints (on `party_size`)
`CalendarOpeningVacancy`, `CalendarOpeningMaxPartySize`, `CalendarOpeningIsActive`,
`ExternalCalendarAvailability`, `CalendarOpeningNotInPast`, `CalendarOpeningTooSoon`,
`CalendarOpeningTooFarAway`, `CalendarOpeningMaxBookingsClaimedByUser`,
`CalendarOpeningMaxBookingsClaimedSitewideByUser`. Holders of `bypass booking contact checks`
(restrict-access) may book outside them. The Commerce submodule adds a `CommerceCheckoutRequired`
constraint that rejects direct placement on priced calendars.

## Notifications
Service `bookable_calendar.notification` (`Notification`) + `ReservationNotificationSubscriber`
(event subscriber) + `NotificationQueueWorker`. On a committed placement/cancellation it composes
per-recipient localized messages (admin recipients from `notify_email_recipient_role` /
`notify_email_recipients`; the booker from the reservation email), deduplicates on a
`bookable_calendar_notification_delivery` table (sha256 dedupe key), enqueues to the
`bookable_calendar_notifications` queue, and delivers via `hook_mail`
(`bookable_calendar_notification`, body run through `Xss::filterAdmin`, `text/html`). Templates come
from global config or per-calendar overrides. Time-based reminders are optional (ECA + BPMN.iO).

## Theming / SDC / Views helpers
`hook_theme` themes: `bookable_calendar`, `bookable_calendar_opening`, `booking_contact`,
`bookable_calendar_opening_inst`, `admin_booking_list`. Schema-backed Single Directory Components in
`components/` (availability, booking-action, opening-list-day). `hook_views_data_alter` adds the
computed `available_slots` (field/filter/argument), `max_slots`, `minimum_available_slots`, and
`book_link` Views handlers. Extra display fields: calendar `instances`; instance `availability`,
`book_link`.
