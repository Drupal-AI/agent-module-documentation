<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
IP API is a thin service wrapper around the ip-api.com geolocation endpoint that resolves the visitor's IP address to country, city, region, ISP, coordinates, timezone and more.

The `ip_api.geolocation` service reads the client IP from the request stack (`Request::getClientIp()`), builds the endpoint URL, calls it with Guzzle, and returns an `IpApiParameters` value object with typed getters (`getCountry()`, `getCity()`, `getCountryCode()`, `getLatitude()`, `getLongitude()`, `getIsp()`, `getTimezone()`, `isRequestSuccessful()`, …). Store an optional API key at `/admin/config/system/ip-api` (behind `administer ip_api configuration`); when a key is set the module targets the paid `pro.ip-api.com` host, otherwise the free `ip-api.com` host.

Operational notes: the module exposes no public route of its own — it is a service other code calls. Both endpoints are contacted over plain `http://` (see the security posture in start.md), so an API key is transmitted in the clear and results are not authenticated in transit; front it with your own HTTPS proxy if that matters. Because the URL embeds `getClientIp()`, deployments behind a reverse proxy must configure Drupal's trusted-proxy settings so the resolved IP is correct.
---
Resolve the current client IP to geolocation data via ip-api.com, exposed as a typed PHP service.
---
- Look up the visitor's country from `ip_api.geolocation`'s `getCountry()`.
- Get the two-letter country code with `getCountryCode()` for locale logic.
- Read the city name with `getCity()`.
- Fetch latitude/longitude via `getLatitude()` / `getLongitude()` for maps.
- Identify the visitor's ISP or organisation with `getIsp()` / `getOrganization()`.
- Retrieve the timezone string with `getTimezone()`.
- Read the region/state short code with `getRegion()`.
- Get the resolved IP used for the query with `getIp()`.
- Check `isRequestSuccessful()` before trusting the returned fields.
- Store a paid API key at `/admin/config/system/ip-api` to use `pro.ip-api.com`.
- Leave the key blank to use the free `ip-api.com` tier.
- Inject `@ip_api.geolocation` into your own service to geolocate requests.
- Drive country-based content or redirects from the resolved country code.
- Pre-fill address or currency fields from the detected location.
- Log visitor geolocation for analytics from a custom subscriber.
- Grant `administer ip_api configuration` only to trusted admins (restricted).
- Configure trusted reverse-proxy settings so `getClientIp()` returns the real IP.
- Handle a NULL return (network error) — the service logs and returns without data.
