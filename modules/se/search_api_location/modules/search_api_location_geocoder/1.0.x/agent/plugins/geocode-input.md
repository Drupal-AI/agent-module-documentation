<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `geocode` Location Input plugin

Adds a Location Input plugin to Search API Location's `location_input` plugin type.

- Id **`geocode`**, label **"Geocoded input"**, description "Let user enter an address that will
  be geocoded."
- Class `Drupal\search_api_location_geocoder\Plugin\search_api_location\location_input\Geocode`,
  extends `LocationInputPluginBase` and implements `ContainerFactoryPluginInterface`.
- Injected services: `geocoder` (the Geocoder module service), `config.factory`
  (reads `geocoder.settings`), and the `geocoder_provider` entity storage.

## Behaviour
```php
public function getParsedInput(array $input) {
  // $input['value'] is the typed address.
  $active = $this->getActivePlugins();               // checked providers, sorted by weight
  $opts   = (array) $this->geocoderConfig->get('plugins_options');
  $addresses = $this->geocoder->geocode($input['value'], $active, $opts);
  return $addresses ? first coordinates as "lat,lon" : NULL;
}
```
- `getActivePlugins()` reads `$this->configuration['plugins']`, keeps entries whose `checked` is
  truthy, sorted by `weight` (`SortArray::sortByWeightProperty`). The **first provider to return a
  valid coordinate wins**.
- `defaultConfiguration()` seeds `plugins` from every existing `geocoder_provider` entity with
  `checked = 0`, `weight = 0`.

## Configuration form
`buildConfigurationForm()` renders a **draggable table** of every `geocoder_provider` entity, each
row a `checked` checkbox + a `weight`. Admins tick and order the providers to try. These settings
are stored inside the host (a Views filter or facet) config — see
`search_api_location_views`' schema key `plugin-geocode` (`plugins` sequence of `{checked, weight}`
plus `radius_type`/`radius_options`/`radius_units`).

## Requirements & setup
1. Enable the **geocoder** module and configure at least one **`geocoder_provider`** config
   entity (Configuration → System → Geocoder → Providers). Without a provider there is nothing to
   geocode with.
2. Wherever a Location Input is chosen (e.g. the `search_api_location_views` proximity filter's
   exposed widget, or a facet), select **Geocoded input** (`geocode`).
3. In the plugin settings, tick the geocoder providers to use and order them.

Note: most geocoder providers call **external services** (Google, Nominatim, …); an offline
provider (e.g. the Geocoder `random`/file plugins) is useful for local testing. The `geocode`
plugin itself adds no new plugin type, permission, Drush command, or config schema.
