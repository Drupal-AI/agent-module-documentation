<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalGov Geo Area (localgov_geo_area) — agent index

Bundle-provider submodule for [localgov_geo](../../../../2.1.x/agent/start.md): the **polygon /
area** geo bundle. Config only.

Key facts:
- Depends on **`geo_entity:geo_entity_area`** only — note it does **not** declare a dependency on
  `localgov_geo` itself (unlike `localgov_geo_address`), so it can be enabled against plain Geo
  Entity.
- Stores area geometry (polygons) rather than points: wards, catchments, zones, districts.
- Areas are ordinary Geo entities — referenceable from any content type, renderable on Leaflet
  maps, and usable by geospatial queries.
- No routes, permissions, schema or Drush of its own; access is governed by Geo Entity's
  permissions (see the parent module's note about `view geo` being granted to anonymous on
  install).
