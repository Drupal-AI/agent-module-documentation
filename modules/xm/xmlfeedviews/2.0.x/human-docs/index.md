# XML Feed Views — manual setup guide

**XML Feed Views** (`xmlfeedviews`) lets you build an arbitrary XML feed — a
sitemap, an RSS‑like feed, a Google Merchant product feed, or any bespoke XML a
third‑party system expects — straight from a View. It does this by adding a Views
**style** plugin and a matching **row** plugin that you attach to a View's Feed
display, giving you full control over the document's head and footer and over the
markup of each row via simple `{{ field }}` placeholders.

Because everything is driven by a View, you get Views' filters, sorts, pagination,
and language handling for free — so you can, for example, expose only published
nodes in a given language, sorted however you like, at a clean URL. You define the
raw XML declaration and root element in the **XML Head**/**XML Footer**, wrap each
result row in your own element, and interpolate any Views fields you've added into
the row body.

There is no configuration page, no permissions, and no schema — all the setup
lives inside the View itself. The module also ships an optional example View that
produces a sitemap‑style `urlset` you can use as a starting point.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere of its own — you work entirely inside the **Views** UI at **Structure →
Views** (`/admin/structure/views`). The plugins appear as Format options on a
View's Feed display.

## How to use it

You configure a **View** with a **Feed** display:

1. **Create or edit a View** and add a **Feed** display.
2. **Set the style** (Format → Style) to **XML Feed Views**. In its settings:
   - **XML Head** — raw text emitted once before the rows, e.g.
     `<?xml version="1.0" encoding="UTF-8"?>` followed by your root open tag such
     as `<urlset xmlns="…">`. This is also where you add any XML namespaces.
   - **XML Footer** — raw text after the rows, e.g. `</urlset>`.
3. **Set the row format** (Format → Show) to **XML Feed Views fields**. In its
   settings:
   - **XML Items Wrapper** — the per‑row opening tag, e.g. `<url>`.
   - **XML Body** *(required)* — the per‑row template. Put each element on its own
     line and reference Views fields by their machine id with `{{ field_id }}`,
     for example:

     ```
     <loc>{{ view_node }}</loc>
     <changefreq>daily</changefreq>
     <priority>1.0</priority>
     ```
   - **XML Items Wrapper closing** — the per‑row closing tag, e.g. `</url>`.
4. **Add every field you reference** under the View's **Fields**, matching the
   `{{ field_id }}` machine names. Fields may be excluded from display, but they
   must exist so the module can resolve their values. For each row, each
   placeholder is replaced with that Views field's rendered output.
5. **Set the Feed display's Path** (e.g. `xml-feed-view.xml`) and save. Your feed
   is now served at that URL.

**A note on output safety.** Your head/footer/wrapper/body templates are printed
verbatim, but editing a View requires the `administer views` permission, so those
templates are trusted admin input. The interpolated `{{ field }}` values come from
Views field formatters' already‑rendered output, so lower‑privilege authored
content is entity‑escaped before insertion. To keep the XML well‑formed, prefer
plain‑text fields for feed items (or wrap values in CDATA) rather than fields
configured to output raw HTML.

**Starting point.** The module ships an optional example View,
`xmlfeedviews_view`, which produces a ready sitemap at `xml-feed-view.xml`.
Install or copy it and adapt it to your schema.
