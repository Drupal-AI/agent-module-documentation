<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# page view counter — agent index

Real-time page-view counter: client pings a JSON endpoint, cookies de-dupe per visitor, a block
displays the total. Depends on `block`, `field`, `link`.

Quick facts:
- API: `GET /api/pvc/v1/view` (route `page_view_counter.api`, perm `access content`) → `PageViewCounterController::fetch()`; short-cached `CacheableJsonResponse`, sets a per-page cookie.
- Logic: `page_view_counter.cookie_service` (`PVCCookieService`) decides increment; `PageViewCounterManager` holds cookie/query keys.
- Entity: `page_view_counter_entity` with list builder + `CounterBlock` block.
- Admin: `/admin/structure/page-view-counter-entity` (perm `administer page_view_counter_entity`, restricted).
