<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Views RSS Feed — agent index

Replaces core's RSS style with a **fields-based** style plugin `rss_fields` ("Advanced RSS
feed") + row plugin `views_rss_fields` (also "Advanced RSS feed") for a Views Feed display.
The parent module ships **no RSS elements itself** — it only provides the plugin machinery,
the `views_rss_*` hooks, config schema (`views.style.rss_fields`, `views.row.views_rss_fields`),
and the `rfc822` date format. All actual `<channel>`/`<item>` elements come from its 5
submodules: `views_rss_core` (core RSS elements — enable this one, it's required),
`views_rss_dc` (Dublin Core), `views_rss_format` (raw/CDATA output tweak), `views_rss_media`
(Yahoo MRSS), `views_rss_media_getid3` (media file metadata via getID3). `configure: null` —
there is no global settings page; everything is per-View, in the style/row plugin options.

- **Build an RSS feed on a View (style/row plugin ids, options structure, feed_settings)** →
  [api/build-rss-feed.md](api/build-rss-feed.md)
- **Define/alter the `<channel>`/`<item>` elements a submodule contributes (the extension
  point every submodule and any custom extension uses)** →
  [hooks/element-hooks.md](hooks/element-hooks.md)

Key facts:
- Style plugin id `rss_fields` requires row plugin id `views_rss_fields` (mutual validation).
- The row plugin requires `views_rss_core` enabled (an item needs a title or description).
- Element/namespace registries are cached indefinitely in the `data` cache bin under
  `views_rss:<key>` (`views_rss:channel_elements`, `views_rss:item_elements`,
  `views_rss:namespaces`, `views_rss:date_sources`) — `drush cr` rebuilds them.
- View style options live at `views.view.<name>` →
  `display.<display>.display_options.style.options.channel.<namespace>.<module>.<element>`
  and the row plugin's `...row.options.item.<namespace>.<module>.<element>`.
