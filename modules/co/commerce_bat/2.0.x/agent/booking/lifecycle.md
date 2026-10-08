<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Booking lifecycle: widget → pricing → placement → events → audit

## Add-to-cart widget (`bat_date` / `BatDateWidget`)

`src/Plugin/Field/FieldWidget/BatDateWidget.php`. Placed on the order-item
`add_to_cart` form display for `field_cbat_rental_date`. Branches on
`getModeForVariation()`:

- **rental** → date-range selection; on submit derives `field_cbat_num_days`
  from the chosen start/end via `DateTimeHelper::calculateRentalDays()`.
- **lesson** → timeslot selection constrained to the profile's allowed times /
  slot length.

Display mode (`two_dates` | `embedded` | `popup`) is presentation-only; behavior
comes from the Booking Type. The widget validates availability
(`AvailabilityManager::isAvailable`) before populating fields. Module hooks in
`commerce_bat.module` add the same behavior for the native Drupal daterange
widget and inject a live subtotal (`commerce_bat_inject_subtotal_after_build`),
day/qty data attributes, and an optional multi-step customer-details step
(stored as `commerce_bat_customer_details` on the order item).

## Pricing (server-side authority)

Three layers, all keyed off the *date range* / `field_cbat_num_days`, not any
client price:

1. **`RentalDayPriceProcessor`** — `commerce_order.order_processor` (priority
   200). For `num_days > 1`: pricing mode `base` sets unit price =
   base × days; otherwise adds a `rental_days` Adjustment for the extra days ×
   quantity.
2. **`commerce_bat_rental_validate()`** (add-to-cart/edit `#validate`) re-derives
   `days` from the actual start/end and re-applies pricing.
3. **`commerce_bat_entity_presave()`** recomputes `num_days` from the stored
   range on every order-item save and re-applies day pricing unless the unit
   price was explicitly admin-overridden (`isUnitPriceOverridden()`).

The `rental_days` adjustment type is declared in
`commerce_bat.commerce_adjustment_types.yml`.

## Placement, cancellation, edits (event subscribers)

- **`OrderPlaceSubscriber`** — on `commerce_order.place.pre_transition` it opens
  a DB transaction and **reserves** capacity by creating one blocking BAT event
  per rental day (or one per lesson slot); if any day is unavailable it rolls
  back and throws a customer-safe redirect back to checkout. The checkout submit
  wrapper (`commerce_bat_checkout_submit`) runs an early availability-only pass
  (`assertOrderAvailableForCheckout`) so the common conflict returns the normal
  checkout response. `createBlockingEvent` treats a unique-key
  `IntegrityConstraintViolationException` as "already blocked" (race-safe).
- **`OrderCancelSubscriber`** — removes the order's BAT events on cancellation,
  restoring availability.
- **`CartComparisonSubscriber`** — keeps cart items distinct/consistent for
  bookings. **`BatEventTypeSubscriber`** — BAT event type wiring.
- `OrderItemUpdateSubscriber` is **disabled** in services.yml (caused loops);
  order-item edits are handled by the form submit handler
  `commerce_bat_order_item_edit_submit` instead (removes old events, creates new,
  invalidates cache).
- The `CommerceBatAvailability` entity constraint
  (`BatAvailabilityConstraintValidator`) re-checks availability on draft/cart
  order items (skips once the add-to-cart form already messaged the customer).

## BAT events & unit mapping

Each variation maps to a BAT unit (created on demand); the mapping is cached in
the `commerce_bat_variation_unit` table (view/repair at
`/admin/commerce/config/commerce-bat/unit-mappings`). Blocking events carry
`order_id`/`order_item_id` metadata for reverse lookup, cancellation, and
reporting. Alter hooks: `hook_commerce_bat_booking_alter`,
`_availability_alter`, `_blocking_event_alter`, `_calendar_alter`.

## Audit log

`commerce_bat_audit_log()` writes to the `commerce_bat_audit` table (content
entity `CommerceBatAudit`, view `commerce_bat_audit`, page under Advanced → Audit
Log). Actions include `order_booking_created`, `order_cancelled`,
`blockout_created`, `order_item_updated`. Requires `administer commerce bat audit
log` (or `administer commerce`).

## Drush (`CommerceBatCommands`)

- `drush bat-health [--detailed] [--fix]` — validate mappings/units/pools/presets;
  `--fix` auto-repairs orphaned mappings/units.
- `drush bat-bulk-sync [--state=] [--limit=] [--dry-run]` — rebuild BAT events for
  existing orders (also via `BulkOrderSyncForm`).
- `drush commerce-bat:legacy-migrate [--dry-run]` — 1.x → 2.0 migration.
