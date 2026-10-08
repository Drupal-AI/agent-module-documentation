<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# City Timezones (city_timezones) — agent index

**City-search timezone picker** for the user account form: pick a bundled GeoNames city, the IANA
timezone is set automatically. Package `User interface`. License GPL-2.0-or-later. Version 1.0.0
(version-dir 1.0.x). Core `^10 || ^11`.

**Dependencies:** core `datetime`, core `user`, contrib `chosen` (`drupal/chosen:^5.0`). No
permissions of its own, no Drush, no plugin types, no entities. Provides config schema.

## What it actually is (from source)

- **`hook_form_alter`** (`city_timezones.module`): when the form object is an `AccountForm` and a
  `timezone.timezone` element exists, it prepends a `timezone_city` `select` (weight `-1`) and
  attaches library `city_timezones/city-timezones`. The select's `#chosen` flag mirrors the
  `chosen` config value.
- **JS** `js/city-timezones.js` (`Drupal.behaviors.cityTimezones`, deps `core/drupal`,
  `core/once`): on attach, `fetch('/system/city-timezones/all')` and appends one `<option>` per
  city (`option.value = city[0]`, label `city[1] + ', ' + city[10] + ', ' + city[8]`); on
  `change`, POSTs `{id}` to `/system/city-timezones/lookup` and sets the core `edit-timezone`
  select to the returned zone; on submit, disables the helper select to avoid a validation error.
- **Data source:** bundled TSV `inc/cities500.txt` (GeoNames `cities500`) — no runtime external API.

## Routes / controller

- `city_timezones.all` → `/system/city-timezones/all` → `CityTimezonesController::all` — returns
  the country- + population-filtered city list as JSON.
- `city_timezones.lookup` → `/system/city-timezones/lookup` → `CityTimezonesController::lookup` —
  reads `id` from the JSON request body, returns that city's IANA zone (`city[17]`) or `FALSE`.
- Both endpoints: `_permission: 'access content'`.
- `city_timezones.settings` → `/admin/config/regional/city-timezones` → `SettingsForm`
  (`_permission: 'administer site configuration'`; menu link under *Configuration → Regional*).

## Config (`city_timezones.settings`)

`size` (population preset string), `size_custom` (custom threshold, used when `size === 'other'`),
`include_countries` (map of country codes; empty = all), `chosen` (bool). Schema in
`config/schema/city_timezones.schema.yml`; install defaults in `config/install/`.

## Solution docs

- **Controller, routes, endpoints, filtering logic** → [api/endpoints.md](api/endpoints.md)
- **Settings form, config keys, install/enable, form_alter** → [config/settings.md](config/settings.md)
