<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Leaflet Dynamic Table (leaflet_dynamic_table) — agent index

**A Views attachment display that syncs a table to a Leaflet map viewport, re-rendering via AJAX as the user pans/zooms, with infinite scroll.**

- **Version:** 1.0.x  ·  **Core:** ^10.3 || ^11 || ^12  ·  **Package:** Views
- **Depends on:** views, leaflet, leaflet_views.
- **Display plugin:** `leaflet_dynamic_attachment` (`LeafletDynamicAttachment` extends core `Attachment`) — forces None pager, inherits parent args/exposed filters, options for update-on-zoom/pan, debounce, items-per-page (5–200), show count, highlight colour.
- **Route:** `leaflet_dynamic_table.update` → `/leaflet-dynamic-table/update`, POST, `no_cache`, `_permission: access content`.
- **Controller:** `LeafletDynamicTableController::update` — viewport-change vs scroll handlers; caches entity IDs in `PrivateTempStore`.
- **Query hook:** entity-ID filtering applied via `hook_views_query_alter` using static per-request storage.

**Security:** the `access content` route is defended in code — POST/XHR-only; `view_id`/`display_id`/`cache_key` regex-validated; entity IDs `intval`-cast and capped at 10k; `items_per_page` taken from server config; and it calls `$view->access($display_id)` (throws AccessDenied) before rendering, so per-view access is enforced. Cache is per-session and re-validated against the requested view/display. No injection or bypass observed.

See [configure/attachment.md](configure/attachment.md).