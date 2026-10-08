<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# City Timezones — settings, config & form integration

## Install / enable

`drush en city_timezones` (or the UI). Requires core `datetime` + `user` and the contrib
**Chosen** module (`drupal/chosen:^5.0`) — install via `composer require drupal/chosen`. Core
`^10 || ^11`. No custom permissions are added.

## Settings form

`src/Form/SettingsForm.php` (`final`, extends `ConfigFormBase`, form id `city_timezones_settings`),
at `/admin/config/regional/city-timezones` (route `city_timezones.settings`, permission
`administer site configuration`; menu link `city_timezones.links.menu.yml` under
*Configuration → Regional*). Injects `config.factory` and `country_manager`.

Fields (`buildForm`):
- **`size`** — radios of `$citySizeOptions`: `1000000`, `100000`, `15000`, `5000`, `1000`, `500`,
  `other` (label *Custom*). Default `15000`. Minimum population for a city to appear.
- **`size_custom`** — number (min 0), visible only when `size === other` (`#states`). Custom
  threshold.
- **`include_countries`** — multi-select of `countryManager->getList()`; empty = all countries.
- **`chosen`** — checkbox (return value `1`), default `0`. Toggles the Chosen JS enhancement on the
  city selector.

`validateForm` rejects a `size` value outside `array_keys($citySizeOptions)` and requires
`include_countries` to be an array. `submitForm` writes `size`, `size_custom`, `include_countries`,
`chosen` to `city_timezones.settings`.

## Config object `city_timezones.settings`

- Schema — `config/schema/city_timezones.schema.yml`: `size` (string), `custom_size` (string),
  `include_countries` (mapping of `id`/`country`), `chosen` (boolean).
- Install defaults — `config/install/city_timezones.settings.yml`: `size: '15000'`,
  `custom_size: '0'`, `include_countries: {}`, `chosen: 1`.

**Naming caveat (grounded in source):** the form and controller read/write the custom threshold as
**`size_custom`**, while the schema and install file define **`custom_size`**. As a result the
install-provided `custom_size: '0'` is never read, and the value the form saves (`size_custom`) has
no schema entry — expect a config-schema notice when validating config, and the custom population
only takes effect after the settings form is saved. Functional behavior of the preset sizes is
unaffected.

## Form integration (`hook_form_alter`)

`city_timezones_form_alter()` acts only when the form object is a `Drupal\user\AccountForm` and
`$form['timezone']['timezone']` exists (core adds the timezone element in its own form_alter, hence
this runs as a later alter). It adds `$form['timezone']['timezone_city']` (a `select` with a single
placeholder option, `#name` `timezone_city`, `#weight` `-1`, `#chosen` = the `chosen` config value)
and attaches library `city_timezones/city-timezones`. The JS then populates options and drives the
lookup; see [../api/endpoints.md](../api/endpoints.md).

## Operating notes

- To keep the client-side list small and responsive, raise `size` (e.g. `100000`) and/or select
  specific `include_countries`; the `all` endpoint applies both filters server-side.
- Turning `chosen` off falls back to the browser's native (unfiltered) `<select>`.
