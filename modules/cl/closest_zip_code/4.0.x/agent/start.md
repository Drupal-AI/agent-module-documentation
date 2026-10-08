<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Closest Zip Code (closest_zip_code) — agent index

**Code/Drush-only API returning the nearest zip code(s) from a list, using a bundled local CSV of lat/lon and the Vincenty great-circle formula. No UI, routes, permissions or services.**

- **Version:** 4.0.x
- **Core:** ^10 || ^11 · **PHP:** 8
- **Entry point:** `\Drupal\closest_zip_code\ClosestZipCode\App::instance()->closestZipCode(string $myZip, array $allZips): array` → `{errors, zip, lat, lon, zips[…]=>{km,miles,lat,lon}, duration-seconds}`.
- **Internals:** `DataStore` preloads `data/zipcodes.csv` (validates numeric zips in 500–99999, ±50 fuzziness); `Location` computes distances; Singleton + CommonUtilities traits.
- **Security:** no routes and no external network calls — coordinates come only from the bundled local CSV, so there is **no SSRF / no request-supplied URL fetch** and **no anonymously exposed endpoint**. The module ships no access surface; any site exposing it to users must add its own access-controlled wrapper.

See [api/usage.md](api/usage.md)
