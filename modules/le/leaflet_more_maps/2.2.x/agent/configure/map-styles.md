<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Built-in map style catalog

Every row below is a key in the array returned by `leaflet_map_get_info()` (core Leaflet's
lookup, populated by this module's `hook_leaflet_map_info()`). Pick one of these keys wherever
a site offers a Leaflet map-style dropdown (a Geofield/date Leaflet formatter, Leaflet Views
style). All maps default to `minZoom=0`/`maxZoom=18` except where noted; `layer name(s)` is
what appears in a **custom map**'s layer-key checkboxes as `"<key> <layer name>"`.

| Key | Label | Zoom | API key needed? | Layer name(s) |
|---|---|---|---|---|
| `bing` | Bing road + satellite + hybrid | 1..18 | no | `hybrid layer`, `satellite layer`, `road layer` |
| `esri-world_imagery` | Esri World Imagery | 0..17 | no | `layer` |
| `esri-natgeo_world_map` | Esri National Geographic | 0..12 | no | `layer` |
| `esri-world_physical_map` | Esri Physical | 0..8 | no | `layer` |
| `esri-ocean_world_ocean_base` | Esri Ocean | 0..10 | no | `layer` |
| `esri-world_topo_map` | Esri World Topo Map | 0..18 | no | `layer` |
| `esri-world_street_map` | Esri World Street Map | 0..18 | no | `layer` |
| `google-hybrid` | Google hybrid | 0..18 | no | `layer`, `overlay` |
| `google-satellite` | Google satellite | 0..18 | no | `layer` |
| `google-roadmap` | Google roadmap | 0..17 | no | `layer` |
| `google-high-res` | Google high-res road & terrain (retina) | 0..17 | no | `terrain`, `roadmap` |
| `mapbox-dark` | mapbox Dark | 0..17 | optional (bundled demo token) | `layer` |
| `mapbox-light` | mapbox Light | 0..17 | optional (bundled demo token) | `layer` |
| `mapbox-satellite-streets` | mapbox Satellite-Streets | 0..17 | optional (bundled demo token) | `layer` |
| `mapbox-streets` | mapbox Streets | 0..17 | optional (bundled demo token) | `layer` |
| `mapycz-basic` | Mapy.cz Basic | 0..19 | yes | `layer` |
| `mapycz-outdoor` | Mapy.cz Outdoor | 0..19 | yes | `layer` |
| `mapycz-winter` | Mapy.cz Winter | 0..19 | yes | `layer` |
| `mapycz-aerial` | Mapy.cz Aerial | 0..19 | yes | `layer` |
| `osm-de` | OpenStreetMap.de | 0..18 | no | `layer` |
| `osm-cycle` | Thunderforest Cycle | 0..18 | optional (watermark w/o) | `layer` |
| `osm-transport` | Thunderforest Transport | 0..18 | optional (watermark w/o) | `layer` |
| `osm-landscape` | Thunderforest Landscape | 0..18 | optional (watermark w/o) | `layer` |
| `osm-outdoors` | Thunderforest Outdoors | 0..18 | optional (watermark w/o) | `layer` |
| `osm-transport-dark` | Thunderforest Transport Dark | 0..18 | optional (watermark w/o) | `layer` |
| `osm-spinal-map` | Thunderforest Spinal Map | 0..18 | optional (watermark w/o) | `layer` |
| `osm-pioneer` | Thunderforest Pioneer | 0..18 | optional (watermark w/o) | `layer` |
| `osm-mobile-atlas` | Thunderforest Mobile Atlas | 0..18 | optional (watermark w/o) | `layer` |
| `osm-neighbourhood` | Thunderforest Neighbourhood | 0..18 | optional (watermark w/o) | `layer` |
| `opentopomap` | OpenTopoMap | 0..18 | no | `layer` |
| `stamen-terrain` | Stamen Terrain | 0..17 | no (domain auth) | `layer` |
| `stamen-terrain-background` | Stamen Terrain-Background | 0..18 | no (domain auth) | `layer` |
| `stamen-terrain-labels` | Stamen Terrain-Labels | 0..18 | no (domain auth) | `layer` |
| `stamen-terrain-lines` | Stamen Terrain-Lines | 0..18 | no (domain auth) | `layer` |
| `stamen-toner` | Stamen Toner | 0..18 | no (domain auth) | `layer` |
| `stamen-toner-background` | Stamen Toner-Background | 0..18 | no (domain auth) | `layer` |
| `stamen-toner-hybrid` | Stamen Toner-Hybrid | 0..18 | no (domain auth) | `layer` |
| `stamen-toner-labels` | Stamen Toner-Labels | 0..18 | no (domain auth) | `layer` |
| `stamen-toner-lines` | Stamen Toner-Lines | 0..18 | no (domain auth) | `layer` |
| `stamen-toner-lite` | Stamen Toner-Lite | 0..18 | no (domain auth) | `layer` |
| `stamen-watercolor` | Stamen Watercolor | 0..17 | no (domain auth) | `layer` |
| `here-base` | HERE Base map | 0..18 | yes (blank without) | `layer` |
| `navionics` | Navionics | 0..18 | yes, + authorized domain (blank without) | `nautical-non-transparent`, `sonar`, `ski` |

Notes:
- "domain auth" (Stamen/Stadia) means no key field on the settings form — you register your
  site's domain (e.g. `*.ddev.site` for DDEV) with Stadia Maps instead; see
  [settings-form.md](settings-form.md).
- Any **custom map** assembled from these layers is added under its own `~<map-key>` key
  (see [settings-form.md](settings-form.md)).
- This list is rebuilt by `leaflet_more_maps_leaflet_map_info_alter()` into natural/case-insensitive
  alphabetical order every time it is returned, and other modules may add to it via
  `hook_leaflet_more_maps_list_alter()` (see [../hooks/list-alter.md](../hooks/list-alter.md)).
