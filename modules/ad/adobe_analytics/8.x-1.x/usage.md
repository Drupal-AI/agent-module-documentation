<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds the Adobe Analytics (formerly Omniture SiteCatalyst) AppMeasurement tracking script and its variable payload to your site's pages.

---

Adobe Analytics injects the Adobe Analytics / AppMeasurement JavaScript at the bottom of every non-administration page, so page views and custom events are recorded in Adobe Analytics. You configure the tracking JS file URL, a reporting version string, an optional no-JavaScript tracking image, role-based tracking rules, a list of custom tracking variables (props/eVars) whose values support Drupal tokens, and a free-form custom JavaScript snippet — all at `/admin/config/search/adobeanalytics`. Tokens in variable values and the snippet are replaced per request. Tracking can be limited by user role (inclusive or exclusive) and is automatically skipped on admin pages. Other modules add variables through `hook_adobe_analytics_variables()`, and a per-entity override is available by attaching the module's `adobe_analytics` field type to a content type or other bundle. Because it loads a third-party analytics script that collects visitor data and sends it to Adobe, disclose it in your privacy policy and integrate with consent tooling where GDPR or similar rules apply.

---

- Add Adobe Analytics (AppMeasurement) tracking to a Drupal 10/11 site.
- Point the site at your hosted AppMeasurement/`s_code` JavaScript file.
- Record page views and events into your Adobe report suite.
- Set the Adobe Analytics version string used for debugging.
- Provide a `<noscript>` tracking image for visitors without JavaScript.
- Define custom tracking variables (props/eVars) in the admin UI.
- Use Drupal tokens (node, term, user, menu, global) in variable values.
- Set a prop from the current page title, path, or date via tokens.
- Add a free-form custom JavaScript snippet run on every tracked page.
- Track only selected roles (inclusive) or everyone except selected roles (exclusive).
- Exclude staff/admin roles from analytics while still tracking anonymous visitors.
- Automatically skip tracking on `/admin` pages.
- Contribute variables programmatically with `hook_adobe_analytics_variables()`.
- Group programmatic variables into header, main, and footer sections.
- Track a referring search engine or campaign value from a custom module.
- Override or extend the global tracking on a specific entity via the `adobe_analytics` field.
- Let editors turn the global variables or main snippet on/off per node.
- Add a per-entity custom snippet for landing-page-specific tracking.
- Tune token replacement caching with the token cache lifetime setting.
- Keep the tracking payload cache-aware (varies by user role).
- Migrate from the legacy SiteCatalyst/Omniture module.
- Combine with a consent/cookie module to gate analytics under GDPR.
- Disclose Adobe data collection in your site's privacy policy.
