<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audio Wavesurfer Formatter

`AudioWavesurferFormatter` — `src/Plugin/Field/FieldFormatter/AudioWavesurferFormatter.php`.

```php
#[FieldFormatter(
  id: 'audio_wavesurfer_formatter',
  label: 'Audio Wavesurfer Formatter',
  field_types: ['file'],
)]
class AudioWavesurferFormatter extends EntityReferenceFormatterBase
```

## Applicability

`isApplicable(FieldDefinitionInterface $field_definition)` returns TRUE **only** when
`entity_type === 'media' && bundle === 'audio'`. So although `field_types` is `file`, the formatter
only appears on the file field of the **`audio` media bundle**. Enable at
`/admin/structure/media/manage/audio/display` by choosing "Audio Wavesurfer Formatter" as the format
(README).

## viewElements()

For each field item:

1. Loads `File::load($item->target_id)` and resolves the URL with
   `file_url_generator->generateString($file->getFileUri())`.
2. Builds a render element:
   ```php
   $element[$delta] = [
     '#theme' => 'audio_file__wavesurfer',
     '#file_upload_url' => $audio_file_path,
     '#file_upload_id' => $audio_fid,
     '#attached' => ['library' => ['audio_wavesurfer/audio']],
   ];
   ```
3. If `waveform_options.waveform_usage` is on, fetches stored peaks via
   `audio_wavesurfer.waveform_json_service->getAudioWaveformStored($audio_fid)` and, when non-empty,
   attaches them as `drupalSettings.audio_wavesurfer.waveform_peaks`.
4. Always attaches the configured colors/bars as
   `drupalSettings.audio_wavesurfer.options = { color_options, bar_options }`.

There is **no settings form / defaultSettings** on this base formatter (the sub-module's clip
formatter adds one). No per-display configuration.

## Template & theme hook

`hook_theme` (`audio_wavesurfer.module`) registers `audio_file__wavesurfer` with variables
`file_upload_id`, `file_upload_url`, `waveform_file_url`. Template
`templates/audio-file--wavesurfer.html.twig` outputs:

```
<div class="audio-waveform-container" data-path-audio="{{ file_upload_url }}" data-id-audio="{{ file_upload_id }}">
  … play button …
  <div id='id-{{ file_upload_id }}' class="waveform"> … time / duration … </div>
</div>
```

The audio URL and id go into `data-*` attributes (Twig auto-escaped). All wavesurfer options reach
the browser as JSON via `drupalSettings`.

## Front-end wiring

- `audio_wavesurfer/audio` library → `js/audio.js`. `Drupal.behaviors.audioBehavior` runs `once`
  per `.audio-waveform-container`, reads `drupalSettings.audio_wavesurfer.waveform_peaks` and
  `.options`, and calls `new AudioWavesurfer(element, waveFormPeaks, options)`.
- `js/wavesurfer_library.js` defines `AudioWavesurfer`, dynamically `import()`s the wavesurfer +
  hover ESM builds, and creates the player. Colors are applied as CSS/`waveColor`/`progressColor`
  values; bar values pass through `parseInt`. Peaks (when supplied) become `wavesurfer.peaks` with a
  `new Audio(pathAudio)` media element. Only one player plays at a time (static `currentPlayer`).
