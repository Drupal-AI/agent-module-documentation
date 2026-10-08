<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Map Provider (map_provider) — agent index

Developer infrastructure: a **MapProvider** plugin type (define map tile providers once,
in YAML or PHP) plus a **`map` render element** that draws them with Leaflet. Enabling it
alone renders nothing — it exists so several mapping features can share one provider list.

No dependencies, no routes, no permissions, no config forms, no config schema, no drush.
Core requirement `^8 || ^9 || ^10 || ^11`. Ships one provider, `osm` (OpenStreetMap).

## Solutions

- **Define a tile provider (YAML or annotation) / consume providers** → [plugins/map-provider.md](plugins/map-provider.md)
- **Render a Leaflet map from a render array; customize it in JS** → [api/render-element.md](api/render-element.md)

## Key facts

- Plugin type `MapProvider` (annotation `@MapProvider(id, label)`), interface
  `Drupal\map_provider\Plugin\MapProviderInterface` → `getUrl()`, `getAttribution()`;
  base class `Plugin\MapProviderBase`.
- Managers: `plugin.manager.map_provider` (`MapProviderManager`, annotation) is the one
  consumers read; `plugin.manager.yaml_map_provider` (`YamlMapProviderManager`,
  `YamlDiscovery`) feeds YAML providers into it as derivatives (`yaml_map_provider:<id>`).
- YAML providers live in `MODULE.map.provider.yml`; keys `id` and `url` are **required**
  (else `PluginException`). Module's own file: `map_provider.map.provider.yml`.
- Alter hook: `hook_map_provider_map_provider_info(&$definitions)`.
- Render element `#type => 'map'` (`Element/Map`): props `#tile_url`, `#attribution`,
  `#center` `[lat,lng]`, `#zoom` (default 13), `#attributes`, `#attached`.
- JS behavior `mapProviderLeafletMap` fires `map:beforeInit` / `map:afterInit` for
  customization. Libraries `map_provider/map` and `map_provider/leaflet`.
- **Runtime prerequisite:** Leaflet must be installed at `/libraries/leaflet/`
  (leaflet.css + leaflet.js) — it is not bundled.
- Operational note worth passing on: public tile servers (OSM) have usage terms and
  commercial providers bill per tile, so provider choice is a licensing/cost decision.
