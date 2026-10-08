Leaflet Views adds a Views style, row, and attachment display that render any Views result set of geolocated entities as an interactive Leaflet map.

---

This Leaflet submodule integrates maps into the Views UI so site builders can map content without writing code. It provides a **Leaflet Map** Views style plugin (`leaflet_map`) that takes a view of entities with a Geofield and renders them all as markers/geometry on one map, a **Leaflet Marker** row plugin (`leaflet_marker`) that controls how each result becomes a feature (icon, popup content, view mode), and a **Leaflet Attachment** display (`leaflet_attachment`) for attaching a map to another display. Popups can load entity content over AJAX through a dedicated controller/route, keeping the initial map light. A set of alter hooks lets other modules adjust the per-row feature, the whole feature collection, feature groups, and the map settings. Because it is pure Views configuration, maps built this way export and deploy as view config and can use exposed filters, contextual filters, sorts, and pagers like any other view. It requires the Leaflet and Views modules.

---

- Map all nodes of a content type that have a location field.
- Build a store or office locator as a view with a map style.
- Show event locations on a map filtered by date.
- Render search results on a map using an exposed filter.
- Attach a map display to a page/list view of the same data.
- Configure per-row marker icons based on entity fields.
- Load marker popups via AJAX to keep the map fast.
- Display view-mode-rendered entity content inside a popup.
- Map taxonomy-filtered content (e.g. all "restaurant" nodes).
- Combine a map with contextual filters for per-page maps.
- Show a user's own geolocated content on a map.
- Cluster the view's markers by adding Leaflet Markercluster.
- Fit the map bounds automatically to the view's results.
- Map results from Search API or other Views-compatible sources.
- Provide a map block from a Views block display.
- Alter each feature with `hook_leaflet_views_feature_alter()`.
- Group features and style each group differently.
- Adjust the whole map's JS settings via a Views style alter hook.
- Paginate or limit the number of mapped markers.
- Sort or filter which locations appear on the map.
- Show real-estate listings on a filterable map.
- Build a coverage/service-area map from polygon Geofields.
- Expose a map of the latest geolocated posts.
- Reuse existing views to add a map presentation with no code.
