<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Forecast Solar (forecast_solar) — agent index

**Registers an HTTP Client Manager (Guzzle) service description for the forecast.solar REST API — no routes/UI of its own.**

- **Version:** 1.0.x
- **Core:** `^9 || ^10 || ^11`
- **Dependency:** `http_client_manager`
- **Client id:** `forecast_solar_services`, `base_uri: https://api.forecast.solar`
- **Operations:** `GetEstimation` `/estimate/{lat}/{lon}/{dec}/{az}/{kwp}`, `CheckLocation` `/check/{lat}/{lon}`, plane check.
- **Helper:** `Services\ApiHelper\ApiHelper::convertPeriodicData()` normalises datetime-keyed watt maps.
- **Config page:** `/admin/config/services/http-client-manager/forecast_solar_services`.

**Security:** outbound calls only, over HTTPS to a fixed host; parameters are fixed URI path segments (lat/lon/orientation/power), not a caller-supplied URL — no SSRF surface; no API key/secret stored. See [api/forecast-solar.md](api/forecast-solar.md).
