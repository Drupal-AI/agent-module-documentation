<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple XML Sitemap arbitrary links adds an admin UI for including arbitrary URLs — ones not tied to a Drupal entity — in your Simple XML Sitemap.

---

Simple XML Sitemap indexes entity URLs, but sites often need to list custom or external-style paths (marketing landing pages, non-entity routes, multilingual entries) in the sitemap. This module provides a form at `/admin/config/search/simplesitemap/custom-arbitrary-links` where you manage a table of links, each with URL, priority, change frequency, last-modified date, and language. Rows are added/removed dynamically with AJAX and stored in the module's own database table; input URLs in various formats (`link`, `/link`, `example.com/link`) are normalized. Saving can optionally trigger a sitemap regeneration through the `simple_sitemap` generator so the new links appear in `sitemap.xml`.

The form and the bundled Simple XML Sitemap collection route are gated by a single permission, `administer custom sitemap links` (marked `restrict access: TRUE`). The module depends on `simple_sitemap` being installed and configured first. It has no anonymous or public endpoints — everything is behind that admin permission.

---

- Add a non-entity URL to the XML sitemap.
- Include a marketing landing page path in sitemap.xml.
- Set the priority for a custom sitemap link.
- Set the change frequency (daily/weekly/...) for a link.
- Set a last-modified date for a custom link.
- Assign a language to a sitemap link for multilingual sites.
- Add multiple links dynamically via AJAX without reloading.
- Remove a custom link from the sitemap.
- Normalize URL formats automatically (link, /link, example.com/link).
- Regenerate all sitemaps after editing links.
- Manage custom links from Configuration > Search and metadata.
- Grant the 'administer custom sitemap links' permission to editors.
- Keep custom URLs alongside entity URLs in one sitemap.
- List external-style paths for crawlers.
- Boost SEO coverage of pages not backed by entities.
- Edit an existing custom link's attributes.
