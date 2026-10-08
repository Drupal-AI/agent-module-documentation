<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Aero Weather settings form, config object & icon styles

## Route & access

`aero_weather.routing.yml` defines one route:

```yaml
aero_weather.settings_form:
  path: '/admin/config/system/aero-weather'
  defaults: { _form: '\Drupal\aero_weather\Form\SettingsForm', _title: 'Aero Weather Settings' }
  requirements: { _permission: 'administer site configuration' }
```

Menu link + local task (`aero_weather.links.menu.yml` / `.links.task.yml`) place it under
*Configuration → System*. `configure: aero_weather.settings_form` in the `.info.yml` wires the
Extend-page gear. There are **no other routes** (no AJAX, no autocomplete, no REST).

## Config object `aero_weather.settings`

Form class `src/Form/SettingsForm.php` (extends `ConfigFormBase`), editable config
`aero_weather.settings`. Install defaults in `config/install/aero_weather.settings.yml`; schema in
`config/schema/weather.schema.yml`.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `api_key` | string | `''` | WeatherAPI.com key. Form field is **required**, `autocomplete=off`. |
| `cache_enabled` | boolean | `false` | Turn the service's response cache on. |
| `cache_time` | integer | `1` | Cache duration (max 1440; must be > 0 when caching on). |
| `cache_unit` | string | `hours` | `minutes` or `hours`. |
| `icon_style` | string | `default` | `default` (built-in SVG) / `upload_url` / `url` / `font`. |
| `{metric}_upload` | ignore | `[]` | Managed-file id array for an uploaded icon. |
| `{metric}_url` | ignore | `null` | External HTTPS icon URL. |
| `{metric}_font` | ignore | `null` | Font-icon markup snippet. |

`{metric}` ∈ `humidity, pressure, wind, uv_index, precipitation, clouds, visibility, sunrise,
sunset` (9 metrics × 3 keys). The nine metrics also have matching keys in the two
`block.settings.aero_weather_*_block` schemas (per-block `location_name`, `date_format`,
`color_palette`, `round_border`, `forecast_days`, `show_forecast`, `show_aqi`, `show_alerts`,
`background_image`, plus `enable_swiper_js` on horizontal and `layout` on vertical).

## Form sections (`buildForm`)

1. **API Configuration** — the required `aero_weather_api_key` textfield.
2. **Cache Settings** — `cache_enabled` checkbox, `cache_time` number, `cache_unit` select (both
   `#states`-visible only when caching is on), and a **"Clear All Weather Cache"** submit
   (`::clearWeatherCache` → `cache.default->deleteAll()` + status message).
3. **Icon Settings** — an `icon_style` select, then for each metric a `managed_file`
   (`public://aero_weather_icons/`, extensions `png jpg jpeg gif svg webp`), a URL textfield, and a
   font-markup textfield — each shown per `#states` for the selected style.

## Validation & submit

- `validateForm()` — cache duration must be a positive number when caching is enabled; for the
  `url` icon style each non-empty icon URL must pass `UrlHelper::isValid(…, TRUE)` **and** start
  with `https://` (HTTP rejected); for the `font` style each snippet is capped at 100 chars.
- `submitForm()` — saves `api_key`, cache keys and `icon_style`; for each metric it clears the old
  upload/url/font, promotes any newly uploaded file to permanent (and marks a replaced file
  temporary), and stores the url/font values. Uploaded font markup is later sanitized at render
  time (`Xss::filter` in `AeroWeatherApi::getWeatherIconSettings()`).

## Config export example

```yaml
# aero_weather.settings
api_key: 'YOUR_WEATHERAPI_KEY'
cache_enabled: true
cache_time: 2
cache_unit: hours
icon_style: default
humidity_upload: []
humidity_url: null
humidity_font: null
# … remaining 8 metrics identical …
```

## Notes

- The key is a plain config value; supply it per-environment (e.g. a `settings.php` config
  override or a config-ignore workflow) rather than committing a real key to exported config.
- `cache_enabled` defaults to **off**, so out of the box every block render triggers a live
  WeatherAPI call (subject only to the service's same-day cache which is written regardless with a
  `time()` expiry when caching is off). Turn caching on to bound API usage.
- Icon uploads land in `public://aero_weather_icons/`; block background images in
  `public://aero_weather_images/`.
