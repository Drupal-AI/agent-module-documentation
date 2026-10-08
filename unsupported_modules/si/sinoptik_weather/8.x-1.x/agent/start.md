<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sinoptik.ua Weather Informer (sinoptik_weather) — agent index
**A configurable block embedding the sinoptik.ua weather informer for selected cities.**

- **Version:** 8.x-1.x (8.x-1.0) · **PHP:** 5.6
- **Core:** ^8 || ^9
- **Block:** `sinoptik_weather_informer` (SinoptikWeatherBlock) — language, cities, width, color.
- **Route:** `sinoptik_weather.autocomplete.cities` (`/sinoptik_weather/autocomplete/{field_name}/{lang}`, `_format: json`) — perm `access content` (effectively anonymous).
- **Library:** `js/sinoptik.js` + remote sinoptik.ua assets; city data fetched via `http_client`.

**Security:** The `access content` autocomplete route is read-only and NOT SSRF — it GETs a hard-coded host `https://sinoptik.ua/search.php` (CityAutocompleteController.php ~L64) with only user-supplied query params; host is a constant, no internal-target redirection possible. Worst case is anonymous-triggered outbound requests to sinoptik.ua. No mutation, SQL, or TLS-disable issues.
