<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audio Clips (audio_clips) — agent index

Developer **API** that trims a segment out of an MP3/WAV file with the **FFmpeg CLI** and stores
it as a revisionable `audio_clip` content entity. Package **Audio**. Core `^10.1 || ^11`, license
GPL-2.0-or-later, version 2.2.0. Requires the external **ffmpeg + ffprobe** binaries; uses core
**`file`**. Ships **no controllers, blocks, fields, widgets, or Drush** — it is a backend for
higher-level tools (e.g. Audio Wavesurfer Clips). `configure` route: `audio_clip.overview_types`.

- **The service API — create/update clips, AudioFile/ffmpeg operations** → [api/service.md](api/service.md)
- **Clip types (config bundle), routes, permissions, entities, storage** → [config/clip-types.md](config/clip-types.md)

## What it provides (from source)

- **Content entity `audio_clip`** (`src/Entity/AudioClip.php`): base_table `audio_clip`, revisionable,
  translatable, bundle = `audio_clip_type`. Base fields include `original_id` (source file id),
  `target_id` (clip file id), `start_time`, `end_time` (seconds), plus revision metadata.
  `preDelete()` deletes the referenced clip `File`.
- **Config bundle entity `audio_clip_type`** (`src/Entity/AudioClipType.php`): exports
  `id, label, description, min_duration, max_duration`; `postSave()`/`preDelete()` create/remove a
  `public://audio_clip/clip_<id>` directory.
- **Services**: `audio_clip.audio_clip_service` → `Services\AudioClipService` (create/update clips);
  `audio_clips.audio_file_factory` → `FFMpeg\AudioFileFactory` → builds `FFMpeg\AudioFile` (runs
  ffmpeg/ffprobe via Symfony `Process`).
- **Permission**: `administer audio clip types` (`audio_clips.permissions.yml`).
- **Routes** (`audio_clips.routing.yml`, all admin): `audio_clip.overview_types`,
  `audio_clip.type_add`, `entity.audio_clip_type.edit_form`, `entity.audio_clip_type.delete_form`
  under `/admin/config/media/audio-clips/…`.
- **Config schema**: `audio_clips.type.*` (`config/schema/audio_clips.schema.yml`).
- **hook_help**: `src/Hook/Help.php` (OOP `#[Hook('help')]`).
