<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LocalGov Geo Area provides the polygon bundle for LocalGov Geo: location records that describe an area — a ward, a catchment, a zone — rather than a single point.

---

Where the address bundle stores a point, this bundle stores geometry describing a region, built on `geo_entity:geo_entity_area`. Areas are useful wherever a council's content is bounded rather than located: ward boundaries, school catchments, parking zones, collection areas, licensing districts. Being ordinary Geo entities they can be referenced from any content type, rendered on a Leaflet map alongside point markers, and queried by geospatial tooling. Note the dependency list: unlike the address submodule this one depends only on `geo_entity:geo_entity_area` and not on `localgov_geo` itself, so it can technically be enabled alongside plain Geo Entity — though on a LocalGov site you will normally have the parent module anyway.

---

- Store ward boundaries as polygons.
- Model school catchment areas.
- Define parking or licensing zones.
- Show an area outline on a map.
- Reference an area from a service page.
- Publish waste collection zones.
- Describe a regeneration area for a subsite.
- Combine area outlines with point markers on one map.
- Keep boundary data editable without GIS software.
- Reuse one boundary across several content items.
- Support geospatial queries against stored polygons.
- Provide open data on council boundaries.
- Model a conservation area for planning content.
- Show which area a reported issue falls in.
- Group directory entries by area.
- Publish flood-risk zones on an emergency page.
- Keep area geometry in a dedicated entity.
- Attach an area to an event covering a district.
- Migrate boundary files into Drupal content.
- Give areas their own pages for deep linking.
