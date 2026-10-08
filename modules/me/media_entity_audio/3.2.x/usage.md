<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Entity Audio Streams adds an `audio_stream` media source so you can create a Media type whose items are audio referenced by URL (a link field), and an `audio_stream_html5` formatter that renders those URLs in an HTML5 `<audio>` player.

---

The module plugs into core Media with two plugins and a theme hook. The **`audio_stream` media source** (`AudioStream`, extends `MediaSourceBase`) accepts `link` field types as its source field, ships a default `audio.png` thumbnail, derives a media item's default name from the link URI's basename, and — via `prepareViewDisplay()` — automatically sets the source field's display to the `audio_stream_html5` formatter with a visually-hidden label when the type is created. The **`audio_stream_html5` field formatter** (`AudioStreamHTML5`) targets `link` fields and has a single boolean setting, `controls` (default TRUE); it renders each link through the `media_audio` theme hook, passing the URI as a source and the controls flag. The **`media_audio` theme hook** (`template_preprocess_media_audio` + `media-audio.html.twig`) builds an `<audio>` element with one `<source>` per URL, guessing each source's MIME type via the `file.mime_type.guesser` service and mapping it to a value the `<audio>` tag understands (`audio/x-wav` → `audio/wav`, passing through `audio/mpeg` and `audio/ogg`, otherwise omitting the type); when `controls` is true it adds the `controls` attribute. The module has no settings form, no permissions, no Drush, and no configure route — you use it by creating a Media type that selects "Audio Stream" as its source. Config schema is provided for the source and the formatter's `controls` setting. Note the `3.x` line ships an update hook (`media_entity_audio_update_8301`) that migrates legacy `audio` sources to core's audio source or this `audio_stream` source depending on whether the source field is a link.

---

- Create a "Podcast" or "Audio" Media type whose items are audio URLs (streams/CDN links).
- Reference externally hosted MP3/OGG/WAV files by URL instead of uploading files.
- Render referenced audio in a native HTML5 `<audio>` player on the media display.
- Toggle the player's transport controls on/off via the formatter's `controls` setting.
- Embed streamed audio from a CDN or podcast host without storing the file locally.
- Give editors a simple link field to paste an audio stream URL into a media item.
- Auto-name audio media items from the URL's filename (basename of the URI).
- Add an audio media source alongside core Image/Video/Audio-file sources.
- Reuse audio media across nodes via a media reference field.
- Provide accessible audio playback with the browser's built-in `<audio>` controls.
- Serve `audio/mpeg` (MP3) and `audio/ogg` streams with correct `<source type>` values.
- Handle WAV streams by mapping `audio/x-wav` to `audio/wav` automatically.
- Present audio in the Media Library for selection in content.
- Build a searchable/managed catalogue of external audio resources as media entities.
- Override the `media-audio.html.twig` template to customize the audio player markup.
- Set the source field's display to a visually-hidden label so only the player shows.
- Support multiple audio URLs on one media item (one `<source>` per link value).
- Migrate a legacy `audio` media source to `audio_stream` where the source field is a link.
- Attach an audio media reference to podcasts, lessons, or music catalogue content types.
- Keep large audio assets off the Drupal file system by linking to a stream.
- Use a link-based audio source when files live on object storage or a media server.
- Provide a lightweight audio embed without a third-party oEmbed provider.
