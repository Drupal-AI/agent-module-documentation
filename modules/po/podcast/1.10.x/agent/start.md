# Podcast — agent index

Build a podcast RSS feed (iTunes/Apple Podcasts + Podcast Index namespaces) with Views.
Adds a Views feed **style** `podcast_rss` (channel-level XML) and **row** `podcast_rss_fields`
(per `<item>` XML); you map ordinary View fields to podcast/iTunes XML elements in the
format settings. Depends on `select_or_other`. No admin page (`configure` null), no
permissions, no Drush.

- **Building the feed View + every channel and item field mapping (all `itunes:*` /
  `podcast:*` options)** → [configure/feed.md](configure/feed.md)
- **The two Twig templates, theme hooks, and preprocess/CDATA behaviour** →
  [theming/templates.md](theming/templates.md)

Key facts:
- Style plugin: `Drupal\podcast\Plugin\views\style\Rss` (`@ViewsStyle id="podcast_rss"`,
  `display_types={"feed"}`, theme `views_view_rss_podcast_feed`). Extends core Views `Rss`.
  Adds namespaces `itunes`, `content`, `atom`, `podcast`; builds channel elements in
  `getPodcastElements()`; parses `Category/Subcategory` iTunes categories.
- Row plugin: `Drupal\podcast\Plugin\views\row\RssFields` (`@ViewsRow
  id="podcast_rss_fields"`, theme `views_view_row_rss_podcast_feed`). Extends core
  `RssFields`; builds `<enclosure>`, transcript (auto MIME by extension), chapters,
  soundbite, person, season/episode, itunes:* per item.
- Shared `PodcastViewsMappingsTrait`: `buildElementFromOptions()` maps a selected field id
  to a key/value element; `buildElementForLink()` absolutises URLs.
- Config schema `config/schema/podcast.schema.yml`: `views.style.podcast_rss` +
  `views.row.podcast_rss_fields` (all mapping keys are stored on the View, not global config).
- `podcast.module` preprocess hooks (`views_view_rss`, `views_view_row_rss`,
  `views_view_field`) serialize nested channel elements and CDATA-wrap description/summary.
- `select_or_other` dependency: the copyright field uses a `select_or_other_select` widget.
- `podcast.post_update.php` `podcast_post_update_copyright_field()` renamed the old
  `copyright` style option to `copyright_field`.
