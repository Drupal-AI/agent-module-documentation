<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Synapse Staff injects a Google Tag Manager container, a GA4 measurement ID, and Google/Yandex Webmaster site-verification meta tags across the site.

---

Synapse Staff (synapse) is a small site-integration module that wires a Drupal site into Google Tag Manager and search-engine webmaster tools. From a single settings form at `/admin/config/synapse/settings` it stores a GTM container ID, a GA4 measurement ID, and Google and Yandex site-verification codes. On every non-admin page it renders the standard GTM JavaScript snippet into the page bottom (via `hook_preprocess_html()`), and it emits `google-site-verification` and `yandex-verification` `<meta>` tags into the page head (via `hook_page_attachments()`). GTM output is skipped on `/admin/` paths and can optionally be disabled for user 1, so administrators do not pollute analytics while working in the back office. The module provides no entities, permissions, services, or plugins — just three hooks and one config form gated by `administer site configuration`. Despite the "Staff" name and Synapse/Synatix branding, the shipped 2.0.x code is purely tag-management and SEO verification.

---

- Add a Google Tag Manager container to a Drupal site without editing templates.
- Configure the GTM container ID (e.g. `GTM-XXXXXX`) from the admin UI.
- Store a GA4 measurement ID for use in the GTM Data Layer / ecommerce tracking.
- Emit a Google Search Console `google-site-verification` meta tag for domain ownership proof.
- Emit a Yandex Webmaster `yandex-verification` meta tag for domain ownership proof.
- Verify a new site with Google Search Console via the meta-tag method.
- Verify a new site with Yandex Webmaster via the meta-tag method.
- Keep the GTM snippet out of admin (`/admin/`) pages automatically.
- Suppress GTM firing for the superuser (user 1) to avoid skewing analytics during admin work.
- Centralize analytics/tag configuration in one settings form instead of scattered blocks.
- Roll out GTM across a multilingual site (verification links in the form respect the current UI language).
- Manage tag-manager configuration through exportable Drupal config (`synapse.settings`).
- Deploy analytics setup between environments via configuration management.
- Provide a lightweight alternative to larger GTM/metatag modules for a single container.
- Load GTM at the bottom of the page (high render weight) so it does not block page rendering.
- Update the GTM container ID site-wide by changing one config value.
- Temporarily remove GTM by clearing the GTM-ID field.
- Add both analytics tracking and search-engine verification with one module.
- Confine the GTM snippet to front-end visitor traffic only.
- Serve site-verification meta tags on every front-end and admin page head.
