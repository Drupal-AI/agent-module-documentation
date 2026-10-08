<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Filesystem: Audio Processor (advanced_filesystem_audio_processor) — agent index

FFmpeg/FFprobe audio processing for Drupal managed files: metadata probe, waveform PNG, trim,
convert, EBU R128 normalize, strip metadata, split channels. Submodule of Advanced FileSystem.
Package `Advanced Filesystem`. Core `^10 || ^11 || ^12`. Depends on core **`file`**, **`media`**,
and **`advanced_filesystem`**. Needs the `ffmpeg` + `ffprobe` binaries. Version 1.0.27.

- **Service API, operations, routes, config, tables, queue** →
  [api/audio-service.md](api/audio-service.md)

## What it provides

- **Service** `advanced_filesystem_audio_processor.service` → `Service\AudioProcessorService`.
- **Media source plugin** `Plugin\media\Source\AudioProcessorSource` (id `audio_processor`).
- **Queue worker** `adfs_audio_process` (drained by cron) — see the base module for the worker
  wiring; `hook_file_insert` enqueues `audio/*` uploads when `auto_process` is on.
- **Routes** (`*.routing.yml`, all `_permission: administer advanced_filesystem_audio_processor`):
  `.settings`, `.dashboard`, `.dashboard_clean` (+`_csrf_token`), `.dashboard_reprocess`
  (+`_csrf_token`), `.batch`, `.file_view` (`/admin/content/files/{file}/audio`),
  `.file_process`, `.audio_edit`, `.derivative_delete` (+`_csrf_token`), `.derivative_export`.
- **Controllers**: `AudioDashboardController`, `AudioFileViewController`,
  `AudioDerivativeDeleteController` (delete + export).
- **Forms**: `AudioSettingsForm`, `AudioBatchForm`, `AudioFileProcessForm`, `AudioEditForm`.
- **Permissions**: `administer advanced_filesystem_audio_processor` (restrict access),
  `process advanced_filesystem_audio_processor` (declared).
- **Config** object `advanced_filesystem_audio_processor.settings`: `ffmpeg_bin`, `ffprobe_bin`,
  `auto_process`, `waveform_width`, `waveform_height`, `waveform_color`, `clean_after_days`.
- **DB tables**: `adfs_audio_jobs` (job + extracted metadata, PK `fid`),
  `adfs_audio_derivatives` (per-operation outputs).
- **Hooks** (`*.module`): `hook_file_insert` (enqueue), `hook_file_download` (protect
  `private://adfs_audio_*` behind the admin perm), `hook_entity_operation` (adds the
  "Audio Processor" link on file rows).

## Mechanism (from source)

- `process($file)` = `probe()` (ffprobe JSON → duration/bitrate/sample_rate/channels/codec +
  tags) then `generateWaveform()` (ffmpeg `showwavespic`), upserting a row into `adfs_audio_jobs`.
- Derivative methods (`trim`, `convert`, `normalize`, `stripMetadata`, `extractChannels`) each
  build an ffmpeg command, run it, and record the output in `adfs_audio_derivatives` via
  `saveDerivative()`; `normalize()` is a two-pass loudnorm (measure JSON → apply).
- All shell commands `escapeshellcmd()` the binary and `escapeshellarg()` the file path and
  time/format arguments; waveform dimensions are integer-cast.

## Notes

- Waveform PNGs are written to `public://adfs_audio_waveforms/{fid}/`; derivatives to
  `public://adfs_audio_derivatives/{fid}/`.
- `getSystemStatus()` reports whether the configured binaries are executable.
