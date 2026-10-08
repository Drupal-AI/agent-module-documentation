<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Geocode / reverse in code + REST endpoints

## Service `geocoder` (`Drupal\geocoder\GeocoderInterface`, class `Geocoder`)
```php
/** @var \Drupal\geocoder\GeocoderInterface $geocoder */
$geocoder = \Drupal::service('geocoder');

// Providers = array of configured geocoder_provider entity ids (or loaded entities), tried in order.
$providers = ['googlemaps', 'nominatim'];

// Geocode an address string (or a Geocoder\Query\GeocodeQuery).
$result = $geocoder->geocode('1600 Amphitheatre Pkwy, Mountain View', $providers);
// $result is a Geocoder\Model\AddressCollection|NULL
if ($result && $addr = $result->first()) {
  $lat = $addr->getCoordinates()->getLatitude();
  $lng = $addr->getCoordinates()->getLongitude();
}

// Reverse geocode coordinates.
$collection = $geocoder->reverse('37.4224', '-122.0841', $providers); // AddressCollection|NULL
```
- `geocode(GeocodeQuery|string $address, array $providers): ?AddressCollection`
- `reverse(string $latitude, string $longitude, array $providers): ?AddressCollection`

`geocode()` accepts either a plain address string or a `Geocoder\Query\GeocodeQuery`; a string
value fires `hook_geocode_address_string_alter`, a query fires `hook_geocode_address_geocode_query`
before it runs (`Geocoder::geocode()`). String provider ids are loaded via
`GeocoderProvider::load()` (back-compat with the 2.x string form). Each provider in the list is
tried in order and the first non-empty result is returned; failures are caught and logged as
warnings on the `geocoder` channel, so put a preferred provider first and fallbacks after.

Transform the result with a Dumper (to GeoJSON/WKT/…) or a Formatter — see
[plugins/plugin-types.md](../plugins/plugin-types.md):
```php
$geojson = \Drupal::service('plugin.manager.geocoder.dumper')
  ->createInstance('geojson')->dump($result->first());
```

## REST endpoints (GET, permission `access geocoder api endpoints`)
Handled by `Controller\GeocoderApiEnpoints`.

| Route | Path | Params |
|---|---|---|
| `geocoder.api.geocode` | `/geocoder/api/geocode` | `?address=…&geocoder=<provider_ids>&format=<dumper>&address_format=<formatter>` |
| `geocoder.api.reverse_geocode` | `/geocoder/api/reverse_geocode` | `?latlng=lat,lng&geocoder=<provider_ids>&format=<dumper>` |

`geocoder` is a comma-separated list of configured `geocoder_provider` entity ids (loaded via
`loadMultiple()`, tried in order). Both routes are GET-only and `no_cache`, and return a JSON
`AddressCollection` as a `CacheableJsonResponse` (200) or an empty `204 No Content` when nothing
matched. Without a `format` dumper the controller returns each address's `toArray()` enriched
with a `formatted_address` (via the Formatter plugin manager) and a Google-style `geometry`
block. Useful for JS autocomplete widgets and external clients. Results honor the `cache` setting
and provider throttles.
