# BAT Booking — agent index

Adds the `bat_booking` content entity: a reservation tying a customer + date range to the BAT
availability events it creates. Fieldable booking bundles; helper fields for start/end dates and an
event reference. Depends on `bat_event`. No `configure` route; pages under `/admin/bat/config/booking`.

- **Entity, bundles, auto-attached fields, routes, lifecycle event** → [configure/booking.md](configure/booking.md)
- **Procedural API + the DeleteBatBooking dispatch** → [api/api.md](api/api.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- `bat_booking`: base table `booking`, bundle entity `bat_booking_bundle`. Base fields: `id`, `uuid`,
  `uid`, `label`, `created`, `changed`, `type`, `status`.
- Per-bundle fields attached in code: start date, end date, event reference
  (`bat_booking_add_start_date_field` / `_end_date_field` / `_event_reference_field`).
- Deleting a booking dispatches `DeleteBatBooking` (event name `bat_booking_delete_booking`).
- Permissions: `book units`, `administer bat_booking_bundle entities`, plus the generated BAT scheme.
- `bat_booking_example` submodule shows a front-end "book this" Views field + confirmation form.
