<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Recording & count endpoints

Source: `src/Controller/VisitController.php`, `entity_metrics.routing.yml`, `entity_metrics.module`, `entity_metrics.install`, `js/record.js`, `js/view.js`, `entity_metrics.libraries.yml`.

## Routes (both require `_permission: access content`)
- `entity_metrics.write_data` — POST `/entity-metrics/visit` → `VisitController::recordVisit`.
- `entity_metrics.view` — GET `/entity-metrics/{type}/{id}` → `VisitController::getVisits`. Route requirements pin `type: node|media` and `id: [1-9][0-9]{0,9}`.

## VisitController
Constructed from `session_manager`, `database`, `datetime.time`, `config.factory`, `entity_type.manager`.

- `requireViewableEntity($type, $id)` — fails closed: rejects any type other than `node`/`media`, non-numeric or oversized ids (`> 4294967295`), unknown entity types, and entities that fail `$entity->access('view', currentUser())` (throws `BadRequestHttpException`/`NotFoundHttpException`).
- `recordVisit(Request)` — reads POST `currentPath`, requires it match `node/<positive int>`, calls `requireViewableEntity('node', id)`, validates the client IP with `filter_var(..., FILTER_VALIDATE_IP)`, then `checkFlood($ip)`. On success inserts a row into `entity_metrics_data` (`entity_type=node`, `entity_id`, `session_id`, `timestamp`, `ip_address`, `cookie_set`). `cookie_set` is 1 only when the configured `cookie` name is present with value `'1'`. Returns `200`/`400`/`429`, all `Cache-Control: no-store`.
- `getVisits($type, $id)` — after `requireViewableEntity`, selects from `entity_metrics_data` filtered `entity_type`, `entity_id`, `cookie_set = 0`; returns JSON `{total, monthly}` where `monthly` counts the last 30 days (`timestamp > now - 2592000`). Counts are returned only for an entity the caller can view.
- `checkFlood($ip)` — true when the IP has `>= 20` events (`FLOOD_EVENT_LIMIT`) in the last `60`s (`FLOOD_EVENT_WINDOW_SECONDS`).

## JavaScript
- Library `entity_metrics/record` (`js/record.js`) — attached by `entity_metrics_preprocess_node()` only on `entity.node.canonical`; POSTs `currentPath` to `/entity-metrics/visit`.
- Library `entity_metrics/view` (`js/view.js`) — used by the Node History block; splits the current path into `{type}/{id}`, GETs `/entity-metrics/{type}/{id}`, and writes `response.monthly`/`response.total` into the block via `.text()` (hides `.block-entity-metrics` when total is 0).

## Media downloads
`entity_metrics_file_download($uri)` records a `media` event when the URI scheme is `fedora`: it skips internal IPs (first octet `127`/`172`/`192`), resolves the media id from the `file_managed`/`media__field_media_*` tables with a parameterized query, and inserts an `entity_metrics_data` row. Always returns `NULL` (never alters the download access decision).

## Storage (`entity_metrics.install`)
- `entity_metrics_data` — `id`, `entity_type`, `entity_id`, `timestamp`, `session_id`, `ip_address`, `region_id`, `geolocation_status` (0 pending / 1 located / 2 unknown), `cookie_set`; indexes on entity, timestamp, `geolocation_pending`, `ip_timestamp`.
- `entity_metrics_regions` — de-duplicated locations (see [geolocation.md](geolocation.md)).
- `hook_uninstall` drops both tables. Updates: `10001` adds `cookie_set`; `10002` adds `geolocation_status` + indexes, adds `location_key` unique key to regions, and seeds the geolocation config defaults.
