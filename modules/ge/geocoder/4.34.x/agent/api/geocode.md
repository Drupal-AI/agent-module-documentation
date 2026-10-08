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

Transform the result with a Dumper (to GeoJSON/WKT/…) or a Formatter — see
[plugins/plugin-types.md](../plugins/plugin-types.md):
```php
$geojson = \Drupal::service('plugin.manager.geocoder.dumper')
  ->createInstance('geojson')->dump($result->first());
```

## REST endpoints (GET, permission `access geocoder api endpoints`)
| Route | Path | Params |
|---|---|---|
| `geocoder.api.geocode` | `/geocoder/api/geocode` | `?address=…&geocoder=<provider_ids>` |
| `geocoder.api.reverse_geocode` | `/geocoder/api/reverse_geocode` | `?latlng=lat,lng&geocoder=<provider_ids>` |

Both are `no_cache` and handled by `Controller\GeocoderApiEnpoints`. Useful for JS
autocomplete widgets and external clients. Results honor the `cache` setting and provider
throttles.
