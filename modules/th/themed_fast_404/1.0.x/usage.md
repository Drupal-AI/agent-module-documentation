<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Themed Fast 404 makes Drupal's cheap "fast 404" response look like your site: cron renders a 404 page once, saves it as a static HTML file per language, and a config override feeds that HTML into `system.performance.fast_404` so every 404 is served from it without a full bootstrap.

---

Core's fast-404 feature can return a canned HTML string for missing paths, skipping the expensive route/render pipeline — but that string is a bare unstyled snippet, so most sites turn it off and pay for a full-page 404 instead. This module closes the gap. It exposes a real Drupal route, `/page-not-found` (`themed_fast_404.page_not_found`, `_access: TRUE`), whose controller renders the configured **404 page body** with the site's theme and a `config:themed_fast_404.settings` cache tag. `hook_cron()` calls `ThemedFast404Manager::buildStatic404()`, which loops over every enabled language, fetches that page over HTTP with `file_get_contents()` (using the language-prefixed URL, or the configured **Base URL** when cron cannot determine the host), and writes the response body to `public://page-not-found-{langcode}.html` via `file.repository`. At runtime `ConfigOverrider` — a `config.factory.override` service — intercepts reads of `system.performance` and injects three values: `fast_404.html` set to the contents of the current language's static file, `fast_404.paths` set to `/\.*$/i` (i.e. **all** paths, not just asset extensions), and `fast_404.exclude_paths` set to a regex sparing `/styles/` and `/system/files/` so image derivatives and private file routes keep working normally. The settings form also lets you point at core's configured `system.site:page.404` instead of the module's own page. Everything is regenerated on cron (and on settings save), so a theme change needs a cron run — or a manual rebuild — before it shows up in 404s.

---

- Serve a branded 404 page without a full Drupal bootstrap on every missing URL.
- Cut CPU cost from bot traffic hammering non-existent paths.
- Keep core's fast-404 performance benefit without its unstyled default markup.
- Give a multilingual site a correctly translated 404 in every language.
- Absorb a traffic spike of broken inbound links cheaply.
- Reduce load caused by scanners probing for wp-admin and similar paths.
- Present a 404 that matches a redesign, regenerated automatically on cron.
- Point the static page generator at the 404 page you already configured in core.
- Customise the fallback body text used before the themed page is generated.
- Fix a wrong base URL when cron runs without a host (typical on some hosts).
- Keep image-style derivatives working while everything else gets a fast 404.
- Avoid writing a custom 404 controller and cache-warming script.
- Serve the same 404 from the CDN edge as the origin would render.
- Regenerate the static page after a content change to the 404 body.
- Lower time-to-first-byte for missing pages measurably.
- Stop 404s from filling the render cache with one-off entries.
- Keep 404 markup identical across all front-end servers.
- Provide a themed 404 on a site where the front end is heavily cached.
- Debug the generated markup by opening the static file in `public://` directly.
- Fall back to Drupal's normal 404 simply by uninstalling the module.
