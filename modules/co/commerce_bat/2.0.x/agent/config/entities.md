<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config entities, capacity chain & settings

All admin pages live under `/admin/commerce/config/commerce-bat` (route
`commerce_bat.settings_overview`, `_permission: administer commerce`).

## Config entity types (src/Entity/)

- **`commerce_bat_booking_type`** (`BatBookingType`) — the per-variation policy.
  Holds the **temporal strategy** (`date_range` | `timeslot`), and default
  Availability Profile id, Capacity Preset id, BAT event type / unit bundle /
  unit type / booking-state / blockout-state, and a customer presentation preset.
  Collection `/admin/commerce/config/commerce-bat/booking-types`. Assigned to a
  variation via `field_cbat_booking_type`. This is what makes a variation
  bookable and picks rental vs lesson.
- **`commerce_bat_avail_profile`** (`BatAvailabilityProfile`) — opening hours,
  weekly rules, date overrides, allowed timeslots, slot length/granularity, and
  recurring/blocked ranges. Methods `isRangeBlocked()`, `isTimeslotBlocked()`,
  `getWeeklyRules()`, `getAllowedTimes()`, `getDateOverrides()`,
  `getSlotLength()`. Applied as a constraint layer ON TOP of BAT availability
  (`AvailabilityManager::isBlockedBySchedule`). Ships `default` + `closed`
  profiles (config/install). Attached via `field_cbat_schedule` or the Booking
  Type default.
- **`commerce_bat_capacity_preset`** (`BatCapacityPreset`) — reusable capacity
  config: `seats_per_qty`, `capacity_mode` (`shared`|`separate`),
  `capacity_group` (shared-pool key), `capacity_default`, per-group overrides,
  pool unit label template. Ships `default_lesson_capacity` +
  `default_rental_capacity`. Attached via `field_cbat_capacity_preset` or the
  Booking Type default.

`CommerceBatAudit` is a **content** entity (table `commerce_bat_audit`) — see
[../booking/lifecycle.md](../booking/lifecycle.md).

## Capacity resolution chain (CapacityResolver)

Effective capacity for a variation resolves through an ordered chain (first
match wins), surfaced on the variation form ("Effective capacity" readout) and
by `drush bat-health --detailed`:

```
variation capacity field → product capacity field
  → Capacity Preset group override → Capacity Preset default → built-in minimum (1)
```

There is **no site-wide default capacity fallback** in 2.0. Shared pools: two
variations sharing the same `capacity_group` (and same resolved BAT unit) draw
down one pool; verify via Unit Mappings + `drush bat-health`.

## Settings forms & config

- `commerce_bat.settings` (config/install + schema/commerce_bat.schema.yml) —
  read through the typed **`commerce_bat.settings`** service (`BatSettings`), not
  raw config, for calendar defaults, rental boundary mode, pricing mode,
  max-advance-days, admin order-visibility states, BAT mappings, etc.
- Forms (`_form`, `administer commerce`): `DisplaySettingsForm`
  (`/display` — shared calendar labels/colors/selection behavior),
  `AdvancedSettingsForm` (`/advanced` — admin order-visibility, diagnostics),
  `CalendarPluginConfigForm` (`/plugins/{plugin_id}`), `BlockoutForm`
  (`/blockout`), `BulkOrderSyncForm` (`/order-sync`, `administer commerce bat
  bulk sync`), plus the entity add/edit/delete forms.
- **Rental boundary mode** (`DateTimeHelper::BOUNDARY_EXCLUSIVE_END` vs
  `BOUNDARY_LEGACY_INCLUSIVE`) controls whether the end date is inclusive; the
  same rule is applied consistently across widget, validation, day-count, and
  BAT event creation.

## 2.0 migration

`hook_update_10013` builds canonical Booking Types/profiles/presets from legacy
1.x settings, assigns bookable variations, copies order-item intervals,
normalizes inclusive→exclusive end, then removes old settings only after
readiness checks; `commerce-bat:legacy-migrate --dry-run` and
`/admin/commerce/config/commerce-bat/migration` (`LegacyMigrationController`)
preview it. `LegacySettingsMigration` snapshots source config into
`commerce_bat.legacy_settings`.
