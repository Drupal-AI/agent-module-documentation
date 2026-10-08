<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The concrete Price Alterators

All are `@PriceAlterator` plugins in `src/Plugin/PriceAlterator/` with a settings form in
`src/Form/` and a route `beehotel_pricealterator.pricealterator.<name>_settings`
(`/admin/beehotel/pricealterator/alterators/<name>`, permission **`administer bee_hotel`**).
They join the chain run by `beehotel_pricealterator`'s `Alter` service and are filtered by
annotation `status` + per-alterator UI enable flag.

| Plugin / id | Route slug | Effect |
|---|---|---|
| `Occupants` | `occupants` | Per-night surcharge/discount by guest count (annotation `type=optional`, `weight=2`). |
| `ConsecutiveNights` | `consecutivenights` | Adjust price by length of stay (longer = cheaper etc.). |
| `GlobalSlider` | `globalslider` | Store-wide percentage applied to every price (uses `range_slider`). |
| `SpecialNights` | `specialnights` | Premium/discount for specific dates, driven by `special_night` nodes (`field_nights`, `field_alteration`, `field_polarity`, `field_type`). |
| `DaysBeforeCheckin` | `daysbeforecheckin` | Lead-time pricing based on how far ahead the booking is. |
| `CheckinTime` | `checkintime` | Defines paid check-in time slots; the booking form adds a one-time "Late check-in fee" `Adjustment` and stores the slot in `field_checkin_time`. Config object `beehotel_pricealterator.pricealterator.CheckinTime.settings` (`enabled`, `time_slots[]` with `start`/`end`/`label`/`adjustment`, `display_label`, `options_pattern`). |
| `OneNightOnly` | `onenightonly` | Rule for single-night stays. |
| `SaturdayNightOnly` | `saturdaynightonly` | Only-sleeps-on-Saturday-night rule. |
| `SundayCheckin` | `sundaycheckin` | Sunday check-in rule. |

Each plugin implements `alter(array $data, array $pricetable): array`, reads its own config, and
mutates `$data['tmp']['price']`. Add your own by dropping a new `@PriceAlterator` class in any
module's `src/Plugin/PriceAlterator/` (see beehotel_pricealterator's `plugins/alterator-api.md`).
