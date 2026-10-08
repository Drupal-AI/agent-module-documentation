Cesium integrates the self-hosted CesiumJS 3D globe library with Drupal, rendering geofield point data as interactive 3D globes via a field formatter and a Views map style.

---

The Cesium module bridges Drupal's Geofield module and the CesiumJS JavaScript library (served locally from `/libraries/cesium`, installed through the `npm-asset/cesium` Asset Packagist package). It ships two display integrations: a "Cesium Globe" field formatter (`cesium_geofield_formatter`) that renders a single geofield item as an interactive 3D globe that flies the camera to the stored point, and a "Cesium 3D Map" Views style (`cesium_map`) that plots every result row's geofield on one shared globe with optional title/description infoboxes. A site-wide settings form at `/admin/config/services/cesium` chooses the minified (production) or unminified (development) library build, stores a Cesium Ion access token, and toggles Cesium World Terrain and global OSM 3D Buildings. All globe rendering happens client-side in `js/cesium_formatter.js`; the module supplies coordinates, the Ion token and feature flags to the browser through `drupalSettings`.

---

- Render a Geofield POINT on a node display as an interactive, spinnable 3D globe.
- Add a location map to an Article, Event or Place content type without writing JavaScript.
- Fly the camera automatically to a stored coordinate at a configurable zoom altitude (meters).
- Display store locations, offices, or points of interest from a Views listing on a single 3D globe.
- Build a "map of all events" page using a Views "Cesium 3D Map" style over a geofield.
- Show hover/click infoboxes on Views map markers using a chosen title field and description field.
- Auto-fit the Views map camera so all result markers are visible at once.
- Present WKT geospatial data (`POINT (lon lat)`) stored in Geofield as a visual globe rather than raw text.
- Support raw latitude/longitude pairs as well as WKT input from Geofield.
- Turn on high-resolution Cesium World Terrain for elevation-accurate 3D landscapes.
- Overlay global OSM 3D Buildings to give city-scale context to a location.
- Use a Cesium Ion access token to remove the default watermark and unlock Ion-hosted imagery/terrain.
- Switch between production (minified) and development (unminified) CesiumJS builds per environment.
- Self-host the entire CesiumJS runtime (no CDN dependency) for offline, air-gapped, or privacy-conscious sites.
- Set map width and height (e.g. `100%`, `800px`, `80vh`) per Views display or a zoom altitude per formatter.
- Give editors a globe with built-in geocoder search, base-layer picker, home button, scene-mode toggle and fullscreen controls.
- Visualize geotagged content (photos, reports, sensor readings) alongside its coordinates.
- Provide a portfolio/travel map of visited places driven by a taxonomy or content listing.
- Combine with PostGIS-backed Geofield storage for large spatial datasets.
- Embed the globe inside any entity view mode (teaser, full, custom) via Manage display.
- Attach the CesiumJS library to your own custom render arrays via the `cesium/cesium` library.
