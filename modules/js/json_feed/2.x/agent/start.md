<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JSON Feed — agent index

Adds a Views display + style + row that publish a View as a [JSON Feed 1.0](https://jsonfeed.org/)
endpoint. Requires core `views`. No module `configure` route (configured entirely inside Views), no
permissions, no Drush. Ships config schema for the three plugins.

- **Add a JSON Feed display to a View, style options, the row field→attribute mapping, requirements** →
  [configure/views.md](configure/views.md)

Key facts:
- Views display `json_feed` (`JsonFeed` extends `views\...\display\Feed`): `uses_route`, returns a
  JSON `CacheableResponse`, re-enables the pager, drops exposed-form/css_class options. Default
  style `json_feed_serializer`, default row `json_feed_fields`.
- Style `json_feed_serializer`: builds the top-level object; options `description`, `author`
  (name/url/avatar), `expired`; `sitename_title` (display option) uses the site name as title.
  `home_page_url` uses the display's Link display; `next_url` from the pager.
- Row `json_feed_fields`: maps fields to `id`, `url`, `external_url`, `title`, `content_html`,
  `content_text`, `summary`, `image`, `banner_image`, `date_published`, `date_modified`, `tags`,
  `author_*`. Required: `id_field`, `url_field`, and one of `content_html_field`/`content_text_field`.
- Most attributes are `strip_tags()`-ed; `content_html` is passed through (spec allows HTML). URL
  fields resolved absolute. Theme hook `json_feed_icon`; CSS library `json_feed/json-feed`.
