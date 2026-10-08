<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Open Weather (openweather) — agent index

**Fetches OpenWeatherMap data (with GeoNames for timezone) and renders it in a configurable block.**

- **Version:** 8.x-1.x
- **Core:** ^10.1 || ^11
- **Configure route:** `openweather.settings` → `/admin/config/services/openweather`
- **Permission:** `administer openweather settings`
- **Config object:** `openweather.settings` (keys: `appid`, `geonames_username`, `cache_duration`)
- **Service:** `openweather.weather_service` (`WeatherService` — `getWeatherInformation`, `getCurrentWeatherInformation`, hourly/daily forecast builders, `getTimezoneGeo`)
- **Plugin:** Block `WeatherBlock` (per-block location + field selection)
- **Optional:** Token module (use a user field as the location input)
- **Security:** settings route permission-gated; block placement is admin-only; block input `Html::escape`d before query use; API host hardcoded (no request-controlled URL). Note: both OpenWeatherMap and GeoNames are called over plain `http://` (`WeatherService.php:22,29`), so the appid is sent unencrypted.

See [configure/openweather.md](configure/openweather.md)
