# `AddressProvider` plugin type

The one plugin type the module defines. Each plugin wraps a geocoding/address API and turns a typed
string into a normalized list of address suggestions.

- Manager service: `plugin.manager.address_provider` (`AddressProviderManager`, extends
  `DefaultPluginManager`).
- Discovery dir: `Plugin/AddressProvider`. Interface: `AddressProviderInterface`. Base class:
  `AddressProviderBase`.
- Attribute (D10.2+): `Drupal\address_suggestion\Attribute\AddressProvider`. Legacy annotation:
  `Drupal\address_suggestion\Annotation\AddressProvider`.
- Alter hook: **`hook_address_suggestion_provider_info(&$definitions)`** — implement to add/remove/edit
  provider definitions.

## Attribute / definition fields

| Field | Meaning |
|---|---|
| `id` | Plugin id (the value stored as widget `provider`). |
| `label` | `TranslatableMarkup` shown in the provider select. |
| `api` | Default endpoint URL. Overridden by a widget/editor `endpoint` setting when set. |
| `nokey` | `TRUE` ⇒ no API key needed (key field hidden in the widget form). |
| `login` | `TRUE` ⇒ provider needs username/password (only `post_ch`). |

## Interface contract

```php
// AddressProviderInterface
public function processQuery($string, $settings);
```

`$settings` is the merged widget/editor settings and may contain: `provider`, `api`, `endpoint`,
`api_key`, `username`, `password`, `country`, `countryName`, `limit`, `location_field`. Return an
array of items; the JS consumes these keys:

`street_name`, `district`, `town_name`, `administrative_area`, `zip_code`, `country_code`,
`value`, `label`, and `location => ['longitude' => …, 'latitude' => …]`.

The base class (`AddressProviderBase`) injects `language_manager` and creates a Guzzle
`GuzzleHttp\Client` as `$this->client`; most providers build the URL as
`$url = !empty($settings['endpoint']) ? $settings['endpoint'] : $settings['api'];` then
`$this->client->request('GET', $url, ['query' => …])`.

## Bundled providers

| id | Label | Default `api` | Key? |
|---|---|---|---|
| `nominatim` | Nominatim OpenStreetMap | `https://nominatim.openstreetmap.org/search` | no (`nokey`) |
| `photon` | Photon Komoot | `https://photon.komoot.io/api/` | no (`nokey`) |
| `france_address` | France Address (data.gouv) | `https://api-adresse.data.gouv.fr/search` | no (`nokey`) |
| `vnpost` | Vietnam Post | `https://maps.vnpost.vn/api/autocomplete` | yes |
| `google_place` | Google Place | `https://maps.googleapis.com/maps/api/place/autocomplete/json` | yes |
| `google_maps` | Google Maps (obsolete) | `https://maps.googleapis.com/maps/api/geocode/json` | yes |
| `here` | Here | `https://geocode.search.hereapi.com/v1/geocode` | yes |
| `tomtom` | TomTom | `https://api.tomtom.com/search/2/geocode/` | yes |
| `map_quest` | MapQuest | `https://www.mapquestapi.com/geocoding/v1/address` | yes |
| `mapbox_geocoding` | Mapbox Geocoding | `https://api.mapbox.com/geocoding/v5/mapbox.places/` | yes |
| `graph_hopper` | GraphHopper | `https://graphhopper.com/api/1/geocode` | yes |
| `distance_matrix` | Distance Matrix | `https://api.distancematrix.ai/maps/api/geocode/json` | yes |
| `bing_maps` | Bing Maps | `http://dev.virtualearth.net/REST/v1/Autosuggest` | yes |
| `capost` | Canada Post | `https://ws1.postescanada-canadapost.ca/addresscomplete/…/json3ex.ws` | yes |
| `post_ch` | Post CH (Swiss) | `https://post.ch` | login (user/pass) |

## Add your own provider

Create `my_module/src/Plugin/AddressProvider/MyProvider.php`:

```php
namespace Drupal\my_module\Plugin\AddressProvider;

use Drupal\Component\Serialization\Json;
use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\address_suggestion\AddressProviderBase;
use Drupal\address_suggestion\Attribute\AddressProvider;

#[AddressProvider(
  id: 'my_provider',
  label: new TranslatableMarkup('My provider'),
  api: 'https://api.example.com/geocode',
  nokey: TRUE,
)]
class MyProvider extends AddressProviderBase {

  public function processQuery($string, $settings) {
    $url = !empty($settings['endpoint']) ? $settings['endpoint'] : $settings['api'];
    $response = $this->client->request('GET', $url, ['query' => ['q' => $string]]);
    $data = Json::decode($response->getBody());
    $results = [];
    foreach ($data as $i => $row) {
      $results[$i] = [
        'street_name' => $row['street'] ?? '',
        'town_name' => $row['city'] ?? '',
        'zip_code' => $row['postcode'] ?? '',
        'country_code' => $row['cc'] ?? ($settings['country'] ?? ''),
        'value' => $results[$i]['label'] = $row['display'] ?? '',
        'location' => ['longitude' => $row['lon'], 'latitude' => $row['lat']],
      ];
    }
    return $results;
  }
}
```

The new id then appears in the widget/CKEditor provider select. Clear caches after adding.
