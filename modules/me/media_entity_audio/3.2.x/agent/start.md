<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Entity Audio Streams — agent index

Adds an `audio_stream` **media source** (audio referenced by URL via a `link` field) and an
`audio_stream_html5` **formatter** that renders those URLs in an HTML5 `<audio>` player.
Depends on core `media` + `link`. No settings form, no permissions, no Drush, no configure
route (`configure: null`). Config schema provided.

- **Create an Audio Stream media type, the source, the HTML5 formatter (`controls`), and the theme** →
  [plugins/audio-stream.md](plugins/audio-stream.md)

Key facts: media source id `audio_stream` (`AudioStream`, `allowed_field_types = {"link"}`,
default thumbnail `audio.png`); field formatter id `audio_stream_html5` (`link` fields; single
boolean setting `controls`, default TRUE); theme hook `media_audio`
(`media-audio.html.twig` → `<audio>` with one `<source>` per URL; MIME guessed via
`file.mime_type.guesser`). On a media type it is stored at `media.type.<id>` →
`source: audio_stream`.
