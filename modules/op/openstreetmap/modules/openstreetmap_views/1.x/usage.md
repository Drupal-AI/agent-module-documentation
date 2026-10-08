A near-empty submodule of OpenStreetMap whose only role is to declare a dependency on Leaflet so OSM Node geodata can be mapped through Views.

---

OpenStreetMap Views Integration ships no PHP, config, templates, or plugins of its own — it consists solely of an `openstreetmap_views.info.yml` that depends on the parent `openstreetmap` module and on the contrib `leaflet` module. Enabling it guarantees Leaflet (and thus its Leaflet Views display/style plugins) is present so you can build a View of `osm_node` entities, add the `geodata` Geofield, and render the results on a Leaflet map. All actual mapping behavior comes from Leaflet and core Views; this submodule is effectively a convenience/dependency shim. The parent stores the geometry — this module just ensures a mapping stack is available to display it.

---

- Ensure the Leaflet module is enabled alongside OpenStreetMap for mapping OSM Nodes.
- Build a View of `osm_node` entities and display them on a Leaflet map.
- Add the `geodata` Geofield to a View and point a Leaflet map display at it.
- Provide a one-step way to pull the mapping dependency into a site profile or install list.
- Map all OSM Nodes that a saved Overpass query maintains.
- Create a points-of-interest map page from synced OpenStreetMap data.
- Combine with Views filters/arguments to map a subset of OSM Nodes (by bundle, region, tag field).
- Render both node points and way polygons stored in the Geofield on the same map.
- Keep the mapping layer (Leaflet) decoupled from the sync/import layer (parent module).
- Use as documentation of the intended display stack when handing a site to another team.
