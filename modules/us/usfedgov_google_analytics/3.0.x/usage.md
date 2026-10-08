<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Digital Analytics Program (usfedgov_google_analytics) attaches the US GSA Digital Analytics Program (DAP) tracking script to a site's public pages, with the agency identifier and tracking options set as configuration.

---

The module injects the federal government's shared **DAP "Universal Federated Analytics"** JavaScript, which executive-branch public-facing sites are expected to run under OMB policy so their traffic reports into the government-wide analytics account (a subset of which is published on analytics.usa.gov). It is a thin, configuration-driven wrapper: `hook_page_attachments` (`src/Hook/PageAttachments.php`) attaches one of the module's asset libraries, and `hook_js_alter` (`src/Hook/JsUrlQueryBuilder.php`) appends the configured DAP options to the script URL as a query string. The script is served **from the DAP CDN by default** (`https://dap.digitalgov.gov/Universal-Federated-Analytics-Min.js`, `id="_fed_an_ua_tag"`, `async`), or from local copies bundled with the module (versions 8.0.0, 8.5.0, 8.6.0, minified or not) chosen on the settings form. The script is **only attached when**: tracking is enabled (`status`), an **Agency is configured** (the one required field), the visitor is **anonymous** (authenticated users are never tracked), the route is not `user.login`/`user.logout`/`user.pass`, and the page is **not an admin route**. All settings live in the single config object `usfedgov_google_analytics.settings` (schema in `config/schema/`), edited at `/admin/config/services/dap` behind the `administer federal google analytics` permission, and a status-report warning fires while the agency is still blank. Options cover: agency/subagency, site topic and platform (defaults to `Drupal`), extra search parameters (`sp`), download tracking with extra extensions (`autotracker`/`exts`), YouTube and HTML5 video tracking with milestone percentages (`yt`/`htmlvideo`/`ytm`), sub-domain linking (`sdor`), cookie expiration (`cto`), a development/test mode (`dapdev`), and **parallel Google Analytics 4** reporting to your own GA4 Measurement ID (`pga4`) with configurable custom-dimension slots. Values are emitted through `UrlHelper::buildQuery` (URL-encoded) and booleans are rewritten to the literal `true`/`false` strings DAP expects; only non-default, non-empty values are sent. The settings form clears the library-discovery cache on save because the query string is baked into the asset library at build time, and the attach adds a `config:usfedgov_google_analytics.settings` cache tag so cached pages update when settings change.

---

- Meet the federal DAP analytics mandate for a .gov site.
- Add the government-wide DAP tracking script to public pages.
- Set the agency identifier that DAP requires (e.g. DHS).
- Set a sub-agency identifier (e.g. FEMA) under a parent agency.
- Report traffic into the shared federal analytics account / analytics.usa.gov.
- Serve the DAP script from the official CDN with no local files.
- Pin a specific bundled DAP version (8.0.0 / 8.5.0 / 8.6.0), minified or not, for offline or air-gapped hosting.
- Track file downloads and add extra tracked file extensions.
- Track YouTube video engagement at 10/20/25% milestones.
- Track HTML5 media playback (DAP 8.3.0+).
- Tag the site's topic (e.g. health, travel) for cross-site DAP trends.
- Tag the site platform (defaults to Drupal) for DAP reporting.
- Add extra query-parameter names to DAP's search tracking.
- Link sub-domains as one site for analytics (`sdor`).
- Set the analytics cookie expiration in months.
- Run a parallel Google Analytics 4 property alongside DAP using your own Measurement ID.
- Map DAP custom dimensions to specific GA4 dimension slots for the parallel tracker.
- Route traffic to the DAP TEST/DEV environment while validating a launch.
- Exclude authenticated users, login/logout/password pages, and admin routes from tracking (built-in, no config needed).
- Manage the DAP snippet as Drupal configuration instead of a hard-coded theme edit.
- Get a status-report warning when the required agency value is missing.
- Restrict who can change analytics settings via the `administer federal google analytics` permission.
