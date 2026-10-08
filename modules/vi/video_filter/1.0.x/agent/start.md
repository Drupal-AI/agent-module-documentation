# Video Filter — agent index

A text-format filter that turns `[video:URL ...]` tags into embedded players (mostly `<iframe>`),
matching URLs against pluggable provider "codecs". Configured per text format (no `configure` route,
`configure` null). No permissions, no Drush. Provides a `video_filter` plugin type and a config schema.

- **Enabling on a format, the `[video:...]` syntax, per-format & per-video settings** →
  [configure/filter.md](configure/filter.md)
- **The `video_filter` plugin type — writing a provider codec, `iframe()`/`html()`, regexp captures,
  `hook_video_filter_video_alter()`** → [plugins/codec.md](plugins/codec.md)

Submodule (own docs):
- `video_filter_example` (demo codec) →
  [../../modules/video_filter_example/1.0.x/agent/start.md](../../modules/video_filter_example/1.0.x/agent/start.md)

Key facts:
- Filter id `video_filter` (`TYPE_TRANSFORM_REVERSIBLE`); default settings `width=400`, `height=400`,
  `plugins = {youtube:1, vimeo:1}`, `allow_multiple_sources=TRUE`. Schema `filter_settings.video_filter`.
- ~48 built-in codecs in `src/Plugin/VideoFilter/` (YouTube, Vimeo, Dailymotion, Twitch, Spotify, …).
- Renders via Twig: `video-filter-iframe.html.twig` (`src`), `video-filter-html.html.twig`
  (`{{ video.html|raw }}`), deprecated `video-filter-flash.html.twig`.
- Ships a legacy CKEditor **4** plugin/dialog + `/video-filter/preview/{format}/{token}` route; CKEditor 4
  is gone in D11 so the WYSIWYG button is inert there, but the typed filter still works.
