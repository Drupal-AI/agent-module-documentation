<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `map` render element (Leaflet)

`Plugin/Element/Map` (`@RenderElement("map")`, `Element/Map.php`) draws a Leaflet map
from a render array. It is the only rendering surface the module provides — there is no
route, block or field; you place `#type => 'map'` in your own build.

## Properties (defaults from `getInfo()`)

| Property | Default | Meaning |
| --- | --- | --- |
| `#tile_url` | `''` | Leaflet tile-layer URL template (`getUrl()` of a provider) |
| `#attribution` | `''` | Attribution markup (`getAttribution()` of a provider) |
| `#center` | `[]` | `[lat, lng]`, e.g. `[51.505, -0.09]` |
| `#zoom` | `13` | Initial zoom |
| `#attributes` | `[]` | Extra HTML attributes on the map `<div>` (set a height!) |
| `#attached` | `[]` | Extra libraries; deep-merged with `map_provider/map` |

```php
$build['map'] = [
  '#type' => 'map',
  '#tile_url' => 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
  '#attribution' => '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
  '#center' => [51.505, -0.09],
  '#zoom' => 13,
  '#attributes' => ['style' => 'height: 500px; width: 500px;'],
];
```

## What `preRenderMap()` emits

The pre-render callback attaches library `map_provider/map`, adds class `leaflet-map`,
and renders a single `<div>` (via an `html_tag` element) carrying:

- `data-map` = `Json::encode(['center' => #center, 'zoom' => #zoom])`
- `data-tile` = `#tile_url`
- `data-layer` = `Json::encode(['attribution' => #attribution])`

`js/map.js` (behavior `mapProviderLeafletMap`) then, once per `.leaflet-map`
(`core/once`): reads `data-map`, calls `L.map(elt, mapSettings)`, and adds
`L.tileLayer(data-tile, data-layer).addTo(map)`.

## JavaScript events (customization hooks)

The behavior fires two jQuery events on the map element so other JS can alter it:

| Event | When | Payload | Use |
| --- | --- | --- | --- |
| `map:beforeInit` | before `L.map()` | `mapSettings` | mutate Leaflet map options (e.g. `settings.zoomControl = false`) |
| `map:afterInit` | after `L.map()` | `[map, layerSettings]` | add markers/layers; call `event.preventDefault()` to **skip** the default `L.tileLayer` and supply your own |

Load your override JS *before* `js/map.js` (give it a negative `weight`) and attach it
through the render element's `#attached['library']`.

## Libraries (`map_provider.libraries.yml`)

- **`map_provider/map`** — `js/map.js`; depends on `core/jquery`, `core/drupal`,
  `map_provider/leaflet`, `core/once`.
- **`map_provider/leaflet`** — expects the Leaflet library on disk at
  `/libraries/leaflet/leaflet.css` and `/libraries/leaflet/leaflet.js` (Leaflet is
  **not** bundled; install it there, e.g. v1.9.4). This is the module's one real
  runtime prerequisite.
