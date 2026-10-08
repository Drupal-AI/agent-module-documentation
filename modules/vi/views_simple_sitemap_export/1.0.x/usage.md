<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Simple XML Sitemap Export exports results from a View into a sitemap managed by Simple XML Sitemap.

---

Views Simple XML Sitemap Export lets a View feed a Simple XML Sitemap — exporting the View's result rows
(their URLs) into a sitemap managed by the Simple XML Sitemap module, so arbitrary View-defined URL sets can
be included in the site's XML sitemap. It depends on core Views and the Simple XML Sitemap module, in the SEO
package.

Use it to add View-derived URLs to your sitemap. It is an SEO feature; a sitemap advertises URLs, so ensure
the View only exposes **public** content that should be crawlable (don't include private/restricted URLs). It
has no access-control role. Configure the View and sitemap export.

---

- Export a View's results into a sitemap.
- Feed Simple XML Sitemap from a View.
- Include View-defined URLs in the sitemap.
- Depend on Views and Simple XML Sitemap.
- Add arbitrary URL sets to the sitemap.
- Export View rows' URLs.
- Include only public/crawlable content.
- Not include private/restricted URLs.
- Have no access-control role.
- Configure the View and export.
- Handle sitemap export.
- Export URLs.
- Configure the sitemap.
- Handle Views sitemap.
- Add URLs to sitemap.
- Configure SEO.
- Handle the export.
- Export to sitemap.
- Configure sitemap export.
- Add View URLs.
