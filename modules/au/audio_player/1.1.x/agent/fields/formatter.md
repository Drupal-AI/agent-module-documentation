<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audio Player field formatters

Two formatters, same UI and render path, different source field type. Both in
`src/Plugin/Field/FieldFormatter/`.

| Class | id | label | extends | field_types |
|---|---|---|---|---|
| `AudioPlayerFieldFormatter` | `audio_player_field_formatter` | Audio Player | `FileFormatterBase` | `file`, `string`, `link` |
| `AudioPlayerMediaFieldFormatter` | `audio_player_mfield_formatter` | Media Audio Player | `EntityReferenceFormatterBase` | `entity_reference` |

## Enable / select

Enable the module (`drush en audio_player`). Then *Structure → Content types → {type} → Manage
display*: pick **Audio Player** for a File field, or **Media Audio Player** for a Media
entity-reference field pointing at the `audio` media bundle. There is no global settings form —
all configuration is the per-display formatter settings below.

## Settings (`defaultSettings`, `settingsForm`)

Defaults for both formatters:

```
skin => 'skin-one', audio_display => 'single-audio',
equalizer_effect => 'waveform', palette => 'default-palette'
```

- **skin** — single-audio skins (`audio_player_single_audio_skins()`, `skin-one`..`skin-eighteen`)
  when field cardinality is 1; playlist skins (`audio_player_audio_playlist_skins()`, `skin-one`/
  `skin-two`) otherwise.
- **audio_display** — only shown when cardinality != 1; options `''` (Single) / `audio-playlist`
  (Playlist). (Note the stored default `single-audio` is not one of the two form options.)
- **equalizer_effect** — only when cardinality != 1; from `audio_player_equalizer_options()`
  (~27 values; `''` = None). JS-hidden unless `audio_display == audio-playlist`.
- **palette** — from `audio_player_palette_options()` (`default-palette` + `palette-1`..`palette-20`).

The `audio_display`, `skin` and `palette` elements set `#access` to
`currentUser->hasPermission('administer image styles')` — i.e. only users with that core permission
see/edit them; others get the defaults. `settingsSummary()` prints display/equalizer/skin lines.

## Render mechanism (`viewElements`)

1. `getEntitiesToView($items, $langcode)` — honours core file/entity display access; returns
   File entities (file formatter) or Media entities (media formatter).
2. Media formatter only processes media of `bundle() == 'audio'`, then loads the source file via
   `$media->getSource()->getSourceFieldValue($media)` and the `file` storage.
3. For each file: `$file->getFileUri()`, then **`if ($file->access('view'))`** generate the URL
   with `fileUrlGenerator->generateAbsoluteString($uri)`; **else `return []`** (the whole element is
   dropped — no unauthorised track leaks). Cache tags merged from each file.
4. Track title = `basename(parse_url(...)['path'])` → `urldecode` → `Html::escape` (media formatter
   also runs `audio_player_generate_name()`, stripping the extension and non-alphanumerics and
   escaping). `original_url` is the parsed URL **path** only.
5. Resolves a template: `{$audio_display}/{$skin}` or `single-audio/{$skin}`, preferring an active
   theme override (`{theme}/templates/{layout}.html.twig`) over the module's
   (`@audio_player/{layout}.html.twig`).
6. Returns one `#theme => 'audio_player'` element with `#audios`, `#skin`, `#equalizer`, `#palette`,
   `#audio_display`, `#template_part`, cache tags. `template_preprocess_audio_player()`
   (in `audio_player.module`) attaches the base library plus the per-skin/equalizer/palette
   libraries; `templates/audio-player.html.twig` `{% include %}`s the resolved skin template.

## Notes for agents

- Only cardinality drives single-vs-playlist skin lists; `equalizer_effect`/`audio_display` are
  null for single-cardinality fields.
- The file formatter advertises `string`/`link` field types too, but the render path expects file
  entities from `getEntitiesToView()`; treat it as a File-field formatter in practice.
- Track URLs come from the managed-file URI, never from request or config input.
