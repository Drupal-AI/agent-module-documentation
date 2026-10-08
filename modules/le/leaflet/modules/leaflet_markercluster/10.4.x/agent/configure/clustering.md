# Enable marker clustering

Enable the `leaflet_markercluster` module, then turn clustering on in a Leaflet map's settings.

- **Where:** a **Leaflet Markercluster** option appears in the Leaflet field **formatter** and
  **widget** settings, and in **Leaflet Views** map style settings (all provided by the base
  Leaflet module — this submodule just supplies the JS + option).
- **Options:** you can pass raw Leaflet.markercluster options as **JSON** (e.g.
  `maxClusterRadius`, `spiderfyOnMaxZoom`, `showCoverageOnHover`, `zoomToBoundsOnClick`), plus an
  include-path toggle. These are read in `leaflet_markercluster.drupal.js` as
  `map_settings.leaflet_markercluster.options`.

## How it works
The JS library `leaflet-markercluster` (Leaflet.markercluster 1.5.3) + CSS are declared in
`leaflet_markercluster.libraries.yml`. `leaflet_markercluster.drupal.js` overrides
`Drupal.Leaflet.prototype.add_features` to place features into an `L.MarkerClusterGroup`
(constructed with your JSON options) instead of plain layer groups. There is no server-side
configuration schema — everything is driven by the base Leaflet map settings.
