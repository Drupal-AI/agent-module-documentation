<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bee Hotel Utils (beehotel_utils) — agent index

Dependency-free **utility layer** for the Bee Hotel suite. No routes, permissions, schema or
plugins — just four injectable services in `src/`. Core `^10.2 || ^11`. Declares it will *never*
depend on another bee_hotel module.

## Services (`beehotel_utils.services.yml`)

- `beehotel_utils.dates` → `Dates` — search-form date normalisation
  (`normaliseDatesFromSearchForm`), `easter()`, `dayArray()`, day-before/after helpers.
- `beehotel_utils.beehotel` → `BeeHotel` — `getCurrencyCode()`, product/attribute helpers
  (deps: attribute field manager, beehotelunit, config, ETM, messenger, request stack).
- `beehotel_utils.beehotelunit` → `BeeHotelUnit` — `isThisNodeBeeHotel()`, `maxOccupancy()`,
  `getAvailableUnits()`, `getBidFromNode()`, `getVariationNode()`.
- `beehotel_utils.beehotelcommerce` → `BeeHotelCommerce` — `currentStoreCurrency()` and store
  helpers.

Consumed by `bee_hotel` (booking form, price resolver), `beehotel_pricealterator`,
`beehotel_vertical`, `beehotel_happening_today`. No solution subpages — the services above are the
whole surface.
