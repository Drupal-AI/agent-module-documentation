<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming: the Google News XML templates

Two themeable templates emit the feed. Override them in your theme to change the XML.

## `views-view-googlenews.html.twig` (theme hook `views_view_googlenews`)

Wraps the items in the sitemap/news namespaces:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
        xmlns:news="http://www.google.com/schemas/sitemap-news/0.9">
  {{ items }}
</urlset>
```

Variables: `items` (the rendered rows). Preprocess
`template_preprocess_views_view_googlenews()`:
- defaults each row's `news_publication_name` to the **site name** and
  `news_publication_language` to the **default language** when empty;
- sets response header `Content-Type: text/xml; charset=utf-8` (skipped during live preview).

## `views-view-row-googlenews.html.twig` (theme hook `views_view_row_googlenews`)

Emits one `<url>` / `<news:news>` block. Variables (set by
`template_preprocess_views_view_row_googlenews()`): `loc`, `name`, `language`, `access`,
`genres`, `publication_date`, `title`, `keywords`, `stock_tickers`. `loc` is filtered with
`UrlHelper::filterBadProtocol()`; `title`/`keywords`/`stock_tickers` are `strip_tags`-ed;
`publication_date` is trimmed of tags. Optional tags (`access`, `genres`, `keywords`,
`stock_tickers`) render only when non-empty.

The row array can be modified first via `hook_views_googlenews_item_alter()` (see
hooks/alter.md).
