# Field formatter: `islandora_file_audio`

`IslandoraFileAudioFormatter` (`src/Plugin/Field/FieldFormatter/IslandoraFileAudioFormatter.php`), extends core
`\Drupal\islandora\Plugin\Field\FieldFormatter\IslandoraFileMediaFormatterBase` (itself a subclass of Drupal
core's `FileMediaFormatterBase`).

- **id:** `islandora_file_audio` · **label:** "Audio with Captions" · **field type:** `file`
- **`getMediaType()`** returns `audio`, so it renders through core's `<audio>` HTML5 support.
- Adds nothing to the base settings form (unlike the video formatter's muted/width/height); settings schema is
  `field.formatter.settings.islandora_file_audio` → `field.formatter.settings.file_audio` (core's play/download,
  multiple-file, preload, etc.).

Assign it on a media type's **Manage display** for the file field you want played (e.g. an audio service-file field).

## Captions

The value over core's `file_audio`: the base formatter's `getTrackFiles()` scans the parent media for
`media_track` fields and emits `<track>` elements (src / `srclang` / `label` / `kind` / `default`). The template
`templates/islandora-file-audio.html.twig` (theme hook `islandora_file_audio`, vars `files`, `tracks`,
`attributes`) renders `<audio>` with `<source>` + `<track>` children and a `<div class="audioTrack">` caption box,
then attaches the `islandora_audio/audio` library.

`js/audio.js` (`Drupal.behaviors.islandora_audio_captions`) fetches the active track's WebVTT file, parses cues,
and on `timeupdate` writes the current cue's text into `div.audioTrack` — audio has no visual frame, so captions
are shown in that box instead of on the media. Library deps: `core/drupal`, `core/drupalSettings`.
