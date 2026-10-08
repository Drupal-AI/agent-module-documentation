<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LocalGov Directories Location adds geography to directory entries: a LocalGov Geo location field, a Search API location index datatype, a Leaflet map display on channels and a "near me" proximity search with a configurable radius.

---

This submodule is the bridge between LocalGov Directories and the geo stack. It installs `field.storage.node.localgov_location` (the geo entity reference used by venue and organisation entries) and `field.storage.node.localgov_proximity_search_cfg`, the per-channel proximity configuration. `hook_field_config_insert()` watches for the location field being added to a bundle and, through `ProximitySearchSetup`, wires the pieces up: the Search API index gains the location datatype field (`localgov_location_wkt`), the channel view gets its proximity-search and map displays enabled, and the proximity facet config from the parent module's `config/conditional/` directory is applied. `hook_search_api_index_update()` keeps that in step when the index changes, and a `SearchApiSubscriber` handles indexing-time concerns. `LocationExtraFieldDisplay` adds pseudo-fields so an entry's location renders on the node without display configuration. Config overrides in `config/override/` adjust the parent module's channel view and the directory form display for the location-enabled case. Dependencies are heavy but purposeful: `localgov_geo_address` for the geo entity, `leaflet_views` for the map, `search_api_location_views` and `search_api_location_geocoder` for distance filtering and address-to-coordinate lookup, and `inline_entity_form` so editors enter a location without leaving the entry form.

---

- Let visitors search a directory for entries near a postcode.
- Show all entries in a channel on an interactive Leaflet map.
- Set a default search radius per directory channel.
- Geocode addresses entered by editors automatically.
- Let editors enter a location inline on the entry form.
- Index coordinates so distance sorting works in Search API.
- Combine proximity filtering with ordinary facets.
- Display an entry's location on the entry page itself.
- Support "find your nearest library" style journeys.
- Provide map-based browsing as an alternative to list browsing.
- Keep geo data in LocalGov Geo entities rather than plain fields.
- Reuse one location record across several entries.
- Add proximity search to an existing directory without rebuilding it.
- Configure which channels offer proximity search and which do not.
- Show distance from the searched point in results.
- Support rural areas with a wider default radius.
- Cluster nearby markers on busy maps.
- Keep the map and list views in sync from one Search API query.
- Migrate address-only entries to geocoded ones.
- Give venues and organisations the same location behaviour.
