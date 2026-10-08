Feed Block displays items from an external RSS/Atom feed inside a Drupal custom block. It ships a "Feed Block" block_content type with an RSS-feed field whose formatter fetches the feed at render time and lists a configurable number of items (title, link, date, description).

---

Enabling the module installs a `block_content` bundle `feed_block` carrying three fields: a custom `rss_feed_field` (RSS Feed), an `Intro Text` (text_long), and a `Read More` link field. The heart of the module is the `rss_feed_field` field type with its `rss_feed_widget` (an admin form: feed URL, item count 1–100, show/format date, show/trim/strip description) and its `rss_feed_formatter`. At display time the formatter's `performRequest()` fetches the feed URL with a Guzzle client (falling back to `file_get_contents()` if `file_exists()` is true for the value), parses the body with `simplexml_load_string()`, and iterates `item` / `entry` (YouTube Atom) / `channel->item` nodes, emitting each through the `feed_block_rss_item` theme hook (template `feed-block-rss-item.html.twig`: date, linked title, description). Description text is optionally stripped of HTML (`strip_tags`) and truncated (`Unicode::truncate`). There is no global settings page (`configure` is null); everything is per-block field config, so you create feeds at Structure → Block layout → Add custom block → Feed Block and place the resulting block. A cache event subscriber applies a per-block `max-age` (default 86400s) and a `feed_block` cache tag so feed output is cached rather than fetched on every request. Theming is intentionally minimal and overridable (`block__feed_block` suggestion + the item template). Depends on core `block`, `block_content`, `node`, and `link`.

---

- Show the latest items from an external RSS or Atom feed in a sidebar/footer block.
- Aggregate a partner site's or blog's headlines onto your pages.
- Display a YouTube channel's recent uploads (Atom `entry`/`link href` format is handled).
- Limit the block to the N most recent items (1–100).
- Show or hide each item's publish date, with a chosen core date format or a custom PHP format.
- Show item descriptions, optionally stripped of HTML and trimmed to a character length.
- Add intro text above the feed items via the block's Intro Text field.
- Add a "Read More" call-to-action link under the feed via the Read More field.
- Cache feed output for a configurable lifetime (default 1 day) to avoid refetching per request.
- Place multiple distinct feed blocks (each its own block_content entity) around the site.
- Override the item markup by copying `feed-block-rss-item.html.twig` into your theme.
- Provide a custom block-level template using the `block__feed_block` theme suggestion.
- Surface news/announcements from an authoritative external source without a full aggregator.
- Combine feed items with themed styling using the block content view display.
- Reuse a feed block across pages via the Block UI, Layout Builder, Panels, or Context.
- Present a compact "latest posts" widget sourced from an external CMS's feed.
- Style feed output freely (the module attaches only minimal CSS you can remove).
