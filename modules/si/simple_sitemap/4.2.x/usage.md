Simple XML Sitemap generates standard-compliant, multilingual (hreflang) XML sitemaps of your site's content to improve SEO, and provides a pluggable framework for building other sitemap types.

---

Out of the box the module builds a sitemaps.org-compliant XML sitemap that you enable per entity type and bundle (nodes, taxonomy terms, users, menu links, etc.) at Admin → Configuration → Search and metadata → Simple XML Sitemap. You control per-bundle inclusion, `priority`, and `changefreq`, and can override those values on individual entity edit forms. Large sites are handled through sitemap indexes and chunked sitemaps, generated via a queue that runs on cron or on demand. Multiple named sitemaps ("variants") of different sitemap types can coexist, and multilingual sites automatically get hreflang alternate links. Arbitrary custom links can be added by path, and everything is exposed as config entities so sitemaps and their settings are exportable and deployable. Developers extend it with `UrlGenerator` and `SitemapGenerator` plugins and a set of alter hooks, or drive generation programmatically through the `simple_sitemap.generator` service. Drush commands regenerate sitemaps and rebuild the generation queue. Submodules add search-engine submission/IndexNow (`simple_sitemap_engines`) and Views route integration (`simple_sitemap_views`).

---

- Generate a sitemaps.org-compliant XML sitemap at `/sitemap.xml` for SEO.
- Include or exclude specific content types (article, page) from the sitemap.
- Add taxonomy term pages to the sitemap for better crawl coverage.
- Include user profile pages or custom entity types selectively.
- Set a crawl `priority` (0.0–1.0) per bundle to signal page importance.
- Set a `changefreq` (daily, weekly, monthly) hint per bundle.
- Override priority/changefreq for a single node on its edit form.
- Emit hreflang alternate links so Google serves the right language.
- Split very large sites into chunked sitemaps under a sitemap index.
- Regenerate sitemaps in the background via cron using the queue.
- Regenerate on demand with `drush simple-sitemap:generate`.
- Maintain multiple named sitemap variants (e.g. news vs. products).
- Define custom sitemap types with their own URL/sitemap generators.
- Add arbitrary/off-entity links to a sitemap by path.
- Exclude specific entities from the sitemap in code via a hook.
- Alter generated link data (images, lastmod) before the XML is written.
- Export sitemap configuration between environments as YAML config.
- Provide an image sitemap by including entity image fields.
- Rebuild only selected variants with `drush simple-sitemap:rebuild-queue --variants=...`.
- Set the maximum number of links per sitemap chunk.
- Automatically add `lastmod` timestamps from entity changed dates.
- Restrict sitemap administration to trusted roles via permissions.
- Let editors toggle sitemap inclusion per entity with a scoped permission.
- Generate sitemaps for menu links via the menu link URL generator.
- Programmatically enable a bundle and set its settings from custom code.
- Ping/submit sitemaps to search engines (with the engines submodule).
- Add Views pages/routes to sitemaps (with the views submodule).
- Serve a robots.txt-referenced sitemap for crawler discovery.
- Alter sitemap XML attributes/namespaces before document generation.
