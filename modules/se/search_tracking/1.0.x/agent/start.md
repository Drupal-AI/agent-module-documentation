<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search Tracking (search_tracking) — agent index

**Logs visitor search keywords (+ client IP) via JS posting to an open API endpoint.**

- **Version:** 1.0.x
- **Core:** ^8 || ^9 || ^10
- **Configure:** `/admin/config/search/search-tracking/form-config` (role `administrator`)
- **Package:** Search

**Surface:** `POST /api/form-data` → `searchTrackingController::formData` (inserts search+IP+time); config form `SearchTrackingConfig`; `js/formData.js` captures the search field; `search_tracking` DB table.

**Endpoint:** `/api/form-data` has route requirement `_permission: access content`. Insert is parameterized; values capped 100 chars. Results-render method is not routed (commented out). See `search_tracking.routing.yml` + `src/Controller/searchTrackingController.php`.
