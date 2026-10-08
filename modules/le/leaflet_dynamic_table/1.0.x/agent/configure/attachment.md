<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring a Leaflet Dynamic Attachment

1. Build a View of entities with geo coordinates; add a **Leaflet Map**
   display (from Leaflet Views).
2. Add a new display of type **Leaflet Dynamic Attachment**.
3. In its settings:
   - **Attach to** — the Leaflet map display(s) it should follow.
   - **Update on zoom / pan** (defaults on), **Debounce delay** ms (default 300).
   - **Items per page** for infinite scroll (default 25, clamped 5–200 server-side).
   - **Show item count** + count message template (`@showing`, `@total` tokens).
   - **Marker highlight colour** (default `#ffeb3b`).
4. Configure the attachment's own format (Table, etc.) and fields.

**Runtime flow:** JS binds to the map's zoom/move events, gathers visible
marker entity IDs and POSTs them to `/leaflet-dynamic-table/update`. Page 0
executes the filtered view, caches `{view_id, display_id, entity_ids,
total_count}` in a `PrivateTempStore` under a random 24-hex key and returns page
0; scroll requests (page > 0) send only the cache key and paginate with
DB-level LIMIT/OFFSET.

**Access:** the controller enforces `$view->access($display_id)` before
rendering, so the attachment respects the underlying View's access. Requests
must be XHR POST; malformed ids/keys are rejected.

**Limitation:** a single shared JS state means only one dynamic-attachment map
per page is supported.
