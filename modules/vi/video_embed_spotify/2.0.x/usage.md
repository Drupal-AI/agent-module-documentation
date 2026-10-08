<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Video Embed Spotify adds Spotify as a provider for Video Embed Field, so an `open.spotify.com` URL — a track, album, artist, playlist, show or podcast episode — pasted into a video embed field renders as an embedded Spotify player.

---

The module is a single provider plugin (`Drupal\video_embed_spotify\Plugin\video_embed_field\Provider\Spotify`) that extends Video Embed Field's `ProviderPluginBase`; it ships no configuration, no permissions, no services and no schema. One regular expression drives everything: `^https://(open\.spotify\.com/)(embed-podcast/|embed/)?(?<type>album|artist|episode|playlist|show|track|user)/(?<id>[0-9A-Za-z_-]*)(\?.*)?$` (case-insensitive). `getIdFromInput()` returns the named `id` capture, which Video Embed Field uses both to decide the plugin is applicable and as the video ID; `buildEmbedUrl()` re-matches the same regex and assembles `https://open.spotify.com/embed[-podcast]/{type}/{id}` — the `-podcast` segment is added only for `episode` and `show` types. `renderEmbedCode()` returns a `video_embed_iframe` render element pointing at that URL with attributes `frameborder=0`, `allowfullscreen`, `allowtransparency=true` and `allow=encrypted-media`; Video Embed Field's Twig template emits the `<iframe>` and auto-escapes the `src`. Because it is a Video Embed Field provider, it inherits that module's field type, formatters (embedded player and thumbnail), colorbox/modal integration and per-field allowed-provider selection — nothing here is Spotify-specific beyond URL recognition and the iframe attributes. The name is worth explaining to an agent: Video Embed Field's provider architecture is generic enough that it gets reused for things that are not video, and Spotify is mostly audio — in practice this module is used for podcasts more often than music, so treat the field as an audio/media field, not a video one. Remote thumbnails are unusual: `getRemoteThumbnailUrl()` overrides the base and fetches Spotify's oEmbed endpoint (`https://open.spotify.com/oembed?url={input}`) with a raw `file_get_contents()` call, returning `thumbnail_url`; the host is fixed to Spotify, so this is not an open fetch. Requires `video_embed_field` (`^3.0`); version 2.0.2 on core `^10.3 || ^11`.

---

- Embed a Spotify podcast episode on its own node page.
- Add a Spotify player to an article body via a video embed field.
- Publish show notes alongside an embedded episode.
- Embed a curated Spotify playlist on a landing page.
- Add a single track to a music-review article.
- Reference an album in a discography listing.
- Embed a Spotify show (podcast series) page.
- Embed an artist page as a player.
- Build a podcast archive where each item embeds its episode.
- Add audio to an event or project page.
- Reference an episode from a news item.
- Recognise legacy `open.spotify.com/embed/...` and `embed-podcast/...` URLs already in content.
- Restrict a field to Spotify by selecting it in Video Embed Field's allowed providers.
- Render a Spotify thumbnail (via oEmbed) as a click-to-play preview using Video Embed Field's thumbnail formatter.
- Combine Spotify with YouTube/Vimeo in one multi-provider media field.
- Support a podcast publishing workflow where editors paste a Share link.
- Add a soundtrack or interview clip to a portfolio entry.
- Embed a recorded talk hosted as a Spotify episode.
- Place a Spotify player behind a consent manager as a third-party embed.
- Migrate existing Spotify links into structured media fields.
