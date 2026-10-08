<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Google custom RSS feeds adds Views style and row plugins that produce the specific RSS dialects Google News and Google Merchant Center expect.

---

Both are RSS, and neither is ordinary RSS. Google News wants publication metadata, publication dates and access flags in its own namespace; Merchant Center wants product identifiers, prices, availability and image links in the `g:` namespace, with strict rules about what may be omitted. Core's RSS style produces neither, so the usual outcome is a hand-built Twig template that works until the specification changes.

Doing it as Views plugins is the right shape: `google_news_feed` and `google_shopping_feed` styles with matching row plugins, so the feed is a View like any other — filters decide which content is included, sorts decide the order, contextual filters can produce a feed per category, and access and caching behave normally. Two field formatters ship alongside for the fields these feeds are fussy about: `ImageAbsoluteUrlFormatter` (feeds need absolute URLs, and a relative one is a silently rejected item) and `GoogleShoppingTermFormatter` for mapping taxonomy terms onto Google's product categories.

The release is **8.x-1.7-rc1**, a release candidate. Both target specifications are maintained by Google and change without regard to Drupal's release cycle, so treat feed validity as something to monitor — Merchant Center and News both report item-level rejections, and that report is the real test rather than the module version.

---

- Publish a Google News feed from a content listing.
- Produce a Google Merchant Center product feed.
- Filter which content appears in a news feed.
- Generate one feed per category with contextual filters.
- Order feed items by publication date.
- Emit absolute image URLs in a feed.
- Map taxonomy terms to Google product categories.
- Replace a hand-built Twig feed template.
- Reuse Views access and caching for a feed.
- Produce several feeds from one content type.
- Include only published, promoted items.
- Limit feed length with a Views pager.
- Validate feed output against Merchant Center.
- Monitor item-level rejections after a Google spec change.
- Syndicate news content to an aggregator.
- Keep feed definitions in exported configuration.