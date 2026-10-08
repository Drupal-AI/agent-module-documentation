<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BEE Hotel SPS (beehotel_sps) — agent index

> **Deprecated** (`info.yml: lifecycle: deprecated`,
> issue 3605808). Use the **GlobalSlider** alterator in `beehotel_pricealterators` instead.

Store-wide percentage **price slider** for a Bee Hotel Commerce store. Dependencies:
`range_slider`, `bee_hotel`. Core `^9.4 || ^10 || ^11`.

## Surface

- **Service** `beehotel_sps.apply_price_slider` (`ApplyPriceSlider`): `apply($amount, $store)`
  reads the store's `field_price_slider` value and returns
  `new Price($amount + $amount/100 * $slider, $currency)` — an admin-set, server-side percentage.
- **Hook** `beehotel_sps_form_alter()`: on `/store/*/edit` attaches library
  `beehotel_sps/beehotel-sps-slicer` (the slider UI).

Setup (per README): enable the module + `range_slider`, add an integer field
**`field_price_slider`** to the store, set the value on the store config page. No routes,
permissions or config schema of its own. Deprecated — no solution subpages.
