<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form — smartweather

`Drupal\smartweather\Form\SmartWeatherSettingsForm` (a `ConfigFormBase`), form id
`smartweather_settings`, editable config `smartweather.settings`.

- Route: `smartweather.admin_settings_form`, path `/admin/config/smartweather/settings`,
  `_permission: 'access administration pages'`, `options: { _admin_route: TRUE }`.
- Menu link `smartweather.admin_settings_form` (parent `system.admin_config_system`, weight 99).
- `configure:` in info.yml points here, so the module row on `/admin/modules` shows a "Configure" link.

## Config keys (`smartweather.settings`)

There is **no `config/install` default and no `config/schema`** — the config object does not exist
until the form is saved once (`ddev drush cget smartweather.settings` errors before first save).
All values are trimmed on save.

| Key | Form element | Values / notes |
| --- | --- | --- |
| `openweather_api_key` | textfield, required, maxlength 150 | OpenWeatherMap API key, stored in `smartweather.settings`. |
| `openweather_degrees` | select, required | `metric` (Celsius) or `imperial` (Fahrenheit). Passed to OpenWeatherMap `units=` and used by the template to label °C/°F. |
| `openweather_forecast_days` | select | `''` (No Forecast) or `1`..`7`. Number of forecast days shown *in addition to* current day. |
| `openweather_default_lat` | textfield, maxlength 50 | Fixed latitude. If both lat+long are set, IP geolocation is skipped entirely. |
| `openweather_default_long` | textfield, maxlength 50 | Fixed longitude (paired with lat). |
| `openweather_default_ip` | textfield, maxlength 50 | Fallback public IP passed to geoplugin for local-dev testing (where `REMOTE_ADDR` is `127.0.0.1`). |

## Validation rules (`validateForm`)

- `openweather_api_key` must not be empty.
- Latitude and longitude must both be set or both empty (can't set only one).
- Can't set (lat AND long) AND `openweather_default_ip` at the same time — pick fixed coords *or* an
  IP override.

`submitForm` writes all six keys back to `smartweather.settings` and `->save()`s. No cache is
explicitly cleared, but the two outbound lookups are separately cached for 3600s (see
[api/services.md](../api/services.md)), so a key/location change can take up to an hour to reflect in
a rendered block unless caches are cleared.
