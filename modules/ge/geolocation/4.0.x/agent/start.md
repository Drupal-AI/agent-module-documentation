# geolocation — agent start

Lat/lng field type + map widgets/formatters + a large plugin framework for maps, geocoding,
and proximity Views. Core dep: `field`. Map providers ship as submodules (enable one, e.g.
`geolocation_google_maps` or `geolocation_leaflet`). No single config page — configure per
field (Manage form display / Manage display) and per provider submodule.

- Field type, widgets, formatters, per-provider setup → [configure/field.md](configure/field.md)
- Views: CommonMap style, proximity filter/sort/argument → [configure/views.md](configure/views.md)
- Plugin types it defines (map providers, features, geocoders, …) → [plugins/plugins.md](plugins/plugins.md)
- Alter map widgets via hook → [extend/hooks.md](extend/hooks.md)
- Permissions → [permissions/permissions.md](permissions/permissions.md)
- Submodules (Google, Leaflet, Search API, address, GPX, …) → [configure/submodules.md](configure/submodules.md)
