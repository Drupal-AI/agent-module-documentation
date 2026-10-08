<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# City Timezones — endpoints & controller

`src/Controller/CityTimezonesController.php` (`final`, extends `ControllerBase`). Constructor-injected
services: `extension.path.resolver` (`ExtensionPathResolver`) and `request_stack` (`RequestStack`).
Both public methods return a `Symfony\...\JsonResponse`. Defined in `city_timezones.routing.yml`.

## `all()` — `GET /system/city-timezones/all` (`city_timezones.all`)

- Reads `include_countries` from `city_timezones.settings` (defaults `[]`).
- Delegates to `getCitiesFilterByCountries($countries)`; returns the resulting array as JSON.
- Filtering logic:
  - Loads the whole TSV via `getCitiesFile()`, `explode(PHP_EOL, …)` into lines, `preg_split("/\t/")`
    each line into a field array.
  - Reads min population: `size` from config; if `size === 'other'`, uses `size_custom`.
  - Skips a row when `city[14]` (population) `< $citiesMinPop`.
  - Keeps a row when no countries are selected, or `city[8]` (ISO country code) is in the selected
    list.
- Consumed by the JS: `city[0]`=geonameid (option value), `city[1]`=name, `city[10]`=admin1 code,
  `city[8]`=country code (option label).

## `lookup()` — `POST /system/city-timezones/lookup` (`city_timezones.lookup`)

- Reads the raw request body via `requestStack->getCurrentRequest()->getContent()`, `json_decode`s
  it, takes `$contentJson['id'] ?? ''`.
- `getCitiesFilterById($id)` scans every TSV row and returns the first whose `city[0] == $id`
  (loose compare), else `[]`.
- If found, returns `city[17]` (the IANA timezone string) as JSON; otherwise returns `FALSE`.
- No CSRF token is required, but the method only reads data and returns a public reference value —
  it changes no state.

## `getCitiesFile()`

- Resolves the module path with `extensionPathResolver->getPath('module', 'city_timezones')`.
- `fopen` + `fread(…, filesize(...))` of `inc/cities500.txt` (the entire file), `fclose`; returns
  `''` on read failure. The file is a fixed bundled asset (GeoNames `cities500`, tab-separated,
  ~225k rows); the path is a fixed bundled asset, not request- or config-derived.

## Access

- Both data routes use `_permission: 'access content'` — a permission granted to the anonymous role
  by default, so these endpoints are effectively public. They expose only public GeoNames reference
  data (city list, timezone strings) and perform no writes.

## Operating notes

- The endpoints re-parse the full bundled dataset on every request; there is no result caching. A
  higher `size` (minimum population) and/or a `include_countries` filter reduces the number of rows
  returned to the client. See [../config/settings.md](../config/settings.md).
- Fields are addressed positionally by GeoNames column index; a change in the bundled file's column
  layout would shift `city[8]`/`city[14]`/`city[17]`.
