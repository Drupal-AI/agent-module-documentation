<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Forecast Solar — calling the API

This module is a client wrapper; you invoke it through the `http_client_manager` service.

## Client
- Service description id: `forecast_solar_services` (declared in `forecast_solar.http_services_api.yml`).
- `base_uri: https://api.forecast.solar` — all requests are HTTPS to this fixed host.

## Operations (from `src/api/resources/**`)
- `GetEstimation` — `GET /estimate/{lat}/{lon}/{dec}/{az}/{kwp}`. All five are required URI params: latitude, longitude, plane declination (0–90), azimuth (-180..180), installed module power in kWp.
- `CheckLocation` — `GET /check/{lat}/{lon}` — validate coordinates.
- Plane check — `src/api/resources/misc/check_plane.yml`.

## Response shaping
`GetEstimation` returns `result.watts`, `watt_hours_period`, `watt_hours`, `watt_hours_day` as objects keyed by datetime strings. Each is run through `ApiHelper::convertPeriodicData()`, producing:
```
{ "original": { "<datetime>": <value>, ... },
  "values": [ { "period_start": "<datetime>", "value": <value> }, ... ] }
```
The `message` block carries `info` (place, timezone, coordinates) and a `ratelimit` object (zone, period, limit, remaining) — respect it when polling.

## Notes
- No API key is required for forecast.solar's public endpoints; the module stores no secret.
- The operations take numeric coordinates/orientation as path parameters — there is no user-supplied full URL, so this cannot be pointed at internal hosts.
