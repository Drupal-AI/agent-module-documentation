<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Page View Counter shows how many times a page has been viewed and keeps that number updating in near real time. It counts views through a small JSON API hit from the client and de-duplicates repeat views per visitor using cookies, then displays the total through a counter block.

---

The front-end pings `/api/pvc/v1/view` (route `page_view_counter.api`, gated by `access content`); `PageViewCounterController::fetch()` reads the visitor's cookies and a route/id query key, delegates to the `page_view_counter.cookie_service` (`PVCCookieService`) to decide whether to increment, and returns a short-cached `CacheableJsonResponse` with the current count while setting a per-page cookie. Counts and per-counter configuration are modelled as a `page_view_counter_entity` config/content entity (with list builder, entity form, and a `CounterBlock` block plugin). Admin settings live at `/admin/structure/page-view-counter-entity` (route `entity.page_view_counter_entity.settings`) behind the restricted `administer page_view_counter_entity` permission. It depends on core `block`, `field`, and `link`.

---

- Show a live "X views" counter on articles or product pages.
- Track content popularity without a heavyweight analytics integration.
- De-duplicate repeat views from the same visitor using cookies.
- Update the displayed count in near real time via the JSON endpoint.
- Place the counter anywhere using the Counter block.
- Cache counter responses briefly to limit load while staying fresh.
- Identify your most-viewed pages for editorial or merchandising decisions.
- Restrict counter administration to trusted roles (restricted permission).
- Configure counter entities/behaviour from a dedicated settings screen.
- Display social-proof view counts to encourage engagement.
- Keep counting server-light by using a tiny API call instead of full page logging.
- Expose counts to anonymous visitors (endpoint uses `access content`).
- Model multiple counters as entities with their own settings.
- Add view counts to a listing via the block plugin.
- Avoid third-party trackers for a simple view metric.
- Surface trending content by comparing counter values.
