<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Leaflet More Maps adds 40+ ready-made tile-layer map styles (Bing, Esri, Google, Mapbox, Mapy.cz, OSM/Thunderforest, OpenTopoMap, Stamen, HERE, Navionics) to the Leaflet module, selectable anywhere Leaflet offers a map-style dropdown.

---

The module implements Leaflet's `hook_leaflet_map_info()` to register a large catalog of named tile-layer definitions (e.g. `bing`, `esri-world_imagery`, `mapbox-streets`, `osm-cycle`, `stamen-watercolor`, `here-base`, `navionics`) that appear alongside Leaflet's own OSM Mapnik style wherever a site picks a map style — a Geofield/date field formatted as a Leaflet map, or a View rendered with the Leaflet Views style. A settings form at `/admin/config/system/leaflet-more-maps` (route `leaflet_more_maps.settings`, stored in `leaflet_more_maps.settings` config, created on first save since the module ships no default config) collects the API keys/access tokens some providers require (Thunderforest, HERE, Mapbox, Mapy.cz, Navionics) and threads them into the corresponding tile URL templates. The same form also assembles up to three "custom maps" by combining individual layers from the built-in catalog into a single map with an automatic layer switcher, stored as `leaflet_more_maps_custom_maps` in that same config. A `hook_leaflet_more_maps_list_alter()` hook (declared in `leaflet_more_maps.api.php`) lets other modules add or change entries in the catalog before it is offered to users, and `leaflet_more_maps_leaflet_map_info_alter()` keeps the whole list sorted alphabetically. A small JS override (`leaflet_more_maps.js`) adds two Leaflet layer types the core module doesn't handle: Bing's quadtree tile addressing and Google's high-DPI/retina tiles. The module requires the `leaflet` module and has no permissions, plugins, Drush commands, or config schema of its own; the companion `leaflet_demo` submodule provides a one-page showcase of every map the catalog currently returns.

---

- Add Bing road, satellite, and hybrid tile layers to a Leaflet map field.
- Add any of Esri's World Imagery, National Geographic, Physical, Ocean, Topo, or Street basemaps.
- Add Google hybrid, satellite, roadmap, or high-res (retina) roadmap+terrain layers to a Leaflet map.
- Add OpenStreetMap.de's GDPR-friendly OSM tiles without needing an API key.
- Add any of nine Thunderforest OSM styles (Cycle, Transport, Landscape, Outdoors, Transport Dark, Spinal Map, Pioneer, Mobile Atlas, Neighbourhood).
- Add OpenTopoMap contour/terrain tiles.
- Add any of eleven Stamen map styles served via Stadia Maps (Terrain variants, Toner variants, Watercolor).
- Enter a Thunderforest API key so Thunderforest tiles stop showing the "missing key" watermark.
- Enter a HERE API key so HERE Base maps actually load (blank without one).
- Enter a Mapbox access token to replace the module's bundled demo token with your own account's tiles.
- Enter a Mapy.cz API key to use Basic, Outdoor, Winter, or Aerial Mapy.cz styles.
- Enter a Navionics API key plus an authorized domain to enable nautical, sonar, and ski overlay layers.
- Assemble a custom combined map (e.g. an Esri Imagery base layer plus an OSM label overlay) with an automatic layer switcher, without writing code.
- Reverse the order of layers in a custom map's layer switcher so a different layer is the default.
- Offer editors a curated subset of the 40+ map styles instead of the full catalog, via a custom map.
- Let a Geofield-formatted location field render as satellite imagery instead of the default OSM Mapnik style.
- Format a View of location-bearing nodes with an Esri or Stamen basemap via Leaflet Views.
- Implement `hook_leaflet_more_maps_list_alter()` in a custom module to add an in-house tile provider to the catalog.
- Implement `hook_leaflet_more_maps_list_alter()` to remove or relabel map styles a site doesn't want offered.
- Verify a newly entered API key actually works by visiting the Leaflet Demo showcase page.
- Standardize on a consistent basemap style (e.g. Esri World Imagery) across every Leaflet-rendered field on a site.
- Give an internal/GIS-heavy site access to professional-grade basemaps (Esri, HERE) without custom code.
- Offer a dark-mode-friendly basemap (Mapbox Dark, CartoDB dark via a custom alter, Stamen Toner) for a dark theme.
- Swap between Toner (high-contrast, print-friendly) and Watercolor (illustrative) Stamen styles for different map views.
- Provide marine/nautical chart layers (Navionics) for a boating or coastal-tourism site.
- Support both HTTP and HTTPS deployments via the module's protocol-relative tile URLs (Navionics/HERE force HTTPS).
- Add retina/high-DPI tile support automatically for Google layers on high-density displays.
