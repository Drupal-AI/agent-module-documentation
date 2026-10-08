# Plugin types (Provider / Dumper / Formatter)

Geocoder defines three annotation-based plugin types, each with a manager service and a plugin
namespace under `src/Plugin/Geocoder/`.

## Provider — `@GeocoderProvider`
Manager `plugin.manager.geocoder.provider` (`ProviderPluginManager`), namespace
`Plugin/Geocoder/Provider`. A provider wraps a willdurand/Geocoder PHP provider. Key
annotation fields: `id`, `name`, `handler` (FQCN of the underlying library provider class),
`arguments` (named handler args, e.g. `apiKey`, with optional defaults — surfaced as the
provider config form), optional `throttle` (`period`/`limit`). ~31 ship (Google Maps,
Nominatim, ArcGIS, Mapbox, Bing, TomTom, Yandex, Photon, Pelias, MaxMind, FreeGeoIp, …).

```php
/**
 * @GeocoderProvider(
 *   id = "myprovider",
 *   name = "My Provider",
 *   handler = "\Geocoder\Provider\MyProvider\MyProvider",
 *   arguments = { "apiKey" = "" },
 *   throttle = { "period" = 1, "limit" = 5 }
 * )
 */
```
Add one in `src/Plugin/Geocoder/Provider/` (typically extending `ProviderUsingHandlerBase`)
and install its `geocoder-php/*` Composer package.

## Dumper — `@GeocoderDumper`
Manager `plugin.manager.geocoder.dumper` (`DumperPluginManager`), namespace
`Plugin/Geocoder/Dumper`. Converts an `Address`/`AddressCollection` into a GIS string. Bundled:
`geojson`, `wkt`, `wkb`, `gpx`, `kml`, `addresstext`. Implement `dump(Location $location)`.

## Formatter — `@GeocoderFormatter`
Manager `plugin.manager.geocoder.formatter` (`FormatterPluginManager`), namespace
`Plugin/Geocoder/Formatter`. Formats a result into a display string (e.g. `FormattedAddress`).
Implement `FormatterInterface` (`FormatterBase`).

Get any plugin via its manager, e.g.
`\Drupal::service('plugin.manager.geocoder.dumper')->createInstance('geojson')->dump($address)`.
