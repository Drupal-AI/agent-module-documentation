<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AudioPrepareClipService

Service id `audio_wavesurfer_clips.audio_prepare_service` (`audio_wavesurfer_clips.services.yml`).
`src/Services/AudioPrepareClipService.php`.

Constructor args: `@entity_type.manager` (→ `audio_clip` storage), `@current_user`, `@file_system`,
`@file.usage`, `@audio_clip.audio_clip_service` (the Audio Clips API service), and
`@audio_wavesurfer.waveform_json_service` (parent module's peak generator).

## `buildAudioClipToEntity(EntityInterface $entity): void`

Called from `audio_wavesurfer_clips_media_insert()` / `_update()` for `audio`-bundle media.

1. Reads `waveform_options.waveform_storage` from `audio_wavesurfer.settings`.
2. Requires `$entity->field_media_audio_file` (throws if NULL).
3. For each file item, reads the widget-submitted `$item->audio_wavesurfer_clip['clips']` array; for
   each `clip_name => clip_attributes` (skips non-array entries — tab metadata):
   - Extract `start_time` / `end_time`.
   - Entity-query `audio_clip` for `original_id == fid` and `type == clip_name` (`accessCheck TRUE`).
   - **If none exists:** `audioClipService->createAudioClip($fid, $clip_name, $start_time, $end_time)`
     (Audio Clips does the FFmpeg cut); if `waveform_storage`, generate peaks for the new clip file
     via `waveformJsonService->buildWaveformJson($clip_target_fid)`.
   - **If it exists** and the times changed: `audioClipService->udpateAudioClip(...)` (sic — method
     name is misspelled in the API), then optionally regenerate the clip's stored waveform.

So the actual clip creation, storage entity (`audio_clip`) and audio cutting all live in the
`audio_clips` module; this service is the glue that turns the widget's submitted region times into
create/update calls on media save.

## Access / safety notes

- No routes or controllers are added by this module — there is no custom endpoint to authorize.
  Clip create/update runs inside the standard media save flow, so it inherits media/field **edit
  access** (an editor who can save the audio media item). There is no separate anonymous or GET-based
  mutation path.
- All entity queries use `->accessCheck(TRUE)`.
- Clip time values are numeric slider inputs; they are handed to the `audio_clips` API, not
  concatenated into any query or shell string here.

There is a housekeeping `@todo`: file usage is not registered (commented `fileUsage->add(...)`) and
the media delete hook does not clean up clips/waveforms — an orphan-cleanup gap, not a security issue.
