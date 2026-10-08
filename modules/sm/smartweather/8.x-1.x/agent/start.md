<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Smart Weather Forecast (smartweather) — agent index

Provides one **block** (`openweather_block`, admin label "Smart Weather Block") that renders the
current weather plus an optional 1–7 day forecast from **OpenWeatherMap**'s One Call API. By default
the block is *visitor-aware*: it reads the client IP (from `X-Forwarded-For`/`REMOTE_ADDR`), asks
**geoplugin.net** to turn that IP into a latitude/longitude, then queries OpenWeatherMap for that
point. An admin can instead pin a fixed latitude/longitude (skips geolocation entirely) or set a
fallback IP for local dev. Both outbound lookups are cached in `cache.default` for 3600s (keyed by
IP, and by lat+long). All logic lives in two services and the block plugin; there is no controller
and no public route besides the settings form.

The block's constructor eagerly performs the geolocation + weather lookups (in
`WeatherBlock::__construct` → `get_lat_long()` / `weather_details()`), stashing a `weather_data`
array that is handed to the `openweathermap` theme hook and rendered by
`templates/openweathermap.html.twig`. Errors (no IP, bot user-agent, failed HTTP, missing API key)
are surfaced as a `weather_data['error']` string in the template rather than thrown.

- Depends on: nothing (info.yml has no `dependencies`; uses core `http_client`, `cache.default`,
  `request_stack`). No composer.json, no external PHP libraries.
- Core: `^8 || ^9 || ^10 || ^11`. Package: none declared.
- Settings page: **yes** — `configure: smartweather.admin_settings_form`
  (`/admin/config/smartweather/settings`), gated by the core `access administration pages`
  permission. No module-specific permissions, no drush commands, no plugin types.
- Config object: `smartweather.settings` (created on first save; **no** `config/install` default and
  **no** `config/schema` — schemaless config).
- Requires a free **OpenWeatherMap API key** (stored in `smartweather.settings`).

## What you'd do → where

- **Set the API key, units, forecast length, or a fixed/dev location** →
  [configure/settings.md](configure/settings.md)
- **Place / theme the weather block, understand the `weather_data` template variable** →
  [plugins/block.md](plugins/block.md)
- **Call the geolocation or weather service from code; endpoints, caching, IP detection** →
  [api/services.md](api/services.md)

## Key facts (real machine names)

- Block plugin: id `openweather_block`, class `Drupal\smartweather\Plugin\Block\WeatherBlock`,
  category "Openweather". Attaches library `smartweather/weatherblock`.
- Services: `smartweather.clientlocation` (`Services\ClientLocation`, args `@request_stack`,
  `@http_client`, `@cache.default`) and `smartweather.openweather` (`Services\OpenWeather`, args
  `@http_client`, `@cache.default`).
- Service methods: `ClientLocation::get_client_location($client_ip = '')`,
  `ClientLocation::get_client_ip()`, `ClientLocation::get_user_agent()`;
  `OpenWeather::get_weather($api_key, $latitude, $longitude, $units = 'metric')`.
- Route: `smartweather.admin_settings_form` → `/admin/config/smartweather/settings`, form
  `Drupal\smartweather\Form\SmartWeatherSettingsForm` (`_permission: 'access administration pages'`,
  `_admin_route: TRUE`). Menu link `smartweather.admin_settings_form` under `system.admin_config_system`.
- Config keys (`smartweather.settings`): `openweather_api_key`, `openweather_degrees`
  (`metric`|`imperial`), `openweather_forecast_days` (`''`|`1`..`7`), `openweather_default_lat`,
  `openweather_default_long`, `openweather_default_ip`.
- Theme hook: `openweathermap` (variable `weather_data`), template `templates/openweathermap.html.twig`,
  registered in `smartweather_theme()` (smartweather.module). Library `weatherblock` = CSS
  `templates/css/smart-weather.css`.
- Outbound endpoints: geolocation via `geoplugin.net` (keyed on the client IP),
  weather `https://api.openweathermap.org/data/2.5/onecall?lat=&lon=&units=&appid=&exclude=minutely,hourly,alerts&mode=json`.
- Cache ids: `openweatherip:<ip>` and `openweatherdata:<lat><long>`, both TTL request-time + 3600s in
  `cache.default`.
