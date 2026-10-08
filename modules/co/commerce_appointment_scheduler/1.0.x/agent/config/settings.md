<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Global settings, config schema & auto-installed fields

## Install / enable

`drush en commerce_appointment_scheduler`. On install (`hook_install`) the module creates
shared field storages and installs field instances on **all existing** Commerce
`commerce_product_variation_type` and `commerce_order_item_type` bundles; it also hooks
`hook_commerce_product_variation_type_insert` / `hook_commerce_order_item_type_insert` so new
bundles get the fields too. Then edit a variation, turn on **Appointment enabled**, and the
storefront add-to-cart form gains the booking UI. Configure defaults at
`/admin/config/services/commerce-appointment-scheduler`.

## Settings form

`Form/CommerceAppointmentSchedulerSettingsForm` (route `commerce_appointment_scheduler.settings`,
perm `administer commerce appointment scheduler`, config `commerce_appointment_scheduler.settings`).
Config object (schema `config/schema/commerce_appointment_scheduler.schema.yml`, defaults in
`config/install/…settings.yml`):

| key | type | default | notes |
|-----|------|---------|-------|
| `default_timezone` | string | `America/New_York` | IANA tz; validated with `new \DateTimeZone()` on save |
| `default_schedule_json` | text | Mon–Sun `09:00`–`17:00` | JSON map weekday→`[[start,end],…]`; validated (valid days, HH:MM, end>start) |
| `default_blackout_dates` | text | `12-25` | one per line/comma; `YYYY-MM-DD` (specific) or `MM-DD` (recurring annual) |
| `default_duration_minutes` | int | `60` | min 1 |
| `default_capacity` | int | `1` | min 1 |
| `default_lead_time_minutes` | int | `120` | min 0 |
| `default_booking_window_days` | int | `30` | min 1 |
| `default_buffer_minutes` | int | `0` | min 0 |
| `sms_notifications_enabled` | bool | `false` | see [notifications/sms.md](../notifications/sms.md) |
| `sms_store_number` | string | `''` | destination number |
| `sms_twilio_account_sid` | string | `''` | Twilio SID (plain textfield) |
| `sms_twilio_auth_token` | string | `''` | Twilio token (plain textfield) |
| `sms_twilio_from_number` | string | `''` | Twilio sender |

`validateForm()` rejects invalid timezone, non-array/invalid schedule JSON (unsupported weekday key,
missing/short window, bad HH:MM, `start >= end`), and malformed blackout dates. When SMS is enabled
it requires all four SMS fields and sanity-checks the two phone numbers (10–15 digits). These are the
sitewide **defaults**; any variation field left empty inherits them (`getVariationInteger`,
`getSchedule`, `getBlackoutDates`, `getTimezone` in the slot manager).

## Auto-installed variation fields (`commerce_product_variation`)

Created by `commerce_appointment_scheduler_add_variation_fields()`; each also gets a default
form-display widget (weights 89–99) and, for the image, a view-display formatter.

| field | type | purpose |
|-------|------|---------|
| `field_appointment_enabled` | boolean | master on/off for the variation (default 0) |
| `field_appointment_image` | image (public) | optional storefront image shown above the booking controls |
| `field_appointment_duration` | int (unsigned) | slot length minutes (falls back to default) |
| `field_appointment_capacity` | int (unsigned) | bookings allowed per slot |
| `field_appointment_lead_time` | int (unsigned) | minimum notice minutes |
| `field_appointment_window_days` | int (unsigned) | days ahead bookable |
| `field_appointment_buffer` | int (unsigned) | gap after each slot (default 0) |
| `field_appointment_timezone` | string(64) | IANA tz for this variation |
| `field_appointment_location` | string(255) | room/address/meeting URL |
| `field_appointment_schedule` | string_long | weekly schedule JSON (blank = inherit default) |
| `field_appointment_blackout_dates` | string_long | blackout dates (blank = inherit default) |

## Auto-installed order-item fields (`commerce_order_item`)

Created by `commerce_appointment_scheduler_add_order_item_fields()`; written by the slot manager
when the item is added to cart. These persist the booking on the order.

| field | type | purpose |
|-------|------|---------|
| `field_appointment_start` | datetime | UTC start (Drupal storage format) |
| `field_appointment_end` | datetime | UTC end |
| `field_appointment_timezone` | string(64) | display tz at selection time |
| `field_appointment_location` | string(255) | copied from the variation |
| `field_appointment_notes` | string_long | customer-entered notes |

`hook_commerce_cart_order_item_comparison_fields_alter` adds the five order-item fields to the cart
comparison set so two bookings of the same variation stay as **separate cart lines** instead of
merging quantities.

## Field bootstrapping helpers (`.install` + `.module`)

- `commerce_appointment_scheduler_ensure_field_storage()` / `_ensure_field()` — idempotent create
  (returns early if `FieldStorageConfig`/`FieldConfig` already exists); pull default storage/field
  settings from the field-type plugin class.
- `commerce_appointment_scheduler_ensure_form_display()` / `_ensure_view_display()` — create-or-update
  the `default` displays and set the given components.
- Updates: `update_11001`/`11002` extend the 5-day default schedule to 7 days (only if still the old
  default) and seed blackout + SMS keys; `11002` also rewrites still-default variation schedules;
  `update_11003`/`11004`/`11005` add and repair the `field_appointment_image` storage/instance/tables.
