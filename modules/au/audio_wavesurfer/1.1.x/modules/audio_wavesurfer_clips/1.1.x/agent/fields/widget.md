<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Widget, form element & clip formatter

## Enable

```
drush en audio_wavesurfer_clips -y
```

Pulls in `audio_clips` (Audio Clips API) and `audio_wavesurfer`. Define clip types first at
`/admin/config/media/audio-clips/types` (min/max duration set the clip length constraints).

## Widget — `AudioWavesurferClipWidget`

`src/Plugin/Field/FieldWidget/AudioWavesurferClipWidget.php`, extends core `FileWidget`.

```php
#[FieldWidget(id: 'audio_wavesurfer_clip_widget', field_types: ['file'])]
```

- `defaultSettings()`: `audio_clip_type => []`.
- `settingsForm()`: adds a multi `#type => select` `audio_clip_type`, options from
  `AudioClipType::getClipTypeNames()` — which clip types this widget instance offers.
- `formElement()`: after `parent::formElement()`, resolves the uploaded file id (from the item or
  `form_state`'s `field_media_audio_file[0][fids][0]`), loads the `File`, builds an `audio_clips`
  `AudioFile` on the real path to get `getAudioDuration()`, prepares the selected clip types
  (`prepareAudioClipType()` → label + min/max duration from `AudioClipType::getAllClipType()`),
  entity-queries existing `audio_clip` rows for `original_id == fid` and `type IN (selected)`, then
  attaches an `audio_wavesurfer_clip` element with `#audio_clip_type`, `#audio_clip_storage`
  (existing clips by type), `#file_upload_id`, `#file_upload_url`, `#file_upload_duration`.

Set it at `/admin/structure/media/manage/audio/form-display` on the audio file field.

## Form element — `audio_wavesurfer_clip`

`src/Element/AudioWavesurferClip.php`, `#[FormElement('audio_wavesurfer_clip')]`, extends
`FormElementBase`. `#tree => TRUE`. `processAudioClipActions()` builds:

- `audio_player` = `#theme => 'audio_file__wavesurfer'` (reusing the parent template) with the
  `audio_wavesurfer_clips/audio_clip` library attached.
- `clips` = `#type => 'horizontal_tabs'`; for each clip type a `details` group with two `range`
  inputs `start_time` / `end_time` (`#min => 0`, `#max => file duration`, `#step => 1`). Defaults
  come from stored clip values or fall back to `0` / `max_duration` (or `duration/2` when the type
  has no max). Data attributes `data-clip-min-duration` / `data-clip-max-duration` feed the JS
  region logic.

The JS (`js/audio_clip.js` → `AudioWaveSurferRegion` from `js/wavesurfer_library_regions.js`) draws
the draggable regions synced to those sliders.

## Formatter — `AudioWavesurferClipFormatter`

`src/Plugin/Field/FieldFormatter/AudioWavesurferClipFormatter.php`, **extends the parent**
`AudioWavesurferFormatter` (so it too is media/`audio`-only).

- `defaultSettings()`: `audio_clip_type_display => ''`.
- `settingsForm()`: a `select` (`audio_clip_type_display`) with an empty option "None (original
  audio)" and clip-type options.
- `viewElements()`: calls the parent, then if a clip type is selected, entity-queries the
  `audio_clip` for `type == clip` and `original_id == fid`, loads it, and swaps the element's
  `#file_upload_url`/`#file_upload_id` to the clipped file (re-attaching stored peaks when Waveform
  Usage is on). With no clip type, it renders the original audio.

All queries use `->accessCheck(TRUE)`. Clip data reaches JS only through the parent formatter's
`drupalSettings` (colors/bars/peaks as JSON) and via Twig-escaped `data-*` attributes.
