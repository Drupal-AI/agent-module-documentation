<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audio Wavesurfer (audio_wavesurfer) — agent index

A field formatter that renders a **media `audio`** file as an interactive **wavesurfer.js** waveform
player, plus an optional **FFmpeg** ("Waveform Storage") mode that pre-computes peaks server-side.
Package `Audio`. Depends on core **`media`**. Core `^10 || ^11`. License GPL-2.0-or-later.
Version 1.1.4. No permissions of its own, no Drush, no config schema/install (config is created by
the settings form).

- **Settings form, config object keys, library loading (CDN vs local), FFmpeg** →
  [config/settings.md](config/settings.md)
- **The formatter, the theme/template, drupalSettings passed to JS** → [fields/formatter.md](fields/formatter.md)
- **`waveform` entity + `WaveformJsonService` (peak generation with ffprobe)** → [api/waveform-service.md](api/waveform-service.md)
- **Sub-module** `audio_wavesurfer_clips` (clip-region widget/UI) is documented in its own tree:
  [../modules/audio_wavesurfer_clips/1.1.x/agent/start.md](../modules/audio_wavesurfer_clips/1.1.x/agent/start.md)

## What it actually provides (from source)

- **1 field formatter** `AudioWavesurferFormatter` (id `audio_wavesurfer_formatter`, targets
  `field_types: [file]`), in `src/Plugin/Field/FieldFormatter/AudioWavesurferFormatter.php`. It
  extends `EntityReferenceFormatterBase` and `isApplicable()` limits it to `entity_type === 'media'
  && bundle === 'audio'`.
- **1 config form** `AudioWavesurferForm` (`src/Form/AudioWavesurferForm.php`, `ConfigFormBase`) at
  route `audio_wavesurfer.settings` → `/admin/config/audio_wavesurfer/settings`, permission
  **`administer site configuration`** (routing.yml). Menu link under Configuration → Media
  (`audio_wavesurfer.links.menu.yml`). Writes config object **`audio_wavesurfer.settings`**.
- **1 content entity** `waveform` (`src/Entity/Waveform.php`, `ContentEntityType`, base_table
  `waveform`) with base fields `id`, `audio_fid`, `waveform_fid`. Stores the mapping audio-file →
  generated-peaks-file. No routes/handlers/UI.
- **1 service** `audio_wavesurfer.waveform_json_service` → `WaveformJsonService`
  (`src/Services/WaveformJsonService.php`); constructor arg `@entity_type.manager`.
- **Hooks** (`audio_wavesurfer.module`): `hook_theme` (`audio_file__wavesurfer` →
  `templates/audio-file--wavesurfer.html.twig`); `hook_library_info_build` (builds the `wavesurfer`
  library from the configured `library_path` or the jsDelivr CDN); `hook_page_attachments` (adds
  `drupalSettings.audio_wavesurfer.library_path`); `media` insert/update → `audio_wavesurfer_build_waveform()`
  which calls the service when `waveform_storage` is on (delete hook is a `@todo` no-op).
- **Libraries** (`audio_wavesurfer.libraries.yml` + dynamic build): `audio` (js/audio.js as ES
  module) and `wavesurfer` (js/wavesurfer_library.js + external `wavesurfer.esm.js` and
  `plugins/hover.esm.js`).

## Data flow

1. Editor sets the formatter on `media.audio` display; formatter loads the `File`, builds a
   `#theme => 'audio_file__wavesurfer'` element with the file URL/id, attaches `audio_wavesurfer/audio`,
   and puts color/bar options (and stored peaks when enabled) into `drupalSettings`.
2. `js/audio.js` (`Drupal.behaviors.audioBehavior`) reads `drupalSettings` and instantiates the
   `AudioWavesurfer` class from `js/wavesurfer_library.js`, which dynamically `import()`s the
   wavesurfer ESM build and renders the player. Colors/bars are used as CSS/JS parameter values only.
3. If "Waveform Storage" is on, saving an `audio` media item triggers `WaveformJsonService::buildWaveformJson($fid)`,
   which runs `ffprobe`/`ffmpeg` (`amovie … astats`) to compute peaks, writes a `<name>.json`
   sidecar next to the audio file, creates a managed `File` + `waveform` entity, and (with "Waveform
   Usage" on) those peaks are attached to the formatter output.

No permissions, no Drush commands, no plugin types, no config schema files.
