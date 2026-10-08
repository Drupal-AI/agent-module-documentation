<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Live Weather - agent index

Displays a **weather report from a third-party API** (version **3.0.0**, core `^8.8||^9||^10`).

- Admin routes `live_weather.location` / `.settings` / `.delete`, all perm `live_weather configuration`.
- Service `Drupal\live_weather\LiveWeather` signs an OAuth request and fetches weather data.
- SECURITY: `src/LiveWeather.php` sets `CURLOPT_SSL_VERIFYPEER => false` on the OAuth-signed API call (disabled TLS - see security notes). Target Yahoo endpoint is defunct.
- Category: Integrations / Geospatial / location.
