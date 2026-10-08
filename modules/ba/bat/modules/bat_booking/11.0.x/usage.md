BAT Booking adds the `bat_booking` content entity — a reservation record that ties together a customer, a date range, and the BAT availability events it creates. It provides fieldable booking bundles and helper fields (start date, end date, event reference) so a booking can drive the availability calendar.

---

The module defines the `bat_booking` content entity (base table `booking`, bundle entity
`bat_booking_bundle`, config schema `bat_booking.booking_bundle.*`). A booking is owner-aware
(`uid`), has a `label`, a published `status`, and a bundle `type`. Rather than hardcoding a schema,
the module attaches configurable fields to each booking bundle through
`bat_booking_add_start_date_field()`, `bat_booking_add_end_date_field()`, and
`bat_booking_add_event_reference_field()`, so each booking type can carry its own check-in/check-out
dates and a reference to the `bat_event` records it produced. On `hook_entity_insert`
(`bat_booking_entity_insert`) a booking wires up its related events, and deleting a booking dispatches
a `DeleteBatBooking` event (`bat_booking_delete_booking`) that other modules can subscribe to (e.g. to
free up the calendar). Access delegates to the base `bat_entity_access()` model; the module adds a
`book units` permission for the booking flow and `administer bat_booking_bundle entities` for
managing bundles. A `bat_booking_example` submodule demonstrates a front-end "book this" flow
(a Views field + confirmation form). Admin pages live under `/admin/bat/config/booking`.

---

- Record a reservation (customer + date range) as a `bat_booking` entity.
- Create multiple booking bundles (e.g. `standard`, `event`) with their own fields.
- Attach check-in / check-out date fields to a booking bundle automatically.
- Reference the availability `bat_event` records a booking created via the event-reference field.
- Drive the BAT availability calendar from a booking (blocks the booked period).
- Free up availability when a booking is deleted by subscribing to the `DeleteBatBooking` event.
- Grant a "book units" permission to the roles allowed to make reservations.
- Administer booking bundles and their fields at `/admin/bat/config/booking-bundles`.
- List and manage bookings at `/admin/bat/config/booking`.
- Scope booking visibility/edit to owners with the BAT per-bundle own/any permissions.
- Load bookings by id or by conditions (`bat_booking_load`, `bat_booking_load_multiple`).
- Create/save/delete bookings programmatically (`bat_booking_create`, `_delete`).
- Manage booking bundles in code (`bat_booking_type_create/save/delete`, `bat_booking_get_bundles`).
- Add a front-end "Book this" action to a unit-type listing via the `bat_booking_example` submodule.
- Present a booking confirmation form before committing a reservation.
- Attach arbitrary customer/detail fields to bookings via the Field UI.
- Build a hotel/rental/appointment reservation object on top of BAT events.
- React to booking lifecycle with the dispatched delete event for integrations (email, CRM, etc.).
- Track a booking's publication status to distinguish tentative vs confirmed reservations.
