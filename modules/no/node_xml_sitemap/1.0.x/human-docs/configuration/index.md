# Configuration

Node XML Sitemap is intentionally light on configuration. Per the module's own
documentation, **no configuration is required** — once enabled, it provides a page that
lists the valid node URLs for your project, and the actual sitemap generation is
handled by the underlying **XML Sitemap** module.

## The node URL listing page

Go to `/admin/node-sitemap-listing` (its `node_xml_sitemap.form` route). This page
gives you a list of valid node URLs for your site — a quick way to review which node
content is available for the sitemap. There are no settings to fill in here; it is a
listing rather than a settings form.

## Where the real sitemap settings live

Because Node XML Sitemap builds on the **XML Sitemap** module, the substantive options —
which content types and entities are included, priority and change‑frequency defaults,
and sitemap regeneration — are configured there:

1. Go to **Configuration → Search and metadata → XML sitemap**
   (`/admin/config/search/xmlsitemap`).
2. Under the XML Sitemap **Settings → Entities** area, enable inclusion for the node
   content types you want in the sitemap and set their inclusion, priority, and change
   frequency.
3. Regenerate the sitemap (XML Sitemap rebuilds on cron, or you can rebuild it manually
   from its settings).

## Keep the sitemap to public content

An XML sitemap should only advertise content that is genuinely public and indexable.
Make sure the nodes included are published and viewable by anonymous users — do not
list content that should be restricted. Node XML Sitemap itself performs no access
control; it relies on you including only appropriate content.
