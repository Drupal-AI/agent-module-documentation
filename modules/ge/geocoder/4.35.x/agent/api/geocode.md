# Geocode / reverse in code + REST endpoints

## Service `geocoder` (`Drupal\geocoder\GeocoderInterface`)
```php
/** @var \Drupal\geocoder\GeocoderInterface $geocoder */
$geocoder = \Drupal::service('geocoder');

// Providers = array of configured geocoder_provider entity ids, tried in order.
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
- `reverse(string $lat, string $lng, array $providers): ?AddressCollection`

`geocode()` accepts either a plain address string or a `Geocoder\Query\GeocodeQuery`; a string
value fires `hook_geocode_address_string_alter`, a query fires `hook_geocode_address_geocode_query`
before it runs. Each provider in the list is tried in order and the first non-empty result is
returned (failures are logged as warnings), so put a preferred provider first and fallbacks after.

Transform the result with a Dumper (to GeoJSON/WKT/…) or a Formatter — see
[plugins/plugin-types.md](../plugins/plugin-types.md):
```php
$geojson = \Drupal::service('plugin.manager.geocoder.dumper')
  ->createInstance('geojson')->dump($result->first());
```

## REST endpoints (GET, permission `access geocoder api endpoints`)
| Route | Path | Params |
|---|---|---|
| `geocoder.api.geocode` | `/geocoder/api/geocode` | `?address=…&geocoder=<provider_ids>&format=<dumper>&address_format=<formatter>` |
| `geocoder.api.reverse_geocode` | `/geocoder/api/reverse_geocode` | `?latlng=lat,lng&geocoder=<provider_ids>&format=<dumper>` |

`geocoder` is a comma-separated list of configured `geocoder_provider` entity ids (tried in
order). Both routes are GET-only and `no_cache`, handled by `Controller\GeocoderApiEnpoints`, and
return a JSON `AddressCollection` (200) or an empty `204 No Content` when nothing matched. Useful
for JS autocomplete widgets and external clients. Results honor the `cache` setting and provider
throttles.
