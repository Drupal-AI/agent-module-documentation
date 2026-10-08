<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views style: Audio Player playlist

`ViewsAudioPlayer` — `src/Plugin/views/style/ViewsAudioPlayer.php`, extends `StylePluginBase`.

```
@ViewsStyle(
  id = "audio_player",
  title = "Audio Player",
  help = "Display the results as a audio player.",
  theme = "views_audio_player",
  display_types = {"normal"}
)
```

Flags: `usesRowPlugin = TRUE`, `usesRowClass = TRUE`, `usesFields = TRUE`, `usesGrouping = FALSE`.

## Use

In a View, set the display **Format → Style** to *Audio Player*. Add the view fields you want to
map, then in the style settings map them to the player. Rows become a single playlist.

## Options (`defineOptions` / `buildOptionsForm`)

| Option | Default | Meaning |
|---|---|---|
| `equalizer_effect` | `waveform` | from `audio_player_equalizer_options()` |
| `skin` | `skin-two` | playlist skins (`audio_player_audio_playlist_skins()`) |
| `palette` | `palette-1` | from `audio_player_palette_options()` |
| `audio_player_title` | `''` | view field → track title |
| `audio_player_subtitle` | `''` | view field → track subtitle |
| `audio_player_video` | `''` | view field → **audio source** (required for a track to render) |
| `audio_player_thumbnail` | `''` | view field → thumbnail (only visible when `skin == skin-two`) |

Field selects are built from `getNonExcludedFields()` (view field handlers whose `exclude` option
is empty). `validateOptionsForm`/`submitOptionsForm` are empty stubs.

## Preprocessing (`audio_player.module`)

`audio_player_preprocess_views_view()` runs when `$view->style_plugin instanceof ViewsAudioPlayer`:

- For each result row, `audio_player_get_field_url()` resolves the `audio_player_video` field's
  first item. If it references a **File** entity → `audio_player_generate_file_url()`; if a
  **Media** entity → loads the source file id and generates the URL. `audio_player_generate_file_url()`
  only returns a URL when the file MIME type is one of `audio/mpeg`, `audio/wav`, `audio/flac`
  (else logs and returns NULL); it uses `fileUrlGenerator->generateAbsoluteString($uri)`.
- Title/subtitle come from the mapped entity fields, each wrapped in `Html::escape`; a missing
  title falls back to `urldecode(basename($url))`, then `audio_player_generate_name()`.
- Rows with no resolvable URL are logged (`No valid URL found...`) and skipped.
- Attaches libraries `playlist-color-palettes`, `base`, `audio-playlist.{skin}`, plus `equalizer`
  when an effect is set. Sets `#cache = ['max-age' => 0]` (the style output is uncacheable).

`template_preprocess_views_audio_player()` resolves the `audio-playlist/{skin}.html.twig` template
(theme override preferred over module) into `template_part`; `templates/views-audio-player.html.twig`
builds the `audios` array from `row['#row']` and `{% include %}`s the skin template.

## Notes

- Access to referenced files is not re-checked in this path the way the formatters do
  `$file->access('view')`; row access is whatever the view's own access/filters enforce, and only
  the three audio MIME types produce a URL.
- Titles/subtitles are `Html::escape`d before reaching the Twig playlist, and Twig autoescape
  applies again in the templates.
