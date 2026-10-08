<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WissKI GeoNames Adapter (wisski_adapter_geonames) — agent index

Submodule of **wisski**. Queries **GeoNames.org** for place data.
Version **8.x-4.3**. Core `>=10.4 <12`.

Place is the field free text damages most — "Cambridge" is several cities, historical names change,
boundaries move. Free-text findspots cannot be mapped, filtered by region, or joined.

**Two decisions a research project should make explicitly:**

1. **Gazetteer coordinates are approximate and modern** — fine for an origin, wrong for an
   archaeological findspot recorded to the metre.
2. **For sensitive material, precise location is what must not be published** — portable
   antiquities findspots, nesting sites, sacred places. Making location machine-readable makes the
   disclosure decision more urgent, not less.