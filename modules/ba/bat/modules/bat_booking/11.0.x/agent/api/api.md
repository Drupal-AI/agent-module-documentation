# BAT Booking — API

Functions in `bat_booking.module`; entity class `Drupal\bat_booking\Entity\Booking`.

## Bookings

- `bat_booking_load($booking_id, $reset = FALSE)`.
- `bat_booking_load_multiple(array $booking_ids = [], array $conditions = [], $reset = FALSE)`.
- `bat_booking_create($values = [])`, `bat_booking_delete(Booking $booking)`.
- `bat_booking_access($entity, $op, $account)` → delegates to base `bat_entity_access()`.

## Booking bundles

- `bat_booking_type_create($values)`, `bat_booking_type_load($bundle, $reset)`,
  `bat_booking_type_save(BookingBundle $t)`, `bat_booking_type_delete(BookingBundle $b)`,
  `bat_booking_get_bundles($name, $reset)`.
- `bat_booking_type_access($op, $unit, $account)` → checks `administer bat_booking_bundle entities`.

## Field attachment helpers

`bat_booking_add_start_date_field($bundle)`, `bat_booking_add_end_date_field($bundle)`,
`bat_booking_add_event_reference_field($bundle)` — attach the standard booking fields to a bundle.

## Lifecycle event

Subscribe to `Drupal\bat_booking\Event\DeleteBatBooking` (name `bat_booking_delete_booking`) to react
when a booking is deleted:

```php
public static function getSubscribedEvents(): array {
  return [\Drupal\bat_booking\Event\DeleteBatBooking::EVENT_NAME => 'onBookingDelete'];
}
public function onBookingDelete(\Drupal\bat_booking\Event\DeleteBatBooking $event): void {
  $booking = $event->booking; // release availability, notify, etc.
}
```

`bat_booking_entity_insert()` handles wiring related events when a booking is first saved.
