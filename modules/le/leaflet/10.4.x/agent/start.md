# leaflet — agent start

Renders interactive Leaflet maps of **Geofield** data (field formatter + widget + programmatic
service). Depends on `geofield`. Bundles Leaflet 1.9.x + MapLibre GL. No global config route —
maps are configured on the Geofield formatter/widget (Manage display / Manage form display) and
via `hook_leaflet_map_info()` map definitions. Submodules: `leaflet_views`, `leaflet_markercluster`.

- Geofield formatter & widget settings → [configure/formatter-widget.md](configure/formatter-widget.md)
- `leaflet.service` — render maps & process geofields in code → [api/leaflet-service.md](api/leaflet-service.md)
- Define/alter maps, features, widgets (hooks) → [hooks/hooks.md](hooks/hooks.md)
- `leaflet_map` theme hook → [theming/theme.md](theming/theme.md)
- Permissions → [permissions/permissions.md](permissions/permissions.md)
