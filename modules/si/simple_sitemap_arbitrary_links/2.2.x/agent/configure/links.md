<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple XML Sitemap arbitrary links — configure

Prerequisite: `simple_sitemap` installed and configured.

1. Grant **`administer custom sitemap links`** to the relevant role.
2. Go to **Configuration → Search and metadata → Simple XML Sitemap → Custom Arbitrary Links** (`/admin/config/search/simplesitemap/custom-arbitrary-links`).
3. Click **Add new link** to insert a row (AJAX, no reload). Per row set: **URL**, **priority**, **change frequency**, **last modified**, **language**.
4. URL formats `link`, `/link`, `example.com/link` are normalized automatically.
5. **Save** to persist to the module's DB table. Tick **Regenerate all sitemaps** to rebuild `sitemap.xml` immediately (via the `simple_sitemap` generator); otherwise the links appear on the next regeneration.
6. Use **Remove** to delete a link.

The links are merged into the Simple XML Sitemap output alongside normal entity URLs.
