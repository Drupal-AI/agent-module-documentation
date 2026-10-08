# Geo Entity — agent index

A reusable content entity (`geo_entity`) for storing/reusing geographic data (points, addresses, areas)
with per-bundle geocoding. Revisionable, translatable, fieldable. Bundles = `geo_entity_type` config
entities. Managed at *Content › Geo* (`/admin/content/geo`); bundles at *Structure › Geo types*
(`/admin/structure/geo_types`, `configure` = `entity.geo_entity_type.collection`). Depends on
geofield, leaflet, entity_browser, token; geocoding via the Geocoder module (wired by submodules).

- **Bundle (geo type) config, `label_token`, admin routes, Entity Browser library** → [configure/geo-types.md](configure/geo-types.md)
- **The `geo_entity` entity: base fields, owner logic, `preSave` label token, autocomplete route** → [api/entity.md](api/entity.md)
- **Permissions & the ownership-aware access handler (default anonymous can view)** → [permissions/permissions.md](permissions/permissions.md)

Submodules (own docs):
- `geo_entity_address` (point + postal address, geocoding autocomplete widget) → [../../modules/geo_entity_address/1.1.x/agent/start.md](../../modules/geo_entity_address/1.1.x/agent/start.md)
- `geo_entity_area` (polygon/area bundle, file-based geocoders) → [../../modules/geo_entity_area/1.1.x/agent/start.md](../../modules/geo_entity_area/1.1.x/agent/start.md)
- `geo_entity_tz` (Time Zone from coordinates via GeoNames) → [../../modules/geo_entity_tz/1.1.x/agent/start.md](../../modules/geo_entity_tz/1.1.x/agent/start.md)

Key facts:
- Entity type `geo_entity`: `base_table` geo_entity, revision + data tables, `admin_permission` = `access geo overview`, bundle entity `geo_entity_type`.
- Bundle config export keys: `id`, `label`, `uuid`, `label_token` (schema `geo_entity.geo_entity_type.*`).
- Ships config: Entity Browser `geo_entity_library`, View `geo_entity_library`, view modes `embed`/`full`, form mode `inline`, optional REST resource.
- No Drush commands. Provides a config schema. Defines no plugin types (uses core entity + Views + Geocoder plugins).
- Two default bundles (`address`, `area`) are provided by the submodules, not the base module.
