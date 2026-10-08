<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple XML Sitemap arbitrary links (simple_sitemap_arbitrary_links) — agent index

**Admin UI to add arbitrary non-entity URLs (with priority, changefreq, lastmod, language) to the Simple XML Sitemap.**

- **Version:** 2.2.x
- **Core:** `^10.3 || ^11`
- **Depends:** simple_sitemap
- **Routes:** `simple_sitemap_arbitrary_links.form` → `/admin/config/search/simplesitemap/custom-arbitrary-links`; `entity.simple_sitemap.collection` → `/admin/config/search/simplesitemap`. Both perm `administer custom sitemap links` (restricted).
- **Form:** `CustomSitemapLinksForm` — AJAX add/remove rows, stores links in a DB table, normalizes URL formats, optional sitemap regeneration via `@simple_sitemap.generator`.

**Security:** single admin permission `administer custom sitemap links` (`restrict access: TRUE`) gates all routes; no anonymous or mutating public endpoint. See [configure/links.md](configure/links.md). No security findings.
