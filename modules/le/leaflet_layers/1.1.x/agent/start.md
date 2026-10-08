# Leaflet Layers — agent index

Administer Leaflet layers in the UI and combine layers (from any `hook_leaflet_map_info()` provider
plus your own) into reusable **map bundles**. Two config entities, no global settings page
(`configure` null), no module permission (uses core `administer site configuration` /
`access administration pages`). Depends on contrib **leaflet**. Provides config schema + a
`LayerType` plugin type.

- **Map layer & map bundle config entities — routes, settings keys, storage, how bundles reach Leaflet** →
  [configure/entities.md](configure/entities.md)
- **Add a custom layer rendering type (the `LayerType` plugin: `tilelayer`, `wms`)** →
  [plugins/layer-type.md](plugins/layer-type.md)

Key facts:
- Entities: `map_layer` (`leaflet_layers.map_layer.*`) and `map_bundle` (`leaflet_layers.map_bundle.*`).
- Admin UI at `/admin/structure/leaflet_layers` (overview), `.../map_layer`, `.../map_bundle`.
- `leaflet_layers_leaflet_map_info()` implements `hook_leaflet_map_info()`: each saved bundle becomes a
  Leaflet-selectable map; base layers sorted before overlays; layer options passed to Leaflet as-is.
- LayerType plugins live in `Plugin/LeafletLayerType`, discovered via `plugin.manager.leaflet_layers`
  (annotation `@LayerType`); shipped: `tilelayer`, `wms` (extends `tilelayer`).
