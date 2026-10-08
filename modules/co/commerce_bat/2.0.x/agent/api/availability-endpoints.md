<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Availability / pricing JSON routes & admin blockout AJAX

Routes in `commerce_bat.routing.yml`. `{commerce_product_variation}` is regex
`\d+`; `{date}` is `\d{4}-\d{2}-\d{2}`. Controllers under `src/Controller/`.

## Customer-facing (permission `access content`)

`AvailabilityController` (`src/Controller/AvailabilityController.php`):

- `GET /commerce-bat/availability/{variation}` → `::calendar` — per-date
  availability for a range (`from`/`to`/`interval` query args). Returns a map of
  date → `{status, remaining, capacity, start, end}`. The detailed breakdown
  (`booked`/`blocked`/`blockout_reasons`) is added ONLY when `breakdown=1` AND the
  current user has `administer commerce` — anonymous callers get aggregate counts
  only. Response caching is deliberately disabled (`max_age = 0`).
- `GET /commerce-bat/availability/{variation}/{date}` → `::getAvailableSlots` —
  a one-day slice (slot-length interval for lessons).
- `GET /commerce-bat/check/{variation}` → `::checkRange` — boolean
  `{available: bool}` for `start`/`end`/`quantity`. Server calls
  `AvailabilityManager::isAvailable()`.
- `GET /commerce-bat/subtotal/{variation}` → `::calculateSubtotal` — **price
  PREVIEW only**. Computes `unitPrice × days × quantity` from the variation's
  OWN configured price (never a client-supplied price) and returns
  `{subtotal, formatted, currency, days, quantity, unitPrice}`. This value is
  never written to an order; the authoritative price is recomputed server-side by
  the order processor / presave (see [../booking/lifecycle.md](../booking/lifecycle.md)).

The customer add-to-cart JS (`commerce_bat_*` in `js/`) calls these to render the
calendar and live subtotal; it never sends a price back to the server.

## Admin-only

- `GET /commerce-bat/orders/{variation}` → `::ordersForDate`
  (`administer commerce`) — orders overlapping a `date`, incl. customer
  email/name/total; used by the admin blockout calendar's order popup. Order
  query uses `accessCheck(TRUE)` and filters to the configured admin
  order-visibility states. Output is rendered escaped client-side
  (`escapeHtml(...)`).
- `POST /commerce-bat/blockout` → `BlockoutController::blockout`
  (route `administer commerce`; method also requires `manage bat blockouts`) —
  creates BAT blockout events from `variation`/`start`/`end`/`quantity`/`reason`.
- `POST /commerce-bat/blockout/delete` → `::deleteBlockouts` — deletes/reduces
  blockouts over a range.
- `GET /commerce-bat/variation/{variation}/info` → `::variationInfo` — calendar
  config (mode, slot length, allowed times, capacity, preset).
- `GET .../unit-mappings/{variation_id}/delete` → `UnitMappingController::deleteMapping`,
  `GET .../orders/{order}/commerce-bat/order-event-sync` →
  `OrderSyncController::sync`, `.../order-sync` → `BulkOrderSyncForm`,
  `.../reports/status` → `ReportController`, `.../plugins` →
  `PluginsOverviewController`, `.../legacy-backfill` → `LegacyOrderController`.

## AvailabilityManager (the authority)

`commerce_bat.availability_manager` (`src/Availability/AvailabilityManager.php`)
is the central service. Key methods: `isAvailable()`, `getCalendar()`,
`getRemainingAvailability()`, `createBlockingEvent()`, `getModeForVariation()`,
`getCapacity()`, `invalidateCalendarCache()`, `getLessonSlotLength()`,
`getLessonTimeslots()`. Availability = variation capacity − sum of overlapping
BAT event quantities in the blocking states, further constrained by the
Availability Profile (`isBlockedBySchedule`) and the max-advance booking window.
Event lookups use the entity query API (parameterized). Calendar results are
cached 5 min under tag `commerce_bat_calendar:{variation_id}` (though the JSON
controllers set `max_age=0`).
