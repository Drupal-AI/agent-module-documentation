# Theming

Theme hook registered in `leaflet_theme()`:

| Theme hook | Variables |
|---|---|
| `leaflet_map` | `map_id` (DOM id), `height` (default `400px`), `map` (the map definition/settings array attached to the JS) |

`leaflet.service::leafletRenderMap()` builds a render array using this hook and attaches the
Leaflet JS/CSS libraries (`leaflet.libraries.yml`: `leaflet`, `maplibre-gl-js`, `general`, …).
Override by defining a `leaflet-map.html.twig` template in your theme (via a
`template` + theme suggestion) or preprocess `template_preprocess_leaflet_map`. Marker/popup
markup mostly comes from the JS layer and per-feature `popup`/icon settings, which you adjust
through the formatter settings or `hook_leaflet_formatter_feature_alter()`
(see [../hooks/hooks.md](../hooks/hooks.md)).
