# Configure Leaflet field formatter & widget

Leaflet has no admin settings page. You configure maps per Geofield on an entity's display.

## Formatter — `leaflet_default` (`Plugin/Field/FieldFormatter/LeafletDefaultFormatter`)
On **Manage display** for a Geofield, choose the **Leaflet map** formatter. Settings (shared via
`LeafletSettingsElementsTrait`) include:
- **Map definition** — a named map from `hook_leaflet_map_info()` (base layers, controls).
- **Map height** and default **zoom** / center / fit-bounds behavior.
- **Marker icon** (default, custom image, or DivIcon/HTML) and **popup** content.
- Layer controls, scale, fullscreen, geocoder, reset-view and similar map controls.

## Widget — `leaflet_widget` (`Plugin/Field/FieldWidget/LeafletDefaultWidget`)
On **Manage form display**, choose the Leaflet widget so editors place/draw geometry on a map
(Leaflet.draw-style editing) instead of typing WKT/coordinates. Widget settings mirror many of
the map/appearance options above.

Both are exportable as part of the entity view/form display config
(schema in `config/schema/leaflet.schema.yml`). To add or change the available maps themselves,
implement `hook_leaflet_map_info()` — see [../hooks/hooks.md](../hooks/hooks.md).
