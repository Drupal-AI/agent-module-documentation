# Geoblock — the `geoblock_data_source` plugin type

Geoblock defines a plugin type but **ships no concrete plugin**. Without a data source selected
in `geoblock.settings` (`data_source`), the module does nothing. To make geoblock work you (or a
companion module) must provide a `geoblock_data_source` plugin that geolocates an IP.

## Plugin type definition
- **Manager service**: `plugin.manager.geoblock_data_source`
  (`\Drupal\geoblock\Plugin\GeoblockDataSourcePluginManager`, extends `DefaultPluginManager`).
- **Directory**: `Plugin/GeoblockDataSource` in any module.
- **Annotation**: `@GeoblockDataSource` (`\Drupal\geoblock\Annotation\GeoblockDataSource`) —
  properties `id` and `label`.
- **Interface**: `GeoblockDataSourcePluginInterface`; base class
  `GeoblockDataSourcePluginBase` (extends `PluginBase`).
- **Alter hook**: `hook_geoblock_data_source_info_alter()`. Cache key
  `geoblock_data_source_plugins`.

## Interface to implement
```php
public function locate(\Drupal\geoblock\IPAddress $address): void;
```
`locate()` receives the `IPAddress` and decorates it with country information by calling:
- `$address->setCountryCode($iso3166_alpha2)` — the country where the IP is being used.
- `$address->setRegisteredCountryCode($iso3166_alpha2)` — the country where the IP is registered
  (used by the domestic-use restriction).

Both setters validate against `league/iso3166` and throw `\InvalidArgumentException` on bad
input. Read helpers on `IPAddress`: `getAddress()`, `getCountryCode()`,
`getRegisteredCountryCode()`, `isDomesticUse()`, `isPublic()`. Note the `RequestHandler` only
locates public IPs meaningfully — private/reserved ranges have no country.

## Minimal implementation sketch
```php
// modules/custom/my_geoip/src/Plugin/GeoblockDataSource/MyGeoIp.php
namespace Drupal\my_geoip\Plugin\GeoblockDataSource;

use Drupal\geoblock\Plugin\GeoblockDataSourcePluginBase;
use Drupal\geoblock\IPAddress;

/**
 * @GeoblockDataSource(
 *   id = "my_geoip",
 *   label = @Translation("My GeoIP source")
 * )
 */
class MyGeoIp extends GeoblockDataSourcePluginBase {
  public function locate(IPAddress $address): void {
    $cc = my_lookup_country($address->getAddress()); // your GeoIP lookup
    if ($cc) {
      $address->setCountryCode($cc);
      $address->setRegisteredCountryCode($cc);
    }
  }
}
```
After enabling the module, the plugin appears in the **Data source** select on
`/admin/config/geoblock`; select it (or set `data_source: my_geoip` in config) to activate
enforcement. Restriction logic itself lives outside the plugin — see
[../configure/settings.md](../configure/settings.md).
