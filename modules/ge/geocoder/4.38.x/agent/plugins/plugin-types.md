<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin types (Provider / Dumper / Formatter)

Geocoder defines three annotation-based plugin types, each with a manager service and a plugin
namespace under `src/Plugin/Geocoder/`. Annotations: `src/Annotation/GeocoderProvider.php`,
`GeocoderDumper.php`, `GeocoderFormatter.php` (all extend `GeocoderPluginBase`).

## Provider — `@GeocoderProvider`
Manager `plugin.manager.geocoder.provider` (`ProviderPluginManager`), namespace
`Plugin/Geocoder/Provider`. A provider wraps a willdurand/Geocoder PHP provider. Key
annotation fields: `id`, `name`, `handler` (FQCN of the underlying library provider class),
`arguments` (named handler args, e.g. `apiKey`, with optional defaults — surfaced as the
provider config form), optional `throttle` (`period`/`limit`). 31 ship: Addok, ArcGISOnline,
AzureMaps, BANFrance, BingMaps, Bpost, FreeGeoIp, GeoPlugin, Geoip, Geonames, Geopunt,
GoogleMaps, GoogleMapsBusiness, GraphHopper, HostIp, IpInfoDb, LocationIQ, MapQuest, MapTiler,
Mapbox, MaxMind, Nominatim, OpenCage, OpenStreetMap, Openrouteservice, Pelias, Photon, Random,
Spw, TomTom, Yandex. The `file`, `geojsonfile`, `gpxfile` and `kmlfile` provider plugins ship in
the submodules (`geocoder_field` / `geocoder_geofield`).

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
Add one in `src/Plugin/Geocoder/Provider/` (typically extending
`ConfigurableProviderUsingHandlerWithAdapterBase`, or `ProviderUsingHandlerBase` for a
non-adapter handler) and install its `geocoder-php/*` Composer package. The handler is
instantiated by reflection from the `arguments` list resolved against the entity's stored
`configuration`. Base classes: `ProviderBase` (caching via `getCacheId`), `ProviderInterface`,
`ProviderGeocoderPhpInterface`, and the `Traits\ConfigurableProviderTrait`.

## Dumper — `@GeocoderDumper`
Manager `plugin.manager.geocoder.dumper` (`DumperPluginManager`), namespace
`Plugin/Geocoder/Dumper`. Converts an `Address`/`AddressCollection` into a GIS string. Bundled:
`geojson`, `wkt`, `wkb`, `gpx`, `kml`, `addresstext`. Implement `dump(Location $location)`
(`DumperBase`/`DumperInterface`). `DumperPluginManager::setCountryFromGeojson()` resolves a
country code (fires `hook_geocode_country_code_alter`) when filling Address fields.

## Formatter — `@GeocoderFormatter`
Manager `plugin.manager.geocoder.formatter` (`FormatterPluginManager`), namespace
`Plugin/Geocoder/Formatter`. Formats a result into a display string (e.g. `FormattedAddress`,
default id `default_formatted_address`). Implement `FormatterInterface` (`FormatterBase`).

Get any plugin via its manager, e.g.
`\Drupal::service('plugin.manager.geocoder.dumper')->createInstance('geojson')->dump($address)`.
