<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Google custom RSS feeds (google_feeds) — agent index

Views style + row plugins emitting **Google News** and **Google Shopping (Merchant Center)** RSS.
Version **8.x-1.7-rc1** (**release candidate**). Core `^9.3 || ^10 || ^11`.
Depends on `options`, `node`, `views`. No routes, permissions or config.

Plugins: `Plugin/views/style/GoogleNewsRss` (`id = google_news_feed`),
`Plugin/views/style/GoogleShoppingRss` (`id = google_shopping_feed`), with matching row plugins
`GoogleNewsRssFields` / `GoogleShoppingRssFields`.
Formatters: `ImageAbsoluteUrlFormatter` (feeds require absolute URLs — a relative one is silently
rejected), `GoogleShoppingTermFormatter` (taxonomy → Google product category).

Being Views plugins, filters, sorts, contextual arguments, pagers, access and caching all behave
normally.

**Both target specifications are Google's and change independently of Drupal releases.** The real
test of a feed is the item-level rejection report in Merchant Center / News, not the module
version — say so when recommending it.

## Solutions
- [views/feeds.md](views/feeds.md) — the exact Views recipe: style/row plugin ids, every row-option
  key, which fields are required, the auto-emitted elements, and the two field formatters.