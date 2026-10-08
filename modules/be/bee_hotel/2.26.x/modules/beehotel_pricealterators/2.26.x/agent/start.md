<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bee Hotel Price Alterators (beehotel_pricealterators) — agent index

A **collection of concrete PriceAlterator plugins** for the Bee Hotel pricing chain. Dependencies:
`bee_hotel`, `beehotel_pricealterator`, `range_slider`. Core `^9.4 || ^10 || ^11`.

## Plugins (`src/Plugin/PriceAlterator/`)

Occupants, ConsecutiveNights, GlobalSlider, SpecialNights, DaysBeforeCheckin, CheckinTime, OneNightOnly, SaturdayNightOnly, SundayCheckin — each is a `@PriceAlterator`-annotated class extending
`beehotel_pricealterator\PriceAlteratorBase` with a matching settings form in `src/Form/` and a
route under `/admin/beehotel/pricealterator/alterators/<name>` (perm `administer bee_hotel`).

## Installs (`.install`, `config/install/`)

- Content type **`special_night`** with fields `field_type`, `field_polarity`, `field_nights`,
  `field_alteration` (drives the SpecialNights alterator).
- Field **`field_checkin_time`** (string, len 5) on the `bee` `commerce_order_item` type
  (drives CheckinTime; also read by `bee_hotel`'s booking form for the late-check-in fee).

## Solution docs

- Each alterator, its config route and effect →
  [plugins/alterators.md](plugins/alterators.md)

The plugin type/manager and the base pricing chain are in **beehotel_pricealterator**.
