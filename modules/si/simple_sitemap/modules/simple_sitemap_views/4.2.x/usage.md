Submodule of Simple XML Sitemap that lets you add Views pages — including their argument-driven variations — to your XML sitemaps.

---

`simple_sitemap_views` bridges Drupal core's Views module with Simple XML Sitemap. It adds a Views display extender so any page display can be marked for inclusion in a sitemap, with its own priority and changefreq. For views that take contextual filters (arguments), it can index many concrete argument combinations, not just the base path, by collecting seen argument sets and generating the corresponding URLs. It ships a `views` URL generator plugin that Simple XML Sitemap uses to enumerate those routes during generation, an event subscriber that records argument values as they are requested, and a queue-worker garbage collector that prunes stale indexed argument records. Configuration lives at Admin → Configuration → Search and metadata → Simple XML Sitemap → Views. No extra permissions are added; it relies on the parent module's `administer sitemap settings`.

---

- Add a Views page display's URL to the XML sitemap.
- Set priority/changefreq for a view display in the sitemap.
- Index argument-driven view URLs (e.g. `/blog/{category}`).
- Capture real contextual-filter values as pages are visited.
- Cap how many argument variations get indexed per view.
- Include faceted or filtered listing pages in the sitemap.
- Expose taxonomy-argument view pages to search engines.
- Add a custom Views route to sitemaps without writing a URL generator.
- Enable sitemap inclusion via the Views UI display extender.
- Prune stale indexed argument records via the garbage-collector queue worker.
- Cover paginated or contextual archive pages for crawlers.
- Improve SEO coverage of dynamically generated listing pages.
- Index a "products by brand" view's per-brand URLs.
- Manage view-in-sitemap settings from the Views admin form.
- Combine view URLs with entity URLs in a single sitemap.
- Export view sitemap settings as part of the view config.
- Index a calendar/date-argument view's per-period URLs.
- Add search-result-style view pages that use safe arguments.
- Keep view URLs in sync with the parent module's regeneration queue.
- Provide sitemap entries for decoupled front-end routes backed by views.
