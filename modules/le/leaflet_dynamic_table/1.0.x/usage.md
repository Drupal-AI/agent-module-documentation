<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Leaflet Dynamic Table adds a Views attachment display ("Leaflet Dynamic Attachment") that stays in sync with a Leaflet map: as the user pans and zooms, an AJAX request re-renders the table to show only the entities whose markers are currently inside the map viewport.

---

It extends the Leaflet Views module. The custom display plugin (`LeafletDynamicAttachment`, extending core's `Attachment`) forces the None pager and inherits the parent map's arguments and exposed filters so the initial render matches the map's data set, then replaces the pager with infinite scroll. Client JavaScript binds to the map's zoom/move events, collects the entity IDs of visible markers and POSTs them to `/leaflet-dynamic-table/update`. On a viewport change (page 0) the controller executes the view filtered to those IDs, caches the ordered ID list plus total in a `PrivateTempStore` under a random 24-hex cache key, and returns the first page; subsequent infinite-scroll pages reuse the cache key with DB-level LIMIT/OFFSET. Clicking a marker highlights the matching table row, auto-loading more pages if needed.

The AJAX endpoint is written defensively. It is `POST`-only and rejects non-XHR requests; `view_id` and `display_id` are validated with a strict `^[a-z0-9_]+$` regex; the `cache_key` must match `^[a-zA-Z0-9]{1,32}$`; incoming entity IDs are cast to integers (`intval`/`is_numeric`) and capped at 10,000; `items_per_page` is read from the server-side display config (5–200, ignoring any client value); and crucially it calls `$view->access($display_id)` and throws `AccessDenied` before rendering, so the view's own access rules are enforced. The route requirement is the coarse `access content`, but real authorization is the per-view access check, and the cached tempstore is per-session and re-validated against the requested view/display. No injection or access-bypass issues were observed. Setup: add a Leaflet Map display to a geo View, add a Leaflet Dynamic Attachment, point it at the map display, and tune items-per-page, debounce and highlight colour.

---

- Attach a data table that follows a Leaflet map's viewport
- Show only the entities whose markers are currently visible on the map
- Update the table via AJAX as the user pans the map
- Update the table via AJAX as the user zooms the map
- Load results progressively with infinite scroll
- Configure items-per-page for the infinite scroll (5–200)
- Set a debounce delay to avoid excessive AJAX requests
- Highlight the matching table row when a map marker is clicked
- Configure the marker-click highlight colour
- Show a live item count with an `@showing`/`@total` message template
- Choose whether updates trigger on zoom, pan, or both
- Inherit the parent map view's arguments and exposed filters
- Format the attachment as a table, unformatted list, etc.
- Rely on per-view access enforcement (`$view->access()`) for the AJAX endpoint
- Work with any entity type that has geographic coordinates
- Replace the parent view's pager with viewport-driven infinite scroll
