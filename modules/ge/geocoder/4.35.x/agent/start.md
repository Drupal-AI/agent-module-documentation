# geocoder — agent start

Services API wrapping willdurand/Geocoder: `geocode()` / `reverse()` through configurable
provider plugins, with Dumper (GIS format) and Formatter output. Engine module — field
integration lives in submodules `geocoder_field`, `geocoder_geofield`, `geocoder_address`.
Config UI: **Admin → Config → System → Geocoder** (`/admin/config/system/geocoder`, route
`geocoder.settings`). Depends on external Composer libs, not other Drupal modules. This is the
4.35.x branch (installed release `8.x-4.35`, D9.5/10/11).

- Settings & provider config entities → [configure/providers.md](configure/providers.md)
- Plugin types it defines (Provider / Dumper / Formatter) → [plugins/plugin-types.md](plugins/plugin-types.md)
- Geocode/reverse in code + REST endpoints → [api/geocode.md](api/geocode.md)
- Alter hooks → [hooks/alter-hooks.md](hooks/alter-hooks.md)
- Permissions → [permissions/permissions.md](permissions/permissions.md)
