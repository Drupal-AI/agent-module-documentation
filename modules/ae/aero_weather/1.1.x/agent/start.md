<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Aero Weather (aero_weather) — agent index

Fetches real-time weather from **WeatherAPI.com** and renders it as two block plugins with a
current-conditions card, multi-day + hourly forecast, air-quality index and weather alerts.
Package `Aero Weather`. Depends only on core **`block`**. Core `^10 || ^11`. License
GPL-2.0-or-later. Version 1.1.0. Provides config schema; **no** permissions of its own, no Drush,
no entities, no services beyond `aero_weather.api`.

- **The `aero_weather.api` service, the two blocks and how they render** →
  [blocks/blocks.md](blocks/blocks.md)
- **The settings form, config object + schema, icon styles and caching** →
  [config/settings.md](config/settings.md)

## What it actually provides

- **Service `aero_weather.api`** (`src/Service/AeroWeatherApi.php`) — `getWeatherData($location,
  $forecast_days, $include_aqi)` calls `https://api.weatherapi.com/v1/forecast.json` via the core
  `http_client_factory` (Guzzle), decodes JSON, day-caches it in `cache.default`; also
  `searchLocations()` (autocomplete helper, unused by the blocks), `getWeatherIconSettings()`,
  cache helpers and `getAqiLabel()`.
- **Two Block plugins** (`src/Plugin/Block/`): `aero_weather_horizontal_block`
  (`AeroWeatherHorizontalBlock`) and `aero_weather_vertical_block` (`AeroWeatherVerticalBlock`),
  both using `AeroWeatherBlockTrait` for the shared config form (location, date format, palette,
  rounded corners, forecast/AQI/alerts toggles, forecast-day count, background image). Block
  category *"Aero Weather"*.
- **Settings form** `SettingsForm` (`src/Form/SettingsForm.php`) at route
  `aero_weather.settings_form` → `/admin/config/system/aero-weather`, permission
  **`administer site configuration`**. Writes config object **`aero_weather.settings`**.
- **Theme hooks** `aero_weather_horizontal_block` / `aero_weather_vertical_block` with Twig in
  `templates/` (+ per-metric icon partials under `templates/icons/`).
- **Hook** `hook_aero_weather_color_palettes_alter(&$palettes)` (see `aero_weather.api.php`) —
  add/modify/remove the 30 built-in color palettes (`aero_weather_color_palettes()` in the
  `.module`).
- **Libraries** (`aero_weather.libraries.yml`): `aero_weather_horizontal`, `aero_weather_vertical`,
  `color_palettes`, `aero_weather_admin`, and `swiper_cdn` (Swiper 11 from jsDelivr, loaded only
  when the horizontal block's *Enable SwiperJS* is on).

## Key facts

- No entities, no fields, no REST/AJAX routes — the single route is the admin settings form.
- Both block `build()`s set `#cache['max-age'] = 0` and tag `config:aero_weather.settings`; the
  API response itself is cached inside the service (day-scoped + configurable TTL), keyed by a
  SHA-256 of `location_name . '_' . forecast_days`.
- Location is a **block-configuration string** entered by a block administrator, not a
  request/visitor input; the fetch host is the hardcoded `api.weatherapi.com`.
- All remote WeatherAPI text (condition text, alert event/headline, location name, icon URLs) is
  escaped in the Twig templates (`|e`, `|escape('html_attr')`).
