<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VideoProcessorService — operations, routes, config, tables

## Install & enable

```bash
drush en advanced_filesystem_video_processor -y
```

Requires core `file`, `media`, the base `advanced_filesystem` module, and the system `ffmpeg`
and `ffprobe` binaries. Configure at `/admin/config/media/advanced_filesystem/video-processor`.

## Service: `advanced_filesystem_video_processor.service` (`Service\VideoProcessorService`)

Constructor args: `@config.factory`, `@database`, `@file_system`, `@logger.factory`.

### Pipeline

`process(FileInterface $file)` reads config, enforces `max_file_size_mb`, `probe()`s metadata,
then (per config flags) extracts a thumbnail, generates HLS and/or a sprite sheet, and upserts
`adfs_video_jobs`. Invoked by the `adfs_video_process` queue worker on cron and by the
per-file/batch forms.

| Method | ffmpeg operation |
|---|---|
| `probe(string $realPath): ?array` | `-show_format -show_streams` JSON (guarded by `is_executable`). |
| `extractThumbnail($file, $realPath, int $second=5): ?string` | single frame → jpg, scaled to `thumbnail_width`. |
| `generateHls($file, $realPath): ?string` | multi-resolution HLS from `hls_resolutions`, master `m3u8`. |
| `generateSprites($file, $realPath): ?string` | `fps=1/interval,scale,tile` sprite sheet. |
| `extractThumbnailAtTime($file, string $time): array` | frame at a timestamp; also updates the job thumbnail. |
| `trim($file, string $start, string $end): array` | `-ss/-to -c copy`. |
| `resize($file, int $w, int $h, bool $keepAspect=TRUE): array` | `scale=w:h` (`-2` keeps aspect). |
| `cropWithFocus($file, int $w, int $h, float $fx, float $fy): array` | probe dims → `crop=w:h:x:y` around a focal %. |
| `addWatermark($file, string $watermarkPath, string $pos='bottomright'): ?string` | `overlay` from a position map. |
| `addWatermarkDerivative($file, string $watermarkUri, string $pos): array` | resolves URI then records a derivative. |
| `extractAudio($file, string $format='mp3', int $bitrate=192): array` | `-vn -acodec …`. |
| `embedSubtitles($file, string $srtUri, bool $hardSub=TRUE): array` | burn-in (`subtitles=`) or mux (`mov_text`). |
| `convertFormat($file, string $target='mp4'): array` | codec map per container. |
| `changeSpeed($file, float $speed=2.0): array` | `setpts` + chained `atempo`. |
| `convertToGif($file, string $start, string $duration, int $fps=10, int $width=480): array` | palettegen + paletteuse. |
| `normalizeAudio($file, float $lufs=-23.0): array` | `loudnorm` with `-c:v copy`. |
| `generateContactSheet($file, int $cols=5, int $rows=4, int $thumbW=240): array` | `fps,scale,tile` grid. |
| `extractSubtitleStream($file, int $streamIndex=0): array` | `-map 0:s:{i}` → srt. |
| `getJob(int $fid) / getDerivatives(int $fid) / getStats()` | reads/aggregates job + derivative rows. |
| `getSystemStatus()` | `is_executable()` for ffmpeg/ffprobe. |

Derivative outputs default under `output_dir` (`private://adfs_video_output/…`); thumbnails,
hls, sprites, derivatives, audio, gif, subtitles and contact_sheets each get a subdirectory.
`saveDerivative()` writes a `done` row; `derivativeError()` writes a `failed` row and logs.

## Auto-processing, queue & download protection

- `hook_file_insert`: when `auto_process` and MIME `video/*`, enqueue `adfs_video_process`.
- `VideoQueueWorker` (id `adfs_video_process`, `cron time 120`) → `service->process($file)`.
- `hook_file_download`: deny (`-1`) URIs under `private://adfs_video_output` or
  `private://adfs_video_derivatives` unless the user has the admin permission.

## Routes & permissions

All routes require **`administer advanced_filesystem_video_processor`** (`restrict access: true`).

| Route | Path | Notes |
|---|---|---|
| `.settings` | `/admin/config/media/advanced_filesystem/video-processor` | `VideoSettingsForm` |
| `.dashboard` | `…/video-processor/dashboard` | coverage, disk usage, recent jobs |
| `.dashboard_clean` | `…/dashboard/clean` | controller validates `csrf_token('adfs-video-clean')`; deletes derivatives >30d |
| `.dashboard_reprocess` | `…/dashboard/reprocess` | validates `csrf_token('adfs-video-repro')`; requeues failed |
| `.batch` | `…/video-processor/batch` | `VideoBatchForm` |
| `.file_view` | `/admin/content/files/{file}/video` | HTML5 player + metadata table |
| `.file_process` | `…/{file}/video/process` | `VideoFileProcessForm` |
| `.video_edit` | `…/{file}/video/edit` | `VideoEditForm` (derivative operations, JS editor) |
| `.video_compare` | `…/{file}/video/compare` | side-by-side derivative compare |
| `.derivative_delete` | `…/{file}/video/derivative/{did}/delete` | validates `csrf_token('adfs-video-del-{did}')` |
| `.derivative_export` | `…/{file}/video/derivative/{did}/export` | validates `csrf_token('adfs-video-exp-{did}')`; copies output to `public://` |

Note: the dashboard-clean/reprocess and derivative delete/export routes do **not** declare
`_csrf_token` in routing.yml; each controller performs its own `csrf_token->validate()` against a
per-action value and throws `AccessDeniedHttpException` on mismatch. The dashboard builds the
links with `csrf_token->get()` plus a JS `confirm()`.

## Config object `advanced_filesystem_video_processor.settings`

Install defaults (`config/install/…settings.yml`): `ffmpeg_bin` `/usr/bin/ffmpeg`, `ffprobe_bin`
`/usr/bin/ffprobe`, `thumbnail_second` 5, `thumbnail_width` 640, `generate_thumbnail` true,
`generate_hls` false, `hls_resolutions` `[1920x1080, 1280x720, 854x480, 640x360]`,
`generate_sprites` false, `sprite_interval` 10, `auto_process` false, `max_file_size_mb` 2048,
`output_dir` `private://adfs_video_output`.

## DB tables

- `adfs_video_jobs` (PK `fid`): `status`, `duration`, `width`, `height`, `fps`, `video_codec`,
  `audio_codec`, `bitrate`, `thumbnail_uri`, `hls_uri`, `sprites_uri`, `metadata_json`,
  `error_message`, `created`, `processed` (indexed on `status`, `created`). Created via
  `hook_schema` on install.
- `adfs_video_derivatives`: `id`, `fid`, `operation`, `params_json`, `output_uri`, `status`,
  `error_message`, `created` — created via `hook_update_8001` (run `drush updb` after enabling
  on an existing install).

Config is deleted on uninstall.
