<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Audio Clips is a developer API that cuts a time-bounded clip out of an MP3 or WAV file with the FFmpeg CLI and stores it as a revisionable `audio_clip` content entity.

---

Audio Clips (package "Audio") provides an API — not an end-user UI — for creating clips from audio files. An administrator defines one or more Audio Clip **types** (config entity bundles) at `/admin/config/media/audio-clips/types`, each optionally constrained by a minimum/maximum duration in seconds. Other code then calls `AudioClipService::createAudioClip()` / `updateAudioClip()` (or instantiates `AudioFile` directly) to run `ffmpeg`/`ffprobe`, write the trimmed file under `public://audio_clip/…`, register it as a managed `file` entity, and record a revisionable `audio_clip` entity holding the source file id, clip file id, and start/end times. The module ships no controllers, blocks, fields, or Drush; it is meant to back higher-level tools such as the Audio Wavesurfer Clips sub-module. It requires the FFmpeg (ffmpeg + ffprobe) command-line binaries on the server or container.

---

- Trim a long recording down to a short excerpt (e.g. seconds 10–25) and save it as a managed file.
- Build a library of reusable sound effects or audio snippets as `audio_clip` entities.
- Generate podcast teaser clips programmatically from a full episode MP3.
- Cut named highlight segments out of a WAV interview for downstream playback.
- Provide the storage/processing backend for a visual waveform clip editor (Audio Wavesurfer Clips).
- Organise clips into categories via Audio Clip **types** (e.g. "intro", "teaser", "ringtone").
- Enforce a minimum clip length per type so editors cannot save clips that are too short.
- Enforce a maximum clip length per type to cap excerpt duration (e.g. 30-second previews).
- Programmatically re-clip an existing entity with new start/end times, creating a new revision.
- Keep a revision log of clip edits, including which user changed the start time.
- Read an audio file's total duration in seconds via `AudioFile::getAudioDuration()` (ffprobe).
- Detect an audio file's container format via `AudioFile::getAudioFormat()` (ffprobe).
- Auto-delete a clip's generated file when the `audio_clip` entity is deleted.
- Auto-provision and clean up per-type storage directories under `public://audio_clip/clip_<type>`.
- Expose clip start/end times and source/target file ids to other modules through base fields.
- Back a REST or JSON:API endpoint over the `audio_clip` content entity for headless audio delivery.
- Serve short audio previews on a node without exposing the full source file.
- Support multilingual sites — the `audio_clip` entity is translatable.
- Restrict who can manage clip types with the `administer audio clip types` permission.
- List and compare configured clip types (name, description, min/max duration) on one admin table.
- Integrate FFmpeg-based transcoding/trimming into a custom import or migration pipeline.
- Store the original source file id alongside each clip for traceability back to its parent audio.
