<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services — smartweather

Two container services, both injected into the block. Neither is an API you'd typically call from
other modules, but they are public services and reusable.

## `smartweather.clientlocation` — `Services\ClientLocation`

Constructor args: `@request_stack`, `@http_client` (Guzzle), `@cache.default`.

- `get_client_location($client_ip = '')` → associative array. On success returns the decoded
  geoplugin record (keys like `geoplugin_latitude`, `geoplugin_longitude`, `geoplugin_city`, …); on
  any failure returns `['error_data' => <translated message>]`. Flow (`ClientLocation.php`):
  1. `get_user_agent()` (`HTTP_USER_AGENT`) is matched against a large hardcoded bot regex
     (`ClientLocation.php:40-41`). If it looks like a bot → `error_data` "…for a bot." (no lookup).
  2. If `$client_ip` is empty, `get_client_ip()` is called.
  3. If IP is `UNKNOWN` → `error_data` "IP address can not be detected."
  4. Cache lookup `openweatherip:<ip>` in `cache.default`; on miss it looks the IP up against the
     external geoplugin.net geolocation service (`http_client->get(...)`, `http_errors => FALSE`).
  5. Non-200 → `error_data`. 200 → the response body is decoded into the geoplugin record and cached
     for request-time + 3600s.
- `get_client_ip()` — returns the first non-empty of `HTTP_X_FORWARDED_FOR`, `HTTP_X_FORWARDED`,
  `HTTP_FORWARDED_FOR`, `HTTP_FORWARDED`, `REMOTE_ADDR`, else `'UNKNOWN'` (read from `$request->server`).
- `get_user_agent()` — returns `HTTP_USER_AGENT`.

## `smartweather.openweather` — `Services\OpenWeather`

Constructor args: `@http_client`, `@cache.default`.

- `get_weather($api_key, $latitude, $longitude, $units = 'metric')` → decoded array or
  `['error_data' => …]`. Flow (`OpenWeather.php`):
  1. If `$api_key`, `$latitude` or `$longitude` is empty → `error_data`.
  2. Cache lookup `openweatherdata:<lat><long>` (note: cache id ignores units/API key).
  3. On miss:
     `https://api.openweathermap.org/data/2.5/onecall?lat=<lat>&lon=<long>&units=<units>&appid=<api_key>&exclude=minutely,hourly,alerts&mode=json`
     via `http_client->get($url, ['http_errors' => FALSE])`. TLS verification is left at Guzzle's
     secure default (no `verify => false`).
  4. Non-200 → `error_data`. 200 → `json_decode(..., TRUE)` and cache for request-time + 3600s.

Note: this module targets the OpenWeather **One Call 2.5** endpoint, which OpenWeatherMap has
deprecated in favour of One Call 3.0 — an old API key may return non-200 and surface the
"Weather details can not be fetched…" error.

## Live example

```php
$loc = \Drupal::service('smartweather.clientlocation')->get_client_location('8.8.8.8');
$w   = \Drupal::service('smartweather.openweather')
  ->get_weather('YOUR_KEY', $loc['geoplugin_latitude'], $loc['geoplugin_longitude'], 'metric');
```
