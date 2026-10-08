<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A code-only API that, given a source zip code and a list of candidate zip codes, returns them ordered by great-circle distance with kilometres/miles and coordinates for each.

---
It is purely programmatic — there is no UI, route, permission or service. `\Drupal\closest_zip_code\ClosestZipCode\App::instance()->closestZipCode($myZip, $allZips)` resolves each zip to a latitude/longitude by reading a **bundled local CSV** (`data/zipcodes.csv`) into memory (`DataStore`), then computes distances with the Vincenty great-circle formula (`Location`). Zips are validated as numeric and bounded (500–99999) and looked up with a small ±50 "fuzziness" offset when an exact match is missing; unresolved zips are collected into an `errors` array rather than thrown. Callers invoke it from custom code or Drush (`drush ev '...closestZipCode("00720", ["00723","00725"])'`).

There is no network access at all — all coordinate data is local, so there is no external geocoding call and no request-supplied URL is ever fetched. The dataset covers the zip ranges in the shipped CSV (US and territories), so it is unsuitable for non-US postal codes. Integrate it behind your own access-controlled code or endpoint if you need to expose lookups to users.
---
- Find the nearest store/branch zip to a customer's zip.
- Rank a list of locations by distance from a zip.
- Get kilometres and miles between two US zip codes.
- Resolve a zip code to latitude/longitude locally.
- Sort candidate zips by proximity for routing.
- Power a "locations near you" feature from custom code.
- Compute distances without an external geocoding API.
- Run a quick lookup via `drush ev`.
- Batch-rank many zips against one origin.
- Build a store-locator backend in PHP.
- Add nearest-zip logic to a custom controller you secure yourself.
- Handle missing zips gracefully via the returned errors array.
- Use fuzziness to tolerate zips absent from the dataset.
- Feed distances into shipping or eligibility rules.
- Avoid per-request API costs by using the local CSV.
- Validate that inputs are numeric zip codes in range.
- Integrate proximity data into a migration or import.
- Precompute nearest-neighbour tables offline.