Adds a saveable "Overpass Query" content entity so administrators can name, store, preview and re-run Overpass API queries that import and keep OSM Nodes in sync.

---

OpenStreetMap Query Tools is a submodule of OpenStreetMap that turns one-off Overpass imports into managed, reusable objects. It defines the `osm_query` content entity — a title, an Overpass QL body, an enabled flag, and a target OSM Node Type (bundle) — administered under *Structure → Overpass Queries*. Each saved query can be executed on demand (starting a batch that upserts an OSM Node per returned element into the chosen bundle) or tested (which reports how many elements the query returns without importing). When installed, the submodule also hooks into the parent's "Sync All" operation so that every enabled saved query is re-run, refreshing the tracked nodes from OpenStreetMap. It relies entirely on the parent module's `overpass` service for the actual HTTP call, and on the parent's admin-configured Overpass interpreter endpoint.

---

- Save a named Overpass query (e.g. "All Bus Stops in Atlanta") for repeated reuse.
- Route each query's results into a specific OSM Node Type (bundle) on import.
- Preview how many OSM elements a query returns before importing, via the query "Test" action.
- Execute a saved query to batch-import/upsert matching OSM Nodes.
- Refresh all tracked nodes at once: "Sync All" re-runs every enabled saved query.
- Enable or disable individual queries without deleting them (the `status` flag).
- Maintain a library of region/feature queries (cafes, trails, hydrants) as first-class content.
- Restrict query create/view/edit/delete/administer via granular permissions.
- List all saved queries with status and timestamps in the admin collection at /admin/structure/osm_query.
- Keep a points-of-interest dataset current by scheduling periodic Sync All runs (via cron/UI).
- Seed a store locator or directory bundle from a single, versionable Overpass query.
- Import an entire OSM feature category for a bounding box in one operation.
- Separate the "what to import" (query) from the "where the data lives" (bundle) cleanly.
- Let non-developer editors re-run vetted queries without writing Overpass syntax each time.
- Audit when a query was created and last changed from the list builder.
- Combine multiple queries so a single Sync All refreshes several datasets together.
- Use with Leaflet Views to map every node a query maintains.
