<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Random 404 page (random_404_page) — agent index

**Serves a randomly selected page from an admin-defined list whenever a 404 or 403 is raised.**

- **Version:** 1.0.x (info.yml: 1.0.0-alpha4)
- **Core:** `^9 || ^10 || ^11`
- **Config object:** `random_404_page.settings` (keys `404_pages`, `403_pages` — arrays of paths)
- **UI:** alters `system_site_information_settings` form; no dedicated route or permission (reuses core *administer site configuration*)
- **Service:** `random_404_page.subscriber` — `ErrorPageEventSubscriber` extends core `CustomPageExceptionHtmlSubscriber`, `on404()`/`on403()` pick a random path (`array_rand`) and call the inherited access-checked `makeSubrequestToCustomPath()`.
- **Security:** Paths are admin-entered and validated with the core path validator at save; the runtime sub-request uses core's own access-checked custom-page mechanism, so no unpublished/restricted node is exposed to anonymous users beyond what core's single custom 404 would already allow. No anonymous or mutating endpoints.

See [configure/error-pages.md](configure/error-pages.md)
