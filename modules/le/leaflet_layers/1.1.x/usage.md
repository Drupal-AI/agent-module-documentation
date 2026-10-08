Leaflet Layers lets you administer Leaflet map layers through the Drupal UI and combine layers from multiple modules (plus your own custom layers) into reusable *map bundles* that any Leaflet map can select.

---

The module adds two config entities under *Structure › Leaflet Layers*: **Map layer** (`map_layer`) defines a single custom tile/WMS layer, and **Map bundle** (`map_bundle`) groups layers — both those exposed by other modules via `hook_leaflet_map_info()` and your own Map layers — into an ordered set with per-layer enable/weight/custom-label/"on by default" controls and a set of Leaflet map behavior toggles (dragging, zoom controls, animations, layer switcher, etc.). Custom layers are built from **LayerType** plugins (`Plugin/LeafletLayerType`): `tilelayer` (URL template + zoom/opacity/subdomains/TMS options) and `wms` (adds layers/styles/format/version/transparent). At runtime `leaflet_layers_leaflet_map_info()` implements `hook_leaflet_map_info()` itself, so every saved bundle appears as a selectable map to the Leaflet module, merging the referenced layers, ordering base layers before overlays, and passing each layer's `urlTemplate`/options through to Leaflet. There is no global settings page (`configure` is null) and no module-specific permission — the config entities are gated by core's `administer site configuration`, and the overview page by `access administration pages`. Config is stored as `leaflet_layers.map_layer.*` and `leaflet_layers.map_bundle.*` (schema provided). The module depends on the contrib **Leaflet** module.

---

- Combine base maps and overlays from several Leaflet-provider modules into one selectable map.
- Define a custom OpenStreetMap-style tile layer by entering a URL template with `{x}/{y}/{z}`.
- Add a WMS layer (GeoServer/MapServer) by specifying layers, styles, format, and version.
- Set attribution text required by a tile provider on a custom layer.
- Control min/max zoom, zoom offset, and opacity for a custom tile layer.
- Use subdomains (e.g. `mt1,mt2,mt3`) to spread tile requests across hosts.
- Enable TMS tiling or reverse-zoom numbering for providers that need it.
- Enable retina tile detection for high-DPI displays.
- Group multiple layers into a named bundle and reorder them by drag-and-drop weight.
- Mark a layer as a base layer vs. an overlay in a bundle.
- Choose which overlays are toggled "on by default" when the map loads.
- Give a layer a custom label shown in the Leaflet layer-switcher control.
- Enable or disable individual layers within a bundle without deleting them.
- Toggle Leaflet map behaviors per bundle: dragging, scroll-wheel/touch/double-click zoom.
- Show or hide the zoom control, attribution control, or layer-switcher control per bundle.
- Turn fade/zoom animations or "close popup on click" on or off for a bundle.
- Expose a curated multi-provider map to editors as a single Leaflet map option.
- Provide a self-hosted or proxied tile source instead of a hardcoded provider in code.
- Manage map layer configuration in code via exported `leaflet_layers.map_bundle.*` / `map_layer.*` config.
- Add a new custom layer rendering type by implementing a `LayerType` plugin.
- Reuse the same bundle across multiple Geofield/Leaflet map formatters and views.
