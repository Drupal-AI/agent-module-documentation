# geofield_map — agent start

Interactive Google-Maps/Leaflet widget, Google Maps formatter, and Google Maps Views style
for a `geofield` field. Depends on `geofield`. Site-wide config UI:
**Admin → Config → System → Geofield Map settings** (`/admin/config/system/geofield_map_settings`);
route `geofield_map.settings`, permission `configure geofield_map`. Google Maps API key required.

- Set the Google Maps API key, marker storage, geocoder caching; enable the widget/formatter/Views style → [configure/settings.md](configure/settings.md)
- Style markers by data (MapThemer) and add Leaflet base layers (LeafletTileLayerPlugin) → [plugins/plugins.md](plugins/plugins.md)
- Services and `hook_geofield_map_*_alter()` hooks → [api/api.md](api/api.md)
- Submodule (static + embed Google Map formatters) → ../../modules/geofield_map_extras/11.1.x/agent/start.md
