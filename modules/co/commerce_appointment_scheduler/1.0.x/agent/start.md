<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Appointment Scheduler (commerce_appointment_scheduler) — agent index

Adds **slot-based appointment booking** to Drupal Commerce. When a product variation is
flagged appointment-enabled, `hook_form_alter` injects a date/time picker into the
Commerce **AddToCartForm**; the chosen slot is validated server-side and written onto the
`commerce_order_item`. Package `Commerce`. Core `^11`. License GPL-2.0-or-later. Installed
**1.0.0** (version dir `1.0.x`). No stable release is under Drupal security-advisory coverage.

There is **no dedicated booking entity and no slot-availability AJAX/REST route** — slots are
computed in PHP and passed to the browser via `drupalSettings`; the JS calendar only drives the
underlying `<select>`.

## Dependencies

- Drupal modules (`.info.yml`): `commerce`, `commerce_cart`, `commerce_order`,
  `commerce_product`, core `datetime`, `field`, `image`. All required.
- No PHP libraries in `composer.json` beyond core/Commerce. Twilio SMS uses the core
  `http_client` (Guzzle) directly — no SDK.

## What it provides (from source)

- **Add-to-cart integration** (`.module` `hook_form_alter` + `_add_to_cart_validate`): builds a
  `details` "Book an appointment" element with an optional image, location, a required
  `appointment_slot` select, an `appointment_notes` textarea, and the `commerce_appointment_scheduler/calendar`
  library. Validate re-resolves the slot and writes it to the order item.
- **Service `commerce_appointment_scheduler.slot_manager`** (`AppointmentSlotManager`) — the slot
  engine: builds/validates slots from a weekly-schedule JSON, duration, buffer, lead time, booking
  window, capacity, blackout dates, and per-variation timezone; counts existing non-draft bookings;
  builds the admin report rows.
- **Service `commerce_appointment_scheduler.notification_manager`** (`AppointmentNotificationManager`)
  — optional **Twilio** store SMS on `hook_commerce_order_presave` for non-draft orders.
- **Settings form** route `commerce_appointment_scheduler.settings`
  (`/admin/config/services/commerce-appointment-scheduler`, perm `administer commerce appointment scheduler`)
  — global default booking policy + SMS credentials.
- **Admin report** route `commerce_appointment_scheduler.overview`
  (`/admin/reports/commerce-appointments`, perm `view commerce appointment bookings`) — upcoming bookings table.
- **Install/update hooks** (`.install`): auto-creates ~11 variation fields + 5 order-item fields
  (and form/view displays) on every Commerce variation-type and order-item-type bundle, on install
  and on bundle insert; `update_11001`–`11005` migrate schedules and repair the image field.
- **Permissions** (`.permissions.yml`): `administer commerce appointment scheduler`,
  `view commerce appointment bookings`. **Config schema** for the settings object. JS calendar +
  CSS (`js/`, `css/`). Menu links (`.links.menu.yml`).

## Solution docs

- **Global settings, config schema, the auto-installed variation/order-item fields, install/update hooks**
  → [config/settings.md](config/settings.md)
- **Slot engine, add-to-cart flow, capacity/blackout/timezone rules, JS calendar, order-item persistence,
  admin report** → [booking/slot-engine.md](booking/slot-engine.md)
- **Optional Twilio store SMS notifications** → [notifications/sms.md](notifications/sms.md)
