<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Google News adds a Views feed **style** ("Google News Feed") and a matching **row** plugin ("Google News fields") that render a view of articles as a Google News sitemap XML feed conforming to Google's News publisher requirements.

---

The module is Views-only: it provides a style plugin `google_news` (id, title "Google News Feed", restricted to `feed` display types) and a row plugin `google_news_fields` (id, title "Google News fields"). You build a normal View of your news content, add a **Feed** display, set its Format to "Google News Feed" and its Row style to "Google News fields", then map each Google News tag (`<loc>`, `<news:name>`, `<news:language>`, `<news:access>`, `<news:genres>`, `<news:publication_date>`, `<news:title>`, `<news:keywords>`, `<news:stock_tickers>`) to one of the view's fields via the row plugin's option selects. Two Twig templates (`views-view-googlenews.html.twig` and `views-view-row-googlenews.html.twig`) emit the `urlset`/`news:` XML, and a preprocess sets the `text/xml` content type and defaults the publication name to the site name and the language to the site default. `<loc>` is run through `UrlHelper::filterBadProtocol()` and text tags are stripped. A `hook_views_googlenews_item_alter()` lets you adjust each item before rendering. There is no settings form, permission or Drush command — all configuration lives in the view.

---

- Publish a Google News sitemap feed of your latest articles for Google Publisher Center.
- Turn any View of news/article content into a `news:` XML sitemap at a chosen path.
- Map a node's canonical URL to the feed's `<loc>` element.
- Map an "Authored on"/created date to `<news:publication_date>` in W3C format.
- Map the node title to `<news:title>` for each news item.
- Provide per-article keywords (`<news:keywords>`) from a taxonomy or text field.
- Emit `<news:access>` = Subscription/Registration for paywalled or gated articles.
- Emit `<news:genres>` (e.g. PressRelease, UserGenerated) from a field.
- Include `<news:stock_tickers>` for finance articles from a field.
- Default the `<news:name>` publication name to the site name automatically.
- Default `<news:language>` to the site's default language when no field is mapped.
- Restrict the feed to content from the last two days with a "created >= now -2 days" filter (per Google's guidance).
- Expose the feed as an attached feed icon/link on a page display.
- Serve the feed with the correct `text/xml; charset=utf-8` content type.
- Build multiple Google News feeds (e.g. per section) as separate Feed displays or views.
- Alter each feed item programmatically via `hook_views_googlenews_item_alter()`.
- Override the XML output by overriding the two Twig templates in your theme.
- Combine with Views filters/sorts to control which articles and ordering appear in the feed.
- Localize feeds by mapping a language field to `<news:language>` on a multilingual site.
- Generate a compliant news sitemap without hand-writing XML.
- Use contextual filters to produce section-specific news sitemaps.
- Sanitize the item URL automatically (bad protocols filtered) for safe `<loc>` output.
