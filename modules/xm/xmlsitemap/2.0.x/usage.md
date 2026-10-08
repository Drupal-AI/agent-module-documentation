XML Sitemap generates a standards-compliant sitemap.xml (per the sitemaps.org protocol) listing your site's content so search engines can crawl and index it efficiently.

---

XML Sitemap builds and maintains one or more XML sitemaps that tell search engines which URLs on your site exist, how important they are, and how often they change. You enable sitemap inclusion per entity type and bundle (nodes, taxonomy terms, users, menu links, etc.), and per bundle you set the default priority and change-frequency; editors with permission can override those per individual item. The module keeps a link table it indexes incrementally on cron, then generates chunked, optionally gzip-compressed sitemap files (splitting into multiple files and a sitemap index when the URL count is large). It supports multiple sitemaps keyed by "context" (for example one per language or per domain) via config entities. A rebuild flow regenerates the whole link set from scratch when you change what is included. Many hooks (`hook_xmlsitemap_link_info`, `hook_xmlsitemap_link_alter`, context hooks, element/root-attribute alters) let other modules contribute links or reshape output. Drush commands (`xmlsitemap:regenerate`, `xmlsitemap:rebuild`, `xmlsitemap:index`) drive generation from the CLI. Companion submodules add user-defined custom links (xmlsitemap_custom) and search-engine ping/submission (xmlsitemap_engines).

---

- Publish a `sitemap.xml` that search engines can fetch and crawl.
- Include all published nodes of chosen content types in the sitemap.
- Add taxonomy term pages to the sitemap for better topic indexing.
- Include user profile pages when appropriate.
- Add menu links to the sitemap.
- Set a default priority per content type (e.g. articles higher than pages).
- Set a default change frequency per bundle (daily, weekly, monthly).
- Let editors override priority/frequency for a specific node.
- Exclude specific bundles or items from the sitemap entirely.
- Automatically split large sitemaps into a sitemap index + chunk files.
- Serve gzip-compressed sitemap files to save bandwidth.
- Regenerate sitemaps on cron as content changes.
- Rebuild the whole sitemap after changing inclusion settings.
- Maintain separate sitemaps per language on a multilingual site.
- Maintain per-context sitemaps (e.g. per domain) via config entities.
- Regenerate sitemaps from the CLI with `drush xmlsitemap:regenerate`.
- Rebuild the link table from the CLI with `drush xmlsitemap:rebuild`.
- Index outstanding links from the CLI with `drush xmlsitemap:index`.
- Contribute custom links from a module via `hook_xmlsitemap_link_info`.
- Alter a link's priority/frequency in code via `hook_xmlsitemap_link_alter`.
- Add custom XML elements to entries via `hook_xmlsitemap_element_alter`.
- Define custom sitemap contexts via `hook_xmlsitemap_context_info`.
- Add hand-picked custom URLs to the sitemap (with xmlsitemap_custom).
- Ping search engines when the sitemap updates (with xmlsitemap_engines).
- Improve SEO/discoverability for large content-heavy sites.
- Control the maximum links per sitemap chunk and file size.
- Gate sitemap administration behind a dedicated permission.
