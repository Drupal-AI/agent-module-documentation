# Map field formatters

Two field formatters render a location value as an embedded map. They are display-only and do not
call the suggestion route.

| Formatter id | For field type | Class | Config schema |
|---|---|---|---|
| `address_map` | `geofield` | `AddressMapFormatter` | `field.formatter.settings.address_map` |
| `address_suggestion_map` | `address` | `AddressSuggestionMapFormatter` | `field.formatter.settings.address_suggestion_map` |

## `address_map` (geofield)

Renders a map from the geofield's stored lon/lat.

| Setting | Default | Meaning |
|---|---|---|
| `provider` | `osm` | One of `osm`, `arcgis`, `mapbox`, `mapquest`, `tomtom`, `here`. |
| `api_key` | `''` | Required for `mapbox`, `mapquest`, `tomtom`, `here`. |
| `width` | `''` | Map width (px). |
| `height` | `300` | Map height (px). |
| `zoom` | `12` | Initial zoom. |

Each provider maps to a JS library (`address_suggestion/address_map.osm|arcgis|mapbox|mapquest|tomtom|here`);
`osm`/`arcgis` need no API key. Map libraries pull provider SDKs/tiles from external CDNs (Leaflet,
Mapbox GL, ArcGIS, etc. — see `address_suggestion.libraries.yml`).

## `address_suggestion_map` (address)

Renders a map for an `address` field. Because an address has no coordinates, it either reads a linked
`location_field` (geofield/geolocation on the same entity) or builds a map URL/iframe from the
formatted address.

| Setting | Default | Meaning |
|---|---|---|
| `location_field` | — | Machine name of a geo field supplying coordinates. |
| `provider` | — | Map provider (same family as above, plus a Google-map iframe path). |
| `width` / `height` / `zoom` | — | Map size and zoom. |

Set a formatter from code:

```php
\Drupal::service('entity_display.repository')
  ->getViewDisplay('node', 'article', 'default')
  ->setComponent('field_geo', [
    'type' => 'address_map',
    'settings' => ['provider' => 'osm', 'height' => 300, 'zoom' => 12],
  ])->save();
```
