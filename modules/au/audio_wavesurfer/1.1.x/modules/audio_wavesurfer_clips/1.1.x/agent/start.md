<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audio Wavesurfer Clip (audio_wavesurfer_clips) — agent index

Sub-module of **audio_wavesurfer**. Adds a field **widget** + a **form element** that overlay
draggable clip **regions** on the wavesurfer waveform, and a **clip formatter**. Clip persistence,
clip-type definitions and the FFmpeg cutting come from the required **`audio_clips`** (Audio Clips
API) module — this module only wires that API to the wavesurfer regions UI. Package `Audio`. Core
`^10 || ^11`. GPL-2.0-or-later. Version 1.1.4. No routes, no permissions, no Drush, no config
schema.

Dependencies (`audio_wavesurfer_clips.info.yml`): `audio_clips:audio_clips`,
`audio_wavesurfer:audio_wavesurfer`.

- **Widget, form element, clip formatter, and how clips are saved** → [fields/widget.md](fields/widget.md)
- **`AudioPrepareClipService` (create/update audio_clip on media save)** → [api/clip-service.md](api/clip-service.md)
- Parent module index → [../../../agent/start.md](../../../agent/start.md)

## What it provides (from source)

- **Widget** `AudioWavesurferClipWidget` (id `audio_wavesurfer_clip_widget`, `field_types: [file]`),
  `src/Plugin/Field/FieldWidget/AudioWavesurferClipWidget.php`, extends core `FileWidget`. Settings
  form adds a multi-select `audio_clip_type` (options from `AudioClipType::getClipTypeNames()`).
- **Formatter** `AudioWavesurferClipFormatter` (id `audio_wavesurfer_clip_formatter`,
  `field_types: [file]`), extends the parent `AudioWavesurferFormatter`. Adds one setting,
  `audio_clip_type_display`, to render a chosen clip type instead of the original file.
- **Form element** `#[FormElement('audio_wavesurfer_clip')]` — `src/Element/AudioWavesurferClip.php`,
  extends `FormElementBase`. Builds the player (`#theme => audio_file__wavesurfer`) + horizontal
  tabs, one `details` per clip type with `start_time`/`end_time` `range` sliders.
- **Service** `audio_wavesurfer_clips.audio_prepare_service` → `AudioPrepareClipService`
  (`src/Services/AudioPrepareClipService.php`); args: `@entity_type.manager`, `@current_user`,
  `@file_system`, `@file.usage`, `@audio_clip.audio_clip_service`,
  `@audio_wavesurfer.waveform_json_service`.
- **Hooks** (`audio_wavesurfer_clips.module`): `hook_library_info_build` (builds
  `wavesurfer_regions` from the configured `library_path`/CDN + `plugins/regions.esm.js`);
  `media` insert/update → `audio_prepare_service->buildAudioClipToEntity($entity)`; delete hook is a
  `@todo` no-op.
- **Libraries** (`audio_wavesurfer_clips.libraries.yml`): `audio_clip` (`js/audio_clip.js`) and
  `wavesurfer_regions` (`js/wavesurfer_library_regions.js` + external regions ESM).

## Data flow

1. On the audio media **form display**, set the "Audio Wavesurfer Clip Widget" on the file field and
   pick which clip type(s) to enable.
2. The widget loads the file, computes duration via `audio_clips`' `AudioFile` (FFmpeg), queries any
   existing `audio_clip` rows for this file, and renders an `audio_wavesurfer_clip` element; the
   element draws region sliders and attaches the `audio_wavesurfer_clips/audio_clip` library.
3. On save, the media insert/update hook calls `AudioPrepareClipService::buildAudioClipToEntity()`,
   which reads submitted `clips[type][start_time|end_time]` and creates/updates `audio_clip`
   entities through `AudioClipService` (and regenerates stored waveforms when enabled).
4. `AudioWavesurferClipFormatter` can display one clip type by loading its `audio_clip` and swapping
   the player's file URL/id to the clipped file.

No routes/permissions of its own — access is governed by media/field edit access and by `audio_clips`.
