# geofield — agent start

Field type storing geometry as WKT (+ derived lat/lon, bbox, geohash) on any entity.
Normalizes through the GeoPHP library. No config UI of its own (configured per field on the
entity's field/form/display). Adds Views proximity + boundary handlers.

- Add & configure the field, widgets, formatters → [configure/field.md](configure/field.md)
- Services: WKT generator, DMS converter, GeoPHP, field value API → [api/services.md](api/services.md)
- Define a storage backend or proximity origin (plugin types) → [plugins/plugins.md](plugins/plugins.md)
- Views proximity/boundary filters, sorts, arguments, fields → [api/views.md](api/views.md)
- Output templates (lat/lon, DMS) & theme hooks → [theming/templates.md](theming/templates.md)
