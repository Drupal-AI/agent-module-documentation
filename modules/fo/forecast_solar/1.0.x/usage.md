<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Forecast Solar provides an HTTP Client Manager service description that lets Drupal call the forecast.solar REST API for photovoltaic production and weather forecast data.
---
The module contributes no routes, forms or blocks of its own. Instead it registers a Guzzle-service-description (via the `http_client_manager` module) named `forecast_solar_services`, with `base_uri: https://api.forecast.solar` and operations defined in `src/api/**` YAML: `GetEstimation` (`/estimate/{lat}/{lon}/{dec}/{az}/{kwp}`), `CheckLocation` (`/check/{lat}/{lon}`) and a plane check. A developer resolves the client through HTTP Client Manager and calls these operations from PHP.

Because the estimate endpoint returns dynamic datetime keys that Guzzle cannot model, the response is post-processed by `ApiHelper::convertPeriodicData()`, which rewrites each `{datetime: watts}` map into an `original` map plus a normalised list of `{period_start, value}` rows. The upstream base URI is HTTPS (TLS enforced by the shared http_client_manager Guzzle client), the operation parameters are fixed URI path parts (latitude/longitude/orientation/power) rather than an arbitrary caller-supplied URL, and the module stores no secret — forecast.solar's public endpoints need no API key.

Setup is: require `http_client_manager`, enable this module, then configure/inspect the client at `/admin/config/services/http-client-manager/forecast_solar_services`.
---
- Register a ready-made forecast.solar API client in Drupal.
- Fetch a solar production estimate for a location and panel orientation.
- Pass latitude, longitude, declination, azimuth and installed kWp to `GetEstimation`.
- Validate a latitude/longitude pair with `CheckLocation`.
- Check a specific plane orientation with the plane resource.
- Read expected watts, watt-hours per period, and watt-hour day totals.
- Normalise the datetime-keyed watt maps into iterable rows via the helper filter.
- Show a "today's expected solar yield" figure on a dashboard.
- Drive an energy-aware feature (e.g. schedule tasks when production is high).
- Inspect or override the request config at the HTTP Client Manager admin page.
- Reuse the Guzzle client from custom code through the http_client_manager service.
- Add rate-limit awareness using the `ratelimit` block in the response model.
- Combine location metadata (place, timezone) returned in the message block.
- Build a weather/solar forecast block for site visitors.
- Cache forecast responses in custom code to respect API rate limits.
- Extend the service description YAML with additional forecast.solar operations.
- Unit-test response transforms following the bundled `ApiHelperTest`.
- Keep all calls over HTTPS to `api.forecast.solar` (base_uri is fixed).
