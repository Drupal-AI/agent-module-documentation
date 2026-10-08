XML Feed Views adds a Views **style** and **row** plugin that let you build an arbitrary XML feed (sitemap, RSS, Google Merchant feed, or any custom XML) from a View's Feed display, with full control over the head/footer and per-row markup via simple `{{ field }}` placeholders.

---

The module provides two Views feed-display plugins: the style plugin `xmlfeedviews` and the row
plugin `xmlfeedviews_fields`. On a View's **Feed** display you set the style to *XML Feed Views*
(defining a raw **XML Head** and **XML Footer** — e.g. the `<?xml?>` declaration and `<urlset>`
open/close) and the row to *XML Feed Views fields* (defining a per-item **wrapper open tag**,
**body** template, and **wrapper close tag**). The body template is plain text containing
`{{ field_id }}` placeholders; for each result row the row plugin substitutes each placeholder
with the rendered value of the matching Views field (via `style_plugin->getField()`), so the
inserted values are the field formatters' already-rendered, sanitized output. The head, footer,
wrapper and body are emitted through Twig with `|raw` so your literal XML tags pass through
verbatim. The feed is served at the Feed display's configured `path` (e.g. `xml-feed-view.xml`).
The module ships an **optional** example View (`views.view.xmlfeedviews_view`) producing a
sitemap-style `urlset`. There is no config UI, no permissions, no schema — everything lives in
the View configuration.

---

- Generate an XML sitemap (`urlset` / `<loc>` / `<changefreq>` / `<priority>`) from a node View.
- Build a Google Merchant / product feed from a commerce or content View.
- Produce a custom RSS-like feed with your own element names and namespaces.
- Emit any bespoke XML structure a third-party system expects to ingest.
- Expose filtered/sorted content (via the View's filters and sorts) as an XML endpoint.
- Control the exact XML declaration and root element through the XML Head/Footer options.
- Wrap each result row in a custom element (e.g. `<url>…</url>` or `<item>…</item>`).
- Interpolate multiple Views fields into one item with `{{ title }}`, `{{ view_node }}`, etc.
- Output absolute node URLs in a feed using the entity-link field.
- Serve the feed at a clean path via the Feed display's path setting.
- Provide a language-specific feed by adding a language filter to the View.
- Paginate or cap the feed with the Feed display's items-per-page.
- Create several feeds (sitemap + product feed) from one site using multiple Views.
- Start from the shipped example View and adapt it to your schema.
- Add XML namespaces (e.g. `xmlns:xhtml`, `xmlns:g`) in the XML Head.
- Attach the feed as an alternate `<link rel="alternate" type="text/xml">` on the page display.
- Include computed/aggregated field values in feed items via Views fields.
- Feed a search engine or aggregator that requires a non-standard XML shape.
- Replace core's RSS feed style when you need full markup control.
- Migrate legacy custom-feed code to a configurable, Views-driven feed.
