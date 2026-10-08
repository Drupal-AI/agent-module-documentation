# BAT Booking — entity, bundles, routes

## Entity

`bat_booking` — content entity, base table `booking`, bundle entity `bat_booking_bundle` (config,
schema `bat_booking.booking_bundle.*`: `name`, `type`). Keys: `id`, `uuid`, `label`, `uid` (owner),
`type` (bundle). Base fields: `id`, `uuid`, `uid` (→ user), `label` (string), `created`, `changed`,
`type` (→ `bat_booking_bundle`), `status` (boolean). `permission_granularity = bundle`; access via
base `bat_entity_access()`.

## Auto-attached bundle fields

Bookings carry no hardcoded date schema; instead the module attaches configurable fields per bundle:

- `bat_booking_add_start_date_field($bundle)` — check-in date field.
- `bat_booking_add_end_date_field($bundle)` — check-out date field.
- `bat_booking_add_event_reference_field($bundle)` — reference to the `bat_event`(s) the booking
  produced.

Add further customer/detail fields via Field UI on the bundle edit form
(`entity.bat_booking_bundle.edit_form`).

## Lifecycle

- `bat_booking_entity_insert()` wires a new booking to its related events on save.
- Deleting a booking dispatches `Drupal\bat_booking\Event\DeleteBatBooking`
  (`DeleteBatBooking::EVENT_NAME = 'bat_booking_delete_booking'`), exposing the `->booking` object so
  subscribers can release calendar availability or notify integrations.

## Routes (under `/admin/bat/config/booking`, `_admin_route`)

- Bookings: collection `/booking` (`view any bat_booking entity`), add `/booking/add[/{booking_bundle}]`
  (custom `_booking_add_access`, service `access_check.bat_booking.add`), canonical/edit/delete
  (`_entity_access`).
- Booking bundles: `/booking-bundles[...]` (`administer bat_booking_bundle entities`).
- Admin section `/admin/bat/booking` (`access administration pages`).

## Programmatic create

```bash
ddev drush php:eval '$b = \Drupal::entityTypeManager()->getStorage("bat_booking")->create(["type" => "standard", "label" => "Booking #1"]); $b->save();'
```
