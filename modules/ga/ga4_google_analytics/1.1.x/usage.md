<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
GA4 Google Analytics injects the Google Analytics 4 `gtag.js` tracking snippet into your site's pages using a single Measurement ID, with optional per-role and per-page visibility controls.

---

The module is a lightweight, dependency-free tracker. You enter a GA4 Measurement ID (the `G-XXXXXXXXXX` value) on one settings form, and `hook_page_attachments()` then adds the standard `gtag.js` `<script>` tags to the `<head>` of every rendered page via a theme template. It reuses core's `request_path` condition plugin so you can list paths (with `*` wildcards and `<front>`) and choose whether to track *only* those pages or *all pages except* those. A role checkbox list limits tracking to visitors holding at least one selected role (empty = all users). A free-text "Scripts Custom Attributes" field lets you add a strict allow-list of attributes (`async`, `type="…"`, `data-*="…"`, `crossorigin="anonymous"`) to the injected script tags — the field is validated and `Xss::filter()`ed, primarily so a cookie-consent manager such as Klaro can defer the script until the user consents. All settings live in the simple config object `ga4_google_analytics.config`; there is no `config/install` default, so the object does not exist until you save the form once. The module defines no field types, plugins, services, or Drush commands.

---

- Add GA4 pageview tracking to a Drupal site by pasting in a single `G-` Measurement ID.
- Inject the standard `gtag.js` snippet site-wide without writing any theme code.
- Exclude admin pages from analytics by negating tracking for `/admin/*` and `/user/*`.
- Track only a marketing landing section by listing `/campaign/*` and choosing "track listed pages".
- Track the front page only by listing `<front>` as the single path.
- Stop tracking authenticated staff by limiting tracking to the "anonymous"-only case (leave roles empty and exclude internal paths).
- Restrict analytics to visitors with a specific role (e.g. only track users in a "customer" role).
- Defer GA4 loading until cookie consent by adding Klaro attributes (`type="text/plain" data-name="ga"`) in the custom-attributes field.
- Comply with GDPR by combining the module with a consent manager that blocks the tagged script.
- Add `crossorigin="anonymous"` to the analytics script tag for stricter CORS handling.
- Roll out GA4 across a multi-site by exporting `ga4_google_analytics.config` and deploying it.
- Switch a site from Universal Analytics to GA4 by entering the new `G-` Measurement ID.
- Grant a marketing role permission to manage the tracking ID via the `ga4 configre` permission.
- Preview tracking scope changes safely because settings are validated before save.
- Keep the tracking snippet out of specific node edit forms by negating `/node/*/edit`.
- Ensure the Measurement ID is sanitized before output (the module runs it through `Xss::filter()`).
- Track a members-only area by selecting the member role and listing the members path.
- Provide analytics on all pages for all users with the zero-configuration default (just enter the ID).
- Add HTML5 `data-*` attributes required by a tag-management or consent tool to the script tags.
- Manage tracking configuration through code/config-sync rather than the UI for CI deployments.
- Temporarily disable tracking site-wide by clearing the Measurement ID field.
- Give editors a friendly settings page at Configuration » Web services » GA4 Google Analytics.
- Combine page and role conditions so only logged-in customers on `/shop/*` are tracked.
- Audit which roles/pages are currently tracked by reading the `ga4_google_analytics.config` object.
