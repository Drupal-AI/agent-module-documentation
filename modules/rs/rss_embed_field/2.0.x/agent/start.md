<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# RSS Embed Field (rss_embed_field) — agent index

**Link-field widget + formatter that server-fetches an RSS/Atom feed and renders its items in a node.**

- **Version:** 2.0.x
- **Core:** ^9.4 || ^10
- **Depends:** link
- **Package:** (none)

**Surface:** FieldWidget + FieldFormatter `rss_embed_field` for `link` fields; `RssFeedFetcher` service (Guzzle + 24h temp-file cache); Laminas Feed Reader parsing; `Rss` formatter sanitises items with `strip_tags`/`Xss::filter`.

**Fetching:** `RssFeedFetcher::fetch()` GETs the field-supplied URL both on widget validation (`validateUriElement`) and on display — `src/RssFeedFetcher.php` `get()`. Item output is filtered by the formatter.
