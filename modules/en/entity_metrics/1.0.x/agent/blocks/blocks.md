<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Blocks

Source: `src/Plugin/Block/NodeHistoryBlock.php`, `src/Plugin/Block/MapBlock.php`, `js/view.js`, `js/map.js`, `css/map.css`, `entity_metrics.libraries.yml`.

Both are standard core `BlockBase` plugins (placed via Block layout / Layout Builder). The module defines no custom plugin type and no block-specific permission.

## Node History block — `entity_metrics_node_history`
`NodeHistoryBlock` (admin label "Node History block"). `build()` renders two empty containers (`#entity-metrics-monthly`, `#entity-metrics-total`) and attaches library `entity_metrics/view`. `js/view.js` derives `{type}/{id}` from the current path, GETs `/entity-metrics/{type}/{id}`, and fills the "Last month"/"Total" values with `.text()`; hides `.block-entity-metrics` when total is 0. Intended for placement on node/media canonical pages.

## Metrics Map block — `entity_metrics_map`
`MapBlock` (admin label "Metrics Map block"). Injected with `current_route_match`, `database`, `entity_type.manager`.

`build()`:
- Sets `#cache` tag `entity_metrics_regions` and renders a `<h2>Collection Views</h2>` header plus a `#map` container; attaches library `entity_metrics/map` (Leaflet 1.9.4 CSS/JS from `unpkg.com` + `js/map.js` + `css/map.css`).
- Runs a parameterized query joining `entity_metrics_data` → `entity_metrics_regions` → `node__field_member_of`, filtered to nodes whose `field_member_of_target_id` equals the current route's `node` id and which have non-NULL coordinates. **Requires a site-specific `field_member_of` entity-reference field on nodes** (collection membership); without it the query has no table to join.
- For each row, loads the node and, only when `$node->access()` passes, adds a `drupalSettings.entityMetrics` entry (`label`, `link`, `date`, `latitude`, `longitude`, `city`, `region`, `country`).

`js/map.js` builds a Leaflet map with OpenStreetMap tiles and, on an interval, pops entries off `drupalSettings.entityMetrics` to place a marker and update the header. Marker popups and the header show the node label and location.
