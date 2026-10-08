<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `GeolocationProvider` plugin type

## Discovery wiring
- Annotation: `src/Annotation/GeolocationProvider.php` — fields `id` and `label`.
- Interface: `Plugin/GeolocationProviderPluginInterface` — `geolocation(string $data, array $options = [], bool $to_array = FALSE)` and `reverse(string $latitude, string $longitude, bool $to_array = FALSE)`.
- Manager: `Plugin/GeolocationProviderPluginManager` (`DefaultPluginManager`); directory `Plugin/GeolocationProvider`, alter hook `geolocation_provider_geolocation_provider_plugin_info`, cache key `geolocation_provider_geolocation_provider_plugin_plugins`. Service id: `plugin.manager.geolocation_provider_plugin`.

## Base class — `GeolocationProviderPluginBase`
Implements `ContainerFactoryPluginInterface`; `create()` injects the Guzzle `http_client` and the `serializer` service. The one helper:

```php
public function get($url, $to_array = FALSE) {
  if ($to_array) {
    return Json::decode($this->httpClient->get($url)->getBody());   // raw associative array
  }
  $response = $this->httpClient->get($url)->getBody();
  return $this->serializer->decode($response, 'geojson');           // FeatureCollection|NULL
}
```

- TLS: uses Drupal's default Guzzle client, so certificate verification is on (no `verify => false`).
- The `'geojson'` format is served by `src/Encoder/GeoJsonEncoder.php` (registered in `geolocation_provider.services.yml` with `{ name: encoder, format: geocodejson }`). It only decodes; on a GeoJSON object whose `type === 'FeatureCollection'` it returns a `FeatureCollection`, otherwise `NULL`.

## Result model
- `FeatureCollection` (`src/FeatureCollection.php`) — `Iterator` + `Countable` wrapper over an array of `Feature`. (Note: its `valid()` checks `$this->items` which is never set, so iterating with `foreach` yields nothing on this version — use `count()` / index access, or `$to_array = TRUE` for the raw array.)
- `Feature` (`src/Feature.php`) — plain value object built from a GeoJSON feature's `properties` + `geometry`: `score, x, y, importance, housenumber, postcode, context, id, street, city, label, type, citycode, name, geometry`.

## Shipped providers (`src/Plugin/GeolocationProvider/`)
- **Bano** id `bano_geolocation_provider` — forward `GET https://data.geopf.fr/geocodage/search/?q={data}` (plus `$options`); reverse `GET https://data.geopf.fr/geocodage/reverse/?lat=&lon=`. French IGN endpoint, keyless.
- **Nominatim** id `nominatim_geolocation_provider` — forward `GET https://nominatim.openstreetmap.org/search?q={data}&format=geojson&polygon=1`; reverse `.../reverse?lat=&lon=`; extra `geolocationStructured($street, $postcode, $city, $options = [], $to_array = FALSE)` → `.../search?street=&postcode=&city=&format=geojson&polygon=1`. Keyless, but subject to OSM's Nominatim usage policy (~1 req/s, no heavy automated use).

All request URLs are built with `Url::fromUri(base, ['query' => [...]])`, so user-supplied address/coordinate values are URL-encoded into the query string.

## Writing a custom provider
```php
use Drupal\geolocation_provider\Plugin\GeolocationProviderPluginBase;

/**
 * @GeolocationProvider(
 *   id = "my_provider",
 *   label = @Translation("My provider")
 * )
 */
class MyProvider extends GeolocationProviderPluginBase {
  public function geolocation($data, $options = [], $to_array = FALSE) {
    $url = \Drupal\Core\Url::fromUri('https://api.example.com/search', [
      'query' => ['q' => $data] + $options,
    ]);
    return $this->get($url->toString(), $to_array);  // use get() only if the API returns GeoJSON
  }
  public function reverse($latitude, $longitude, $to_array = FALSE) {
    // If the API is not GeoJSON, call $this->httpClient / $this->serializer yourself.
    return $this->get('https://api.example.com/reverse?lat=' . $latitude . '&lon=' . $longitude, $to_array);
  }
}
```
Add an API key by overriding the endpoint build in your plugin (append it as a query/header on the request); the base class and shipped providers hold no key concept.

## Consuming from code
```php
$manager = \Drupal::service('plugin.manager.geolocation_provider_plugin');
$provider = $manager->createInstance('nominatim_geolocation_provider');
$collection = $provider->geolocation('10 Downing Street, London');   // FeatureCollection|NULL
$raw = $provider->geolocation('10 Downing Street, London', [], TRUE); // raw GeoJSON array
```
