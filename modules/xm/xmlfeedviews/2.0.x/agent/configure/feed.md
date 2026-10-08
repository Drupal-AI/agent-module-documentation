# Build an XML feed with a View

No admin page — you configure a **View** with a **Feed** display.

## Steps

1. Create/edit a View and **Add** a *Feed* display.
2. Set the Feed display **Format → Style** to **XML Feed Views** (`xmlfeedviews`). Configure:
   - **XML Head** (`xmlfeedviews_head`) — raw text emitted once before the rows, e.g.
     `<?xml version="1.0" encoding="UTF-8"?>` plus your root open tag `<urlset xmlns="…">`.
   - **XML Footer** (`xmlfeedviews_footer`) — raw text after the rows, e.g. `</urlset>`.
3. Set **Format → Show** to **XML Feed Views fields** (`xmlfeedviews_fields`). Configure:
   - **XML Items Wrapper** (`xmlfeedviews_body_before`) — per-row open tag, e.g. `<url>`.
   - **XML Body** (`xmlfeedviews_body`, required) — the per-row template; put each element on its
     own line and reference Views fields with `{{ field_id }}`, e.g.
     `<loc>{{ view_node }}</loc>\n<changefreq>daily</changefreq>\n<priority>1.0</priority>`.
   - **XML Items Wrapper closing** (`xmlfeedviews_body_after`) — per-row close tag, e.g. `</url>`.
4. Add every field you reference (matching the `{{ field_id }}` machine ids) under **Fields**.
   Fields can be excluded from display but must exist so `getField()` can resolve them.
5. Set the Feed display **Path** (e.g. `xml-feed-view.xml`) and save. The feed is served there.

## How substitution works

`XmlFeedViewsFields::getBodyField()` scans the body for `{{ id }}` tokens (regex
`/\{{([A-Za-z0-9_ ]+?)\}}/`) and replaces each with
`$view->style_plugin->getField($rowIndex, $id)` — the View field's rendered output. Templates
`xmlfeedviews.html.twig` / `xmlfeedviews-row.html.twig` print head/footer and
body_before/body/body_after with `|raw`, so your literal XML tags are preserved.

## Escaping note (not a vulnerability)

The `|raw` in the templates applies to admin-authored template strings (head/footer/wrapper/body),
which are Views style/row options — editing a View requires the `administer views` permission
(`restrict access: true`). The interpolated `{{ field }}` values come from
`getField()`, i.e. Views field formatters' already-rendered `MarkupInterface` output, so content
authored by lower-privilege users is HTML/XML-entity escaped before insertion. If you deliberately
configure a field with "Display as HTML" / no stripping, that markup passes through — the same
trust model as any raw Views field output. Prefer plain-text fields (or wrap values in CDATA) for
feed items to keep output well-formed.

## Example View

`config/optional/views.view.xmlfeedviews_view.yml` ships a ready sitemap: default display plus a
`feed` display at path `xml-feed-view.xml`, head `<?xml…?><urlset…>`, per-row `<url><loc>{{ view_node }}</loc>…</url>`.
Install it (or copy it) as a starting point.
