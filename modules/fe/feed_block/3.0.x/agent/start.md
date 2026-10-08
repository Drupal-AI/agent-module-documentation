# Feed Block — agent index

Displays external RSS/Atom feed items inside a custom block. Installs a `feed_block`
`block_content` bundle with an `rss_feed_field` (plus Intro Text and Read More fields). The
formatter fetches + parses the feed at render time and lists items. No global config page
(`configure` null), no permissions/Drush/config-schema of its own. Depends on core `block`,
`block_content`, `node`, `link`.

- **Creating/placing a feed block and every field/widget setting** →
  [configure/block.md](configure/block.md)
- **The item template, theme suggestions, and overriding markup** →
  [theming/templates.md](theming/templates.md)

Key facts:
- Bundle `block_content.feed_block`; field `field_rss_feed` (type `rss_feed_field`), widget
  `rss_feed_widget`, formatter `rss_feed_formatter`. Also `field_intro_text`, `field_read_more`.
- Fetch: `RSSFeedFormatter::performRequest()` (Guzzle `get`, or `file_get_contents` if
  `file_exists`), parsed with `simplexml_load_string`; handles `item`, Atom `entry`, `channel->item`.
- Caching: `FeedBlockHooks::blockContentViewAlter` sets `#cache max-age` (config `feed_block:
  cache_expiration`, default 86400) + tag `feed_block`; `FeedBlockCacheExpire` subscriber bubbles it.
- Theme hook `feed_block_rss_item` → `feed-block-rss-item.html.twig`.
