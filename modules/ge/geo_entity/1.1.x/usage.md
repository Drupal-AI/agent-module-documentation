Geo Entity provides a dedicated, reusable content entity (`geo_entity`) for storing geographic information — points, addresses and areas — so a location can be created once and referenced from many other entities.

---

The module defines a revisionable, translatable, fieldable content entity type `geo_entity` with a configurable bundle (`geo_entity_type` config entity). Bundles hold a `label_token` template that auto-generates each geo's label from its field values via the Token module (`GeoEntity::preSave()`). Access is ownership-aware through a custom access control handler (`view geo`, `create geo`, `edit own/any geo`, `delete own/any geo`, plus the super `administer geo`); `hook_install` grants `view geo` to anonymous and authenticated users by default. Geos are managed under *Content › Geo* (`/admin/content/geo`) and bundles under *Structure › Geo types* (`/admin/structure/geo_types`). The module ships a preconfigured Entity Browser (`geo_entity_library`) and a Views-based library so editors can search and reuse existing geos through an `entity_browser_entity_reference` widget; theme hooks and a `geo_entity` render element make geos themeable. Geocoding is delegated to the Geocoder module and wired up per bundle by the submodules. Three submodules add the concrete pieces: **geo_entity_address** (a point+postal-address bundle with a geocoding address-autocomplete widget), **geo_entity_area** (a polygon/area bundle backed by a geo-file field with file-based geocoder providers), and **geo_entity_tz** (populates a Time Zone field from a geofield location via the GeoNames web service). Out of the box it is preconfigured for OpenStreetMap tiles (Leaflet) and the OSM/Nominatim geocoder backend, all swappable for other providers.

---

- Store a physical location once as a Geo entity and reference it from multiple nodes/entities instead of duplicating address fields.
- Build a reusable "location library" that editors pick from via an Entity Browser popup on a reference field.
- Model site venues, offices, branches or points of interest as first-class content with their own view/edit/delete pages.
- Attach arbitrary Field UI fields (opening hours, capacity, images) to a geo bundle.
- Auto-generate a geo's label from a token pattern (e.g. `[geo_entity:postal_address:locality]`) so editors don't hand-type titles.
- Give different editor roles ownership-scoped rights with *edit own geo* / *delete own geo* while trusted staff get *edit any geo*.
- Expose published geos to anonymous visitors for public maps/directories while restricting create/edit to staff.
- Add an address point bundle with an autocomplete that geocodes typed addresses into structured address + coordinates (geo_entity_address).
- Populate latitude/longitude on an address form automatically from the geocoder suggestion the editor selects.
- Store geographic areas/boundaries as polygons imported from GPX, KML, GeoJSON or generic geo files (geo_entity_area).
- Derive a Time Zone field value automatically from a point's coordinates using GeoNames (geo_entity_tz).
- Render a geo on a Leaflet map using the preconfigured OpenStreetMap tiles.
- Translate a location's label and fields into multiple languages (entity is translatable).
- Track revisions of a location and roll back edits (revision UI enabled).
- Swap the default OSM/Nominatim geocoder for a commercial provider by reconfiguring Geocoder providers.
- Provide a REST resource for geo entities (optional `rest.resource.entity.geo_entity` config).
- Use the `geo_entity` render element / theme hook to embed a location's map + fields inside custom templates.
- Filter the Entity Browser library to only "address" or only "area" bundles per reference field.
- Give each bundle its own `embed`, `full` and `inline` view/form modes for context-specific display.
- Seed a directory of countries/cities/regions as geo entities for use as taxonomy-like references.
- Let a custom module create geo entities programmatically and set their owner to the current user automatically.
- Provide a consistent geodata model across a site so mapping, distance and geofield-based Views work against one entity type.
- Expose geo fields (geofield) for proximity/spatial Views queries via the geofield integration.
