XML Sitemap Custom is a submodule of XML Sitemap that lets administrators add hand-picked, arbitrary URLs to the sitemap that aren't backed by a Drupal entity.

---

XML Sitemap only lists links that come from entities (nodes, terms, users, menus). XML Sitemap Custom fills the gap by letting an administrator register any URL — internal or external — as a custom sitemap link. Each custom link stores its location plus the standard sitemap attributes (priority, change frequency, language) so it is treated like any other entry during generation. Links are managed from a dedicated admin listing under the XML Sitemap configuration (Add / Edit / Delete forms). It depends on the parent xmlsitemap module and reuses its `administer xmlsitemap` permission. This is useful for exposing pages served outside Drupal's routing, static files, or important landing URLs that would otherwise never make it into the sitemap.

---

- Add a static HTML page (outside Drupal) to the sitemap.
- Include a downloadable file (PDF, doc) URL in the sitemap.
- List an important landing page served by another system.
- Add an externally hosted URL you still want crawled.
- Set a custom priority for a hand-picked link.
- Set a custom change frequency for a manually added URL.
- Assign a language to a custom sitemap link on multilingual sites.
- Expose a route that has no backing entity.
- Add a campaign or microsite URL to the sitemap.
- Edit a previously added custom link's attributes.
- Remove a custom link from the sitemap.
- Curate a small set of must-index URLs alongside entity links.
- Include an API docs or help page not modeled as content.
- Add a legacy URL you want search engines to keep.
- Manage all custom links from one admin listing.
- Ensure a homepage alias variant is indexed.
