<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JSON callback routes

Defined in `geolocation_provider.routing.yml`. All four return a `JsonResponse`. `{plugin}` is a
`GeolocationProvider` plugin id; an unknown id is caught (`PluginException`), logged to the
`geolocation_provider` channel, and returned as `JsonResponse($error, 500)`.

| Route path | Controller method | Purpose |
|---|---|---|
| `/geolocation_provider/geolocation/{plugin}/{search}` | `GeolocationProviderController::geolocationCallback` | Forward geocode `{search}` via the provider; returns the provider's array (`$to_array = TRUE`). |
| `/geolocation_provider/reverse/{plugin}/{lat}/{lon}` | `GeolocationProviderController::reverseCallback` | Reverse geocode a coordinate pair. |
| `/geolocation_provider/geolocation_structured/{plugin}/{street}/{postcode}/{city}` | `GeolocationProviderController::geolocationStructuredCallback` | Structured query — calls `$instance->geolocationStructured(...)`, so it only works for a provider implementing that method (Nominatim). |
| `/geolocation_provider/dep/{depCode}` | `GeoApiController::getDepartmentInfo` | Fetch a French department name from `https://geo.api.gouv.fr/departements/{depCode}?fields=nom` (no plugin involved). |

## Access model
Every route requires only `_permission: 'access content'`. On a standard Drupal install that
permission is granted to the anonymous role, so **these endpoints answer to anonymous visitors**,
and each hit makes the server perform an outbound HTTP call to the fixed external geocoding host and
returns the JSON. There is no CSRF token and no rate limiting in the module. The external host per
provider is hardcoded (not admin-configurable), so a request cannot be redirected to an arbitrary
host, but consuming sites should be aware that the callbacks expose their server as a geocoding relay
and that heavy anonymous traffic to the Nominatim provider can trip OpenStreetMap's usage policy
(the site's outbound IP can be throttled or blocked). Front-end use that must be gated should not
rely on these routes as-is — call the plugin manager from an access-checked controller instead.

## Verified behaviour (read-only, anonymous)
- `GET /geolocation_provider/dep/38` → `200 {"nom":"Isère","code":"38"}` with no session.
- `GET /geolocation_provider/geolocation/bano_geolocation_provider/<address>` → `200` with no session.
