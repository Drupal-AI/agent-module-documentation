<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Filesystem: Video Processor (advanced_filesystem_video_processor) — agent index

FFmpeg/FFprobe video processing for Drupal managed files: metadata probe, thumbnails, HLS,
sprites, and a large derivative set (trim, resize, crop, watermark, GIF, subtitles, convert,
speed, contact sheet). Submodule of Advanced FileSystem. Package `Advanced Filesystem`. Core
`^10 || ^11 || ^12`. Depends on core **`file`**, **`media`**, **`advanced_filesystem`**. Needs
`ffmpeg` + `ffprobe`. Version 1.0.27.

- **Service API, all operations, routes, config, tables, queue** →
  [api/video-service.md](api/video-service.md)

## What it provides

- **Service** `advanced_filesystem_video_processor.service` → `Service\VideoProcessorService`.
- **Queue worker** `Plugin\QueueWorker\VideoQueueWorker` (id `adfs_video_process`, cron time 120)
  → `service->process($file)`. `hook_file_insert` enqueues `video/*` uploads when `auto_process`.
- **Media source plugin** `Plugin\media\Source\VideoProcessorSource` (id `video_processor`).
- **Routes** (`*.routing.yml`, all `_permission: administer advanced_filesystem_video_processor`):
  `.settings`, `.dashboard`, `.dashboard_clean`, `.dashboard_reprocess`, `.batch`, `.file_view`
  (`/admin/content/files/{file}/video`), `.file_process`, `.video_edit`, `.video_compare`,
  `.derivative_delete`, `.derivative_export`.
- **Controllers**: `VideoDashboardController`, `VideoFileViewController` (HTML5 player + metadata),
  `VideoCompareController`, `VideoDerivativeDeleteController` (delete + export).
- **Forms**: `VideoSettingsForm`, `VideoBatchForm`, `VideoFileProcessForm`, `VideoEditForm`.
- **JS**: `js/video_player.js`, `js/video_editor.js` (library
  `advanced_filesystem_video_processor/video_player`).
- **Permissions**: `administer advanced_filesystem_video_processor` (restrict access),
  `process advanced_filesystem_video_processor` (declared).
- **Config** object `advanced_filesystem_video_processor.settings` (install defaults +
  schema): `ffmpeg_bin`, `ffprobe_bin`, `thumbnail_second`, `thumbnail_width`,
  `generate_thumbnail`, `generate_hls`, `hls_resolutions[]`, `generate_sprites`,
  `sprite_interval`, `auto_process`, `max_file_size_mb`, `output_dir` (default
  `private://adfs_video_output`).
- **DB tables**: `adfs_video_jobs` (PK `fid`), `adfs_video_derivatives`
  (created via `hook_update_8001`).
- **Hooks** (`*.module`): `hook_file_insert` (enqueue), `hook_file_download` (deny
  `private://adfs_video_output` / `…_derivatives` unless admin), `hook_entity_operation`
  (adds Video Info/Process/Edit/Compare links to file rows).

## Mechanism (from source)

- `process($file)` = size check → `probe()` (ffprobe JSON) → thumbnail → optional HLS → optional
  sprites, upserting `adfs_video_jobs`.
- Each derivative method (`trim`, `resize`, `cropWithFocus`, `extractThumbnailAtTime`,
  `addWatermark`, `extractAudio`, `embedSubtitles`, `convertFormat`, `changeSpeed`,
  `convertToGif`, `normalizeAudio`, `generateContactSheet`, `extractSubtitleStream`) builds an
  ffmpeg command with `exec()`, checks the output file, and records a row via
  `saveDerivative()`/`derivativeError()`.
- All commands `escapeshellarg()` the binary and every file path (and `-ss`/`-to`/time args);
  dimensions, fps, crop coords and speed are int/float-cast or derived from probe data.
- `probe()` short-circuits when the configured binary is not `is_executable()`.

## Notes

- Dashboard clean/reprocess and derivative delete/export are `_controller` GET routes; each
  controller validates a per-action `csrf_token` (`adfs-video-clean`/`-repro`/`-del-{did}`/
  `-exp-{did}`) internally, and the dashboard renders the tokenised links with a JS `confirm()`.
- Some controller/service strings and messages are in Portuguese.
