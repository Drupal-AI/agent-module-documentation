<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Entity Soundcloud — agent index

Adds a **SoundCloud media source** (`MediaSource` plugin id `soundcloud`) to core Media, plus a
**field formatter** (`soundcloud_embed`) that renders the media as an iframe player. Depends on
`media`. No admin settings page (`configure` = null), no permissions, no Drush. Config surface =
the media type + its source field + the display formatter, plus one tiny config object.

- **Set up a SoundCloud media type, source field, and the embed display** →
  [configure/media-type.md](configure/media-type.md)
- **The `soundcloud` source plugin: metadata attributes, oEmbed, source_id format** →
  [api/source.md](api/source.md)
- **The embed: `soundcloud_embed` formatter options, theme hook & template** →
  [theming/embed.md](theming/embed.md)

Key facts:
- Source plugin id `soundcloud`, allowed source field types: `string`, `string_long`, `link`.
  The source field stores the SoundCloud track/playlist URL.
- Metadata attributes: `track_id`, `playlist_id`, `source_id` (`tracks/{id}` or `playlists/{id}`),
  `html`, `thumbnail_uri`. Derived by calling `https://soundcloud.com/oembed`.
- Formatter id `soundcloud_embed`; settings `type` (visual|classic), `width`, `height`, `color`,
  `options[]`.
- Config object `media_entity_soundcloud.settings` has one key: `thumbnail_destination`
  (default `public://soundcloud`) — where fetched thumbnails are saved.
- Theme hook `media_soundcloud_embed` → `media-soundcloud-embed.html.twig`.
