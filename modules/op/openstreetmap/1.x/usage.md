Creates and maintains Drupal content entities ("OSM Nodes") that mirror OpenStreetMap nodes and ways, pulling their tags into fields and their geometry into a Geofield.

---

OpenStreetMap adds a revisionable, translatable, bundleable content entity type `osm_node` that tracks a single OpenStreetMap element (a node or a way) by its OSM ID. On save it fetches the element from a configured Overpass API interpreter and stores the element's `name`, its geometry as WKT in a `geodata` Geofield (a point for nodes, a polygon for ways), and any OSM tag whose key matches a field on the bundle (with or without a `field_` prefix). You define OSM Node types (bundles) and add whatever fields you want mirrored — e.g. `wheelchair`, `field_bus` — plus core address-field mapping is handled for `addr:*` tags. Elements can be added one at a time by OSM ID, imported in bulk from an ad-hoc Overpass query, or (with the OpenStreetMap Query Tools submodule) kept in sync from saved named queries. The stored Geofield can then be mapped by any geospatial display module such as Leaflet. The Overpass endpoint is a site-wide admin setting (`openstreetmap.settings:endpoint`); the module ships no map rendering of its own.

---

- Track a curated set of real-world places (shops, bus stops, trailheads) as Drupal content synced from OpenStreetMap.
- Store each place's coordinates in a Geofield and render them on a Leaflet (or other geospatial) map view.
- Mirror OSM tags into Drupal fields automatically by naming fields after the tag key (e.g. `cuisine`, `opening_hours`).
- Use the `field_` prefix convention so `field_wheelchair` receives the OSM `wheelchair` tag.
- Import an entire category of features for a region in one batch via an Overpass query (e.g. "all cafes in Atlanta").
- Add a single OSM node by its ID through the OSM Node List admin UI.
- Track OSM "ways" (polygons/line geometries) by checking the "Is way" box, storing the way outline as a polygon.
- Keep imported nodes fresh by re-running "Sync All", which re-fetches every tracked element from OSM.
- Re-sync a single node on demand from its entity page ("Sync from OSM" tab).
- Inspect the raw OSM payload for a node and jump to view/edit it on openstreetmap.org via the "OSM Data" tab.
- Maintain full revision history of each OSM Node, with revert and delete-revision operations.
- Translate OSM Node labels and fields (the entity type is translatable).
- Restrict who can create, edit, delete, view, and administer OSM Nodes via granular per-bundle permissions.
- Populate a core Address field automatically from OSM `addr:*` tags (city, country, house number/street, postcode, state).
- Build editorial workflows around published/unpublished OSM Node states.
- Feed OSM-sourced geodata into Views for lists, maps, and blocks of places.
- Seed a store locator, points-of-interest directory, or asset registry from public OpenStreetMap data.
- Preview how many elements an Overpass query will return before importing them (via the query "Execute" tab in the submodule).
- Choose any public or self-hosted Overpass interpreter URL as the data source in OSM Settings.
- Run a one-off Overpass query and dump the raw response without importing, using the Import OSM Nodes form's "Run Query".
- Bulk-load points of interest into a specific bundle by selecting the target OSM Node Type on import.
- Extend sync behavior with custom modules via the `hook_openstreetmap_sync` and `hook_openstreetmap_sync_batch_alter` hooks.
- Adjust how a node's tags map to fields before save with `hook_osm_node_presave_alter`.
