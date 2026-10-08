<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Entity Soundcloud adds a **SoundCloud media source** to Drupal core's Media module, so you can create a media type whose items are SoundCloud tracks or playlists (entered as a URL) and render them as embedded players.

---

The module plugs into core Media (it depends on `media`) by providing a `MediaSource` plugin with id `soundcloud` (allowed source field types `string`, `string_long`, `link`). You create a media type, choose "Soundcloud" as its source, and add a source field that holds the track/playlist URL. From that URL the source calls SoundCloud's public **oEmbed** endpoint (`https://soundcloud.com/oembed`) to derive metadata attributes — `track_id`, `playlist_id`, `source_id` (e.g. `tracks/12345`), `html` (the raw embed), and `thumbnail_uri` (downloaded to the directory in `media_entity_soundcloud.settings:thumbnail_destination`, default `public://soundcloud`). A companion field formatter `soundcloud_embed` renders the media as a responsive `<iframe>` pointing at the SoundCloud widget player, with configurable **type** (visual/classic), **width**, **height**, **color**, and a long list of player **options** (autoplay, hide related, show artwork/playcount/comments/user/reposts, download, buying, sharing, teaser overlays, single active). The embed markup is themeable via the `media_soundcloud_embed` theme hook / `media-soundcloud-embed.html.twig` template, whose preprocess builds the final `w.soundcloud.com/player/` URL. A Media Library "add" form (`SoundcloudForm`) lets editors paste a SoundCloud URL directly into the media library. There is no admin settings page (`configure` is null) — everything is configured through the media type, its source field, and the field-display formatter.

---

- Add SoundCloud tracks to a site as first-class Media entities (reusable, referenceable).
- Let editors paste a SoundCloud track URL and get an embedded player automatically.
- Create a "Podcast" or "Audio" media type backed by SoundCloud.
- Embed a SoundCloud playlist/set on a page via a media reference field.
- Reference SoundCloud media from an article, podcast episode, or artist profile.
- Add SoundCloud audio through the Media Library modal (paste-URL add form).
- Show the SoundCloud "visual" (large artwork) player on featured content.
- Show the compact "classic" player (height ~166px) in sidebars or teasers.
- Brand the player's play button by setting a custom color (default `#ff5500`).
- Enable autoplay for a landing-page audio embed.
- Hide related tracks so visitors stay on your content.
- Toggle showing artwork, play count, comments, uploader, or reposts on the player.
- Show or hide the download, buy, and share buttons on embedded players.
- Automatically fetch and store a track's thumbnail image locally for use as the media thumbnail.
- Change where SoundCloud thumbnails are stored via `thumbnail_destination`.
- Extract the numeric track or playlist id from a SoundCloud URL for custom logic.
- Use `source_id` (`tracks/{id}` or `playlists/{id}`) as a stable identifier for a SoundCloud item.
- Build a Views listing of SoundCloud media (e.g. a podcast archive).
- Override the embed template to change iframe attributes or wrap the player.
- Provide a consistent audio-embedding workflow instead of pasting raw iframes into the body.
- Manage SoundCloud audio permissions and revisions through the standard Media entity system.
- Migrate SoundCloud URLs into structured media during a content import.
- Ensure editors can only add valid SoundCloud URLs (the add form validates the URL and connectivity).
- Combine several SoundCloud players on one page with "single active" so only one plays at a time.
