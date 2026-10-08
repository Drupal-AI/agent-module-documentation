<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cookies Addons Views withholds a Views display until the visitor consents to a configured COOKiES service, replacing it with a placeholder overlay and AJAX-loading the view on consent.

---

A submodule of Cookies Addons requiring core Views. `cookies_addons_views_preprocess_views_view()` checks whether the current view id + display id are listed in `cookies_addons_views.settings:views` (one `view_id|display_id|service` per line); `_cookies_addons_views_is_restricted()` also reads the raw `cookiesjsr` request cookie server-side and returns FALSE (no gating) if the service is already accepted there. When gated it replaces the view's `rows` with a `<div class="cookies-addons-views-placeholder" cookies-service view-id display-id data-args>` placeholder and attaches the `cookies_addons_views/cookies-addons-views` JS library; `hook_views_pre_render()` also strips the view's `drupalSettings` and any `viewsreference` marker to avoid duplicate-settings issues. On consent the behavior GETs `/cookies-addons-views/get-view/{view_id}/{display_id}/{service}/{arguments}`, whose `CookiesAddonsViewsController::getView()` renders a `#type => view` element (with the placeholder's args as a contextual filter) and AJAX-replaces the placeholder; for the `leaflet` service it also attaches the Leaflet libraries. Configure at `/admin/config/system/cookies-addons-views`.

---

- Defer loading of a map, feed or external-data view until consent.
- Gate a specific view display by listing `view_id|display_id|service` lines in the settings form.
- Pass through a contextual-filter argument to the gated view when it loads on consent.
- Auto-attach the Leaflet libraries when a gated `leaflet` view is loaded.
- Skip gating automatically when the visitor's `cookiesjsr` cookie already records consent for the service.
- Show a consent placeholder with the service label where the view would render.
- Strip the view's duplicate `drupalSettings`/`viewsreference` markers to avoid JS conflicts while gated.
- Map each gated view display to any existing COOKiES `cookies_service` entity.
- Keep a tracking/embedding view off the initial page load for GDPR/ePrivacy compliance.
- Deploy view gating as config (`cookies_addons_views.settings`).
- Combine with the blocks/paragraphs/fields submodules for full-site consent gating.
