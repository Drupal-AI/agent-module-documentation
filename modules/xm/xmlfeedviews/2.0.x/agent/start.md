# XML Feed Views — agent index

Two Views feed-display plugins that turn a View into an arbitrary XML feed (sitemap, RSS,
product feed, custom XML). No config UI (`configure` null), no permissions, no schema, no Drush.
All configuration is per-View.

- **How to build a feed: Feed display, the style + row options, `{{ field }}` placeholders, the example View, output escaping** →
  [configure/feed.md](configure/feed.md)

Key facts:
- Style plugin id `xmlfeedviews` (options `xmlfeedviews_head`, `xmlfeedviews_footer`).
- Row plugin id `xmlfeedviews_fields` (options `xmlfeedviews_body_before`, `xmlfeedviews_body`,
  `xmlfeedviews_body_after`); both are `display_types = {"feed"}`.
- Body placeholders `{{ field_id }}` are replaced by the rendered Views field output
  (`XmlFeedViewsFields::getField()`); templates emit head/footer/body via Twig `|raw`.
- Optional example: `views.view.xmlfeedviews_view` (config/optional), path `xml-feed-view.xml`.
