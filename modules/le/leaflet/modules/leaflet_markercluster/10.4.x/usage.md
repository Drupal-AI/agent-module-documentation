Leaflet Markercluster bundles the Leaflet.markercluster JavaScript library and adds an option to Leaflet maps that groups nearby markers into expandable clusters.

---

On maps with many points, individual markers overlap and become unreadable. This Leaflet submodule integrates the Leaflet.markercluster plugin so that dense markers are collapsed into numbered cluster bubbles that split apart as the user zooms in or clicks. It is almost entirely a front-end integration: it ships the markercluster JS/CSS libraries and a `leaflet_markercluster.drupal.js` that overrides the base Leaflet module's `add_features` behavior to build a `L.MarkerClusterGroup` instead of plain feature layers, honoring cluster options passed in the map settings. Once enabled, a Markercluster option appears in Leaflet formatter/widget and Leaflet Views map settings, where you can toggle clustering and provide raw cluster options (as JSON) such as spiderfy, max cluster radius, and coverage-on-hover. It has no PHP configuration of its own and depends only on the Leaflet module.

---

- Cluster hundreds of markers into readable groups on a map.
- Show a numbered bubble representing how many markers are in an area.
- Expand clusters automatically as the user zooms in.
- Spiderfy overlapping markers at the same location on click.
- Keep a store-locator map legible with many locations.
- Cluster the results of a Leaflet Views map.
- Improve performance/readability of dense point data.
- Pass custom cluster options (max radius, spiderfy) as JSON.
- Toggle clustering on or off per map/formatter.
- Show coverage area of a cluster on hover.
- Cluster event locations across a country.
- Group real-estate listings by neighborhood at low zoom.
- Reduce visual clutter on nationwide coverage maps.
- Combine clustering with custom marker icons.
- Cluster sensor or asset locations on an operations map.
- Handle large geofield datasets without overwhelming the map.
- Provide a cleaner mobile map experience with clustered points.
- Cluster user-submitted locations on a community map.
- Apply clustering to polygon/point mixed feature sets.
- Zoom-to-bounds when a cluster is clicked.
- Style clusters with the default Markercluster CSS.
- Add clustering to an existing Leaflet map with no code.
