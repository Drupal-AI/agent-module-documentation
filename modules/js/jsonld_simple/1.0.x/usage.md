<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JSON-LD Simple injects configurable JSON-LD structured-data metadata into the HTML head of pages.

---

The module provides a single settings form (`/admin/config/search/jsonld-simple/settings`, gated by the `administer JSON-LD` permission) where an administrator pastes or builds JSON-LD blocks that are then emitted inside a `<script type="application/ld+json">` tag in the page head. It is a lightweight SEO helper with no entity type, no external calls, and no front-end interaction of its own; output is controlled entirely by trusted administrators.

---

- Add Schema.org JSON-LD structured data to a site.
- Improve search-engine rich results via structured metadata.
- Configure JSON-LD from a single admin settings form.
- Emit JSON-LD in the HTML `<head>`.
- Restrict configuration to the `administer JSON-LD` permission.
- Describe an Organization, WebSite, or LocalBusiness in JSON-LD.
- Provide breadcrumb or sitelinks structured data.
- Centralize schema metadata in one place.
- Avoid hand-editing templates to add JSON-LD.
- Support Drupal 8.8, 9, and 10.
- Add SEO metadata without extra dependencies.
- Serve structured data to crawlers like Googlebot.
- Manage schema output as trusted-admin configuration.
- Keep JSON-LD consistent across the site.
- Enhance semantic metadata for SEO audits.
- Enable/disable the JSON-LD output via settings.
