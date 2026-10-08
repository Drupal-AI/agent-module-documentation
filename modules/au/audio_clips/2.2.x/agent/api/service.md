<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audio Clips — service API (creating clips, ffmpeg operations)

This module exposes **no HTTP endpoint** for clip creation. You drive it from your own PHP
(a module, form submit handler, queue worker, migration, etc.). Requires the **ffmpeg** and
**ffprobe** binaries on `PATH`.

## Services

- `audio_clip.audio_clip_service` → `Drupal\audio_clips\Services\AudioClipService`
- `audio_clips.audio_file_factory` → `Drupal\audio_clips\FFMpeg\AudioFileFactory`
  (also aliased to the class name; both autowired, see `audio_clips.services.yml`)

## AudioClipService (`src/Services/AudioClipService.php`)

Constructor deps (autowired): `entity_type.manager`, current user, `file_system`,
`file.usage`, `AudioFileFactory`. It caches the `audio_clip` storage handler.

```php
$service = \Drupal::service('audio_clip.audio_clip_service');

// Create: cuts $fid between $start_time..$end_time (seconds) and stores an audio_clip entity.
$clip = $service->createAudioClip(
  int $fid,          // source managed-file id (an MP3/WAV File entity)
  string $clip_name, // used as the bundle/type AND part of the output directory name
  int $start_time,   // seconds
  int $end_time,     // seconds
);

// Update: re-clips and saves a NEW revision on an existing AudioClip.
$service->updateAudioClip($fid, $clip_name, $start_time, $end_time, AudioClip $audio_clip);
```

`createAudioClip()` flow:
1. `createAudioFileEntity($fid, …)` — `File::load($fid)` (throws `EntityStorageException` if
   missing), resolves the real path with `file_system->realpath($file->getFileUri())`, then
   `audioFileFactory->create($path)->buildClipAudio($start, $end, $clip_name)`.
2. Saves the trimmed output as a new managed `File` (`status => 1`).
3. Creates the `audio_clip` entity with `type => $clip_name`, `original_id => $fid`,
   `target_id => <clip file id>`, `start_time`, `end_time`, and `save()`s it.

Note: `type` is set to `$clip_name`, so `$clip_name` must be an existing `audio_clip_type`
machine name for the bundle reference to resolve. `updateAudioClip()` sets `start_time`,
`end_time`, `entity_id`, `uri`, marks a new revision, and writes a revision log
("Change start_time to …") attributed to the current user.

## AudioFile (`src/FFMpeg/AudioFile.php`)

Low-level wrapper for operating on a single audio file; build it via the factory
(`AudioFileFactory::create($path)`) so `FileSystemInterface` is injected. Constructor throws
`\InvalidArgumentException` if the path does not exist.

- `buildClipAudio(int $start, int $end, string $clip_name): string` — prepares
  `public://audio_clip/clip_<clip_name>/public/<Y-m>/`, computes a non-clobbering destination
  filename (`getDestinationFilename(..., FileExists::Replace)`), runs the clip, returns the
  `public://…` path.
- `processClipAudio()` (private) runs `ffmpeg -y -i <path> -ss <start> -to <end> -c copy <out>`
  via Symfony `Process` (**array argv, no shell**) with `mustRun()`. `-c copy` stream-copies, so
  cuts land on keyframe boundaries (no re-encode).
- `getAudioDuration(): float` — `ffprobe … format=duration` → seconds.
- `getAudioFormat(): string` — `ffprobe … format=format_name` → container name.
- `setPath(string $path): static` — swap the target file (re-validates existence).

Any ffmpeg/ffprobe failure surfaces as a Symfony `ProcessFailedException`.

## Gotchas

- The two undeclared admin permissions on the entity annotations (`administer audio clip` on the
  content entity, `administer clip types` on the config entity) do not exist in
  `permissions.yml`, so those `admin_permission` grants fail closed. The real, working permission
  is `administer audio clip types` (edit-form route) — see [../config/clip-types.md](../config/clip-types.md).
- Only MP3 and WAV are supported/tested. The source `$fid` must be a saved managed file.
