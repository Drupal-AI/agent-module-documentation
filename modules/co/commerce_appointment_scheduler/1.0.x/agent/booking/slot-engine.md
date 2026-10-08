<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Slot engine, add-to-cart flow & admin report

## Add-to-cart integration (`.module`)

`commerce_appointment_scheduler_form_alter()` fires on any form whose form object is a
`commerce_cart\Form\AddToCartForm`. It gets the order item → purchased `ProductVariation`, and bails
unless `AppointmentSlotManager::variationSupportsAppointments()` (i.e. `field_appointment_enabled` is
true). When enabled it adds a `details` element `form['appointment']`:

- optional `appointment_image` (rendered from `field_appointment_image`, image_style `large`),
- optional `appointment_location` item (from `field_appointment_location`, `#plain_text`),
- if **no slots** → an "unavailable" message and every submit button in `form['actions']` is disabled,
  then returns,
- `appointment_calendar` container carrying the `commerce_appointment_scheduler/calendar` library and
  a per-instance `drupalSettings.commerceAppointmentScheduler[instanceId]` payload
  (`timezone`, `defaultSlot`, `slotsByDate`),
- `appointment_slot` **required select** (`#options` = `buildSlotOptions`) — the real input and the
  no-JS fallback,
- `appointment_notes` textarea (labelled "Appointment Address"; writes `field_appointment_notes`),
- appends `commerce_appointment_scheduler_add_to_cart_validate` to `#validate`.

`commerce_appointment_scheduler_add_to_cart_validate()` requires a non-empty `appointment_slot`, then
`resolveSelectedSlot($variation, $submitted_value)` **re-builds the slot list server-side** and looks
the submitted value up in it — a stale/invalid/now-full slot returns NULL and raises a form error
("no longer available"). On success `applySlotSelection()` writes start/end (UTC), timezone, location,
and trimmed notes onto the order item. So the client-submitted slot string is never trusted directly;
it must match a freshly recomputed available slot.

## AppointmentSlotManager (`commerce_appointment_scheduler.slot_manager`)

Args: `@config.factory`, `@datetime.time`, `@entity_type.manager`.

`buildSlots(variation, ?reference)` is the core generator:
1. Resolve tz (`getTimezone` → variation field else config default, `normalizeTimezone` falls back to
   UTC on an invalid id).
2. Read duration/capacity/lead_time/window_days/buffer via `getVariationInteger` (variation field →
   config key → hardcoded fallback), clamped with `max()`.
3. `getSchedule()` — variation JSON else `default_schedule_json`; `json_decode`; keep only valid
   weekday keys and `[HH:MM, HH:MM]` windows with `start < end`.
4. `getBlackoutDates()` — split on `[\r\n,]+`; classify `YYYY-MM-DD` (specific) vs `MM-DD` (recurring).
5. `first_allowed_start = now + lead_time`; window = today 00:00 → `+window_days`.
6. `buildBookedCounts()` (see below) pre-counts taken capacity per UTC start.
7. `step = max(15, duration + buffer)`. For each day in the window not blacked out, for each schedule
   window, walk `slot_start += step` while `slot_start + duration <= close`; emit a slot when
   `slot_start >= first_allowed_start` and `booked < capacity`. Slots are keyed by local
   `Y-m-d\TH:i`; each carries `label`, `start`, `end`, `timezone`; capacity>1 labels show "N of M spots left".

`buildSlotOptions()` = value→label map for the select. `buildCalendarData()` = same slots grouped by
local `Y-m-d` for the JS calendar (adds `time_label`, `meta_label`, `duration_minutes`).
`resolveSelectedSlot()` = `buildSlots()[value] ?? NULL`. `applySlotSelection()` writes the order-item
fields (start/end converted to UTC via `toStorageValue`).

`buildBookedCounts(variation, window_start, window_end)`: entityQuery on `commerce_order_item`
(`accessCheck(FALSE)`) filtered to that `purchased_entity` and start within the window; for each item
whose order state **counts toward capacity** it adds `max(1, quantity)` to that UTC start's count.
`countsTowardsCapacity($state)` = state NOT in `['draft','canceled','cancelled']`. Capacity is
evaluated at add-to-cart validation time against these counted orders.

Time helpers: `toStorageValue` (local→UTC storage string), `storageToLocal` (UTC storage→display tz),
`isValidTime` (`HH:MM` 24h regex), `splitTime`, `currentTime`.

## JS calendar (`js/commerce_appointment_scheduler.calendar.js`)

`Drupal.behaviors.commerceAppointmentSchedulerCalendar` reads
`drupalSettings.commerceAppointmentScheduler[instanceId].slotsByDate` and builds a month calendar +
time-slot list, wiring clicks back to the hidden `select[name=appointment_slot]` via
`select.value = …; dispatchEvent(new Event('change'))`. It renders **only** dates/times the server
provided; it computes nothing about availability itself. `once()`-guarded; degrades to the plain
select when JS is off (library deps: `core/drupal`, `core/once`, `core/drupalSettings`). All strings
are `Drupal.t()` and DOM is built with `textContent` (no innerHTML injection of slot data).

## Admin report (`AppointmentAdminController::overview`)

Route `commerce_appointment_scheduler.overview` (`/admin/reports/commerce-appointments`,
perm `view commerce appointment bookings`). Calls `AppointmentSlotManager::buildUpcomingBookings(50)`:
entityQuery for order items with `field_appointment_start >= now(UTC)`, sorted ascending, limit 50;
skips items whose order state doesn't count toward capacity; builds rows of product, order, customer
(order email else label else "Guest"), slot (localized to the stored/variation tz), state, location,
notes. Rendered as a `#type => table` (cells are plain strings → Twig-autoescaped).
