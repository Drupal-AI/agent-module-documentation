<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce BAT (commerce_bat) — agent index

Adds a **bookable-inventory layer to Drupal Commerce** by wiring it to **BAT
(Booking & Availability Tools)**. Sell either **rentals** (date ranges, e.g.
rooms/equipment) or **lessons** (timeslots, e.g. appointments) as ordinary
Commerce product variations, with a live **availability calendar on the
add-to-cart form**, **capacity presets** (separate or shared pools),
**availability profiles** (opening hours, closures, recurring rules), and an
**admin blockout calendar**. Info name is *"Commerce BAT Availability"*. Package
**Commerce**. Core `^10 || ^11`. GPL-2.0-or-later. Installed version **2.0.0**
(version dir `2.0.x`). No submodules.

## Dependencies (from .info.yml)

`commerce`, `commerce_cart`, `commerce_order`, `bat`, `bat_unit`, `bat_event`.
The install hook also provisions BAT unit/event bundles+states and the order-item
/ variation fields it needs. Calendar UX uses **FullCalendar** and **Flatpickr**
(bundled/CDN JS libraries).

## The 2.0 booking model

```
Product variation → Booking Type → temporal strategy (date_range|timeslot)
                                  → Availability Profile + Capacity Preset → BAT events
```

- A variation's behavior comes from its **Booking Type** entity
  (`field_cbat_booking_type`), NOT from the product name. Temporal strategy
  `date_range` ⇒ internal mode **`rental`**; `timeslot` ⇒ internal mode
  **`lesson`** (`AvailabilityManager::getModeForVariation`). A variation with no
  Booking Type is not bookable (mode `NULL`).
- The canonical booking interval is stored on the order item in
  **`field_cbat_rental_date`** (used by BOTH modes); the derived rental duration
  in **`field_cbat_num_days`**.

## What it provides (from source)

- **3 config entity types**: `commerce_bat_booking_type`,
  `commerce_bat_avail_profile`, `commerce_bat_capacity_preset` (admin under
  `/admin/commerce/config/commerce-bat/...`). Plus a `CommerceBatAudit` content
  entity backed by the `commerce_bat_audit` table, and a
  `commerce_bat_variation_unit` mapping table (`hook_schema`).
- **Calendar plugin type** (`@CalendarPlugin` annotation,
  `plugin.manager.commerce_bat_calendar`): `fullcalendar`, `mini_fullcalendar`,
  `flatpickr` (`src/Plugin/Calendar/`).
- **Field widget** `bat_date` (`BatDateWidget`) for the add-to-cart form;
  presentation-only display modes (two dates / embedded / popup).
- **JSON endpoints** for availability/pricing preview and admin blockouts (see
  [api/availability-endpoints.md](api/availability-endpoints.md)).
- **Order integration**: `RentalDayPriceProcessor` order processor,
  `OrderPlaceSubscriber` / `OrderCancelSubscriber` / `CartComparisonSubscriber` /
  `BatEventTypeSubscriber`, and the `CommerceBatAvailability` entity constraint.
- **Permissions**: `manage bat blockouts`, `view bat availability`,
  `administer commerce bat audit log`, `administer commerce bat bulk sync`
  (note: most admin *routes* are gated by core `administer commerce`, not these).
- **Drush** (`commerce_bat.drush.services.yml`, `CommerceBatCommands`):
  `bat-health` (`--detailed`/`--fix`), `bat-bulk-sync`, `commerce-bat:legacy-migrate`.
- Config schema, an `commerce_adjustment_types` file (`rental_days` adjustment),
  a `views.view.commerce_bat_audit`, install/update hooks (2.0 migration in
  `update_10013`).

## Solution docs

- **Booking Types, Availability Profiles, Capacity Presets, capacity chain,
  settings forms, config** → [config/entities.md](config/entities.md)
- **Availability/pricing JSON routes, blockout AJAX, controllers, server-side
  price & availability authority** → [api/availability-endpoints.md](api/availability-endpoints.md)
- **Add-to-cart widget, order processor, subscribers, BAT event lifecycle,
  audit log, drush** → [booking/lifecycle.md](booking/lifecycle.md)

## Operational notes

- Admin UI lives under **`/admin/commerce/config/commerce-bat`** (settings
  overview). All entity/blockout/mapping pages are under that path.
- Availability and pricing are computed from BAT events + the variation's own
  price/capacity, and are re-validated **server-side at add-to-cart, on the
  cart/draft constraint, and again at order placement** (transactional
  reservation) — keep that authority intact when extending.
- Maintainer warns: do NOT run `1.5.0` or any `2.0.0`–`2.2.0-alpha2` release
  (a `Transaction::commitOrRelease()` call breaks checkout on Drupal 10).
