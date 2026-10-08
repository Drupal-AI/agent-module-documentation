<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form: API keys and custom maps

Route `leaflet_more_maps.settings`, path `/admin/config/system/leaflet-more-maps`, permission
`administer site configuration`, form class `Drupal\leaflet_more_maps\Form\SettingsForm`. Config
object: `leaflet_more_maps.settings` (no config schema, no shipped default — it only exists after
the form is saved once).

## Config keys

| Key | Used by | Behavior if empty |
|---|---|---|
| `thunderforest_api_key` | 9 Thunderforest/OSM styles (`osm-cycle`, `osm-transport`, `osm-landscape`, `osm-outdoors`, `osm-transport-dark`, `osm-spinal-map`, `osm-pioneer`, `osm-mobile-atlas`, `osm-neighbourhood`) | Tiles still load but show a "missing API key" watermark |
| `here_api_key` | `here-base` | The tile URL template is blanked (`''`) — map shows nothing |
| `mapbox_access_token` | 4 `mapbox-*` styles | Falls back to a bundled public demo token (`pk.eyJ1Ijoi...`), same one used on leafletjs.com |
| `mapycz_api_key` | 4 `mapycz-*` styles | URL is built anyway but with an empty `apiKey` param — tiles won't load |
| `navionics_api_key` + `navionics_authorized_domain` | `navionics` (3 layers: nautical, sonar, ski) | Both required — module calls Navionics' `get_key` endpoint to fetch a token; without them the tile URL is blanked |
| `leaflet_more_maps_custom_maps` | custom maps (see below) | No custom maps offered |

Stamia/Stamen maps use **domain-based** auth (no key field) — you register your site's domain
(e.g. `*.ddev.site`) directly with Stadia Maps instead.

## Custom maps (combine existing layers)

The form shows 3 "Custom map #N" fieldsets. Each has:
- `map-key` (text) — the name shown in the admin UI and used as the map's label.
- `layer-keys` (checkboxes) — one checkbox per **layer** across every default map, keyed
  `"<map-key> <layer-name>"` (e.g. `bing hybrid layer`, `esri-world_imagery layer`,
  `osm-cycle layer`). See [map-styles.md](map-styles.md) for the full catalog and each map's
  layer name(s).
- `reverse-order` (checkbox) — reverses the layer switcher order (last layer becomes default).

On submit, blank `map-key` or all-unchecked `layer-keys` deletes that custom map slot. Saved
shape in config:

```yaml
leaflet_more_maps_custom_maps:
  1:
    map-key: 'My Combo Map'
    layer-keys:
      - 'bing hybrid layer'
      - 'esri-world_imagery layer'
    reverse-order: false
```

At hook time (`_leaflet_more_maps_assemble_custom_map_info()`), this becomes a new map keyed
`~My Combo Map` in the map-info array, with `layerControl` on automatically when it has more
than one layer, and each layer's switcher label built as `"<base label without its zoom-range
parenthetical> <layer name>"` (e.g. `"Bing road + satellite + hybrid hybrid layer"`).

## Read/write via drush

```bash
drush cget leaflet_more_maps.settings thunderforest_api_key
drush cget leaflet_more_maps.settings leaflet_more_maps_custom_maps
```

```php
// drush php:eval
\Drupal::configFactory()->getEditable('leaflet_more_maps.settings')
  ->set('thunderforest_api_key', 'YOUR_KEY')
  ->set('leaflet_more_maps_custom_maps', [
    1 => ['map-key' => 'My Combo Map', 'layer-keys' => ['bing hybrid layer'], 'reverse-order' => FALSE],
  ])
  ->save();
```

After any config change, run `drush cr` (or otherwise clear the `leaflet_map_info` cache entry)
before the effect shows up in `leaflet_map_get_info()` / the map-style dropdown.
