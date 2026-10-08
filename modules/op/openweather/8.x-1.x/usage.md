<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Open Weather fetches weather data from the OpenWeatherMap API and renders it in a themeable block.

---

It provides an "Open Weather Block" that can be placed multiple times, each configured for a different location and display. A location is given as a city name, city id, ZIP code, or geographic coordinates (and can be pulled from a user field via a token such as `[current-user:field_city_name]` when the Token module is present). The block can show current conditions, an hourly forecast (3-hour steps, up to 36) or a daily forecast (up to 7 days), and you choose which fields to output (temperature, humidity, wind, sunrise/sunset, etc.). A `WeatherService` builds the query, calls the API, and caches responses (default duration configurable in seconds); timezone/sunrise data is resolved through the GeoNames webservice, which needs its own username.

Configuration lives at `/admin/config/services/openweather` behind the `administer openweather settings` permission and stores the OpenWeatherMap `appid`, the GeoNames username, and the cache duration. Note the service calls both APIs over plain `http://` (see `WeatherService::$baseUri`/`$basegeoUri`), so the app id travels unencrypted; user-supplied block input is escaped with `Html::escape` before being sent as query args. The base API host is hardcoded, so there is no request-controlled outbound URL.

---
- Get an OpenWeatherMap API key (appid) and enter it at `/admin/config/services/openweather`.
- Create a GeoNames account and enable it for free webservices, then set the username.
- Set the default cache duration (seconds) for API responses.
- Place an "Open Weather Block" via `/admin/structure/block`.
- Show current weather for a city by name.
- Show weather by OpenWeatherMap city id.
- Show weather by ZIP code.
- Show weather by latitude/longitude coordinates.
- Display an hourly forecast in 3-hour intervals (up to 36 entries).
- Display a daily forecast (up to 7 days).
- Choose exactly which weather fields the block outputs.
- Show temperature, min/max, humidity, and pressure.
- Show wind speed and direction.
- Show sunrise and sunset times formatted per block config.
- Localize date/time output with a langcode and custom formats.
- Pull a visitor's location from a user field using a Token placeholder.
- Place several weather blocks, each for a different city.
- Override the block theme templates to restyle the output.
- Tune API call volume by increasing the cache duration.
- Diagnose a bad appid via the error logged to dblog.
