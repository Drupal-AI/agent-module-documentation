<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AudioProcessorService — operations, routes, config, tables

## Install & enable

```bash
drush en advanced_filesystem_audio_processor -y
```

Requires core `file`, `media`, the base `advanced_filesystem` module, and the system `ffmpeg`
and `ffprobe` binaries. Set their paths at `/admin/config/media/advanced_filesystem/audio-processor`.

## Service: `advanced_filesystem_audio_processor.service` (`Service\AudioProcessorService`)

Constructor args: `@config.factory`, `@database`, `@file_system`, `@logger.factory`.
Binary paths come from config (`ffmpeg_bin` default `/usr/bin/ffmpeg`, `ffprobe_bin` default
`/usr/bin/ffprobe`).

| Method | What it does |
|---|---|
| `process(FileInterface $file): array` | Probe + waveform; upsert `adfs_audio_jobs`. |
| `probe(string $path): ?array` | `ffprobe -show_format -show_streams` JSON decode. |
| `generateWaveform(FileInterface $file, int $w=1200, int $h=200): ?string` | ffmpeg `showwavespic` PNG → `public://adfs_audio_waveforms/{fid}/waveform.png`. |
| `trim(FileInterface $file, string $start, string $end, string $format='mp3'): array` | `-ss/-to -c:a copy`. |
| `convert(FileInterface $file, string $format, int $bitrate=0): array` | Re-encode via a codec map (mp3→libmp3lame, aac, flac, ogg→libvorbis, wav→pcm_s16le). |
| `normalize(FileInterface $file, float $targetLufs=-23.0, string $format=''): array` | Two-pass EBU R128 loudnorm (measure JSON → apply). |
| `stripMetadata(FileInterface $file, string $format=''): array` | `-map_metadata -1 -c:a copy`. |
| `extractChannels(FileInterface $file, string $format=''): array` | `pan` filter → separate left/right mono files (two derivative rows). |
| `getJob(int $fid) / getDerivatives(int $fid)` | Read job/derivative rows. |
| `getSystemStatus(): array` | `is_executable()` for ffmpeg/ffprobe. |
| `calcDiskUsage() / cleanOld(int $days=30) / reprocessFailed()` | Dashboard helpers. |

Derivative outputs land in `public://adfs_audio_derivatives/{fid}/`; `saveDerivative()` writes a
row into `adfs_audio_derivatives` with `status = done/failed` based on whether the output file
exists.

## Auto-processing & queue

`hook_file_insert` (in `*.module`): if `auto_process` is on and the file MIME starts `audio/`,
it creates an item in the `adfs_audio_process` queue (`['fid' => …]`). The queue is drained on
cron. `reprocessFailed()` requeues every `adfs_audio_jobs` row with `status = failed`.

`hook_file_download` returns `-1` (deny) for `private://adfs_audio_*` URIs unless the current
user has `administer advanced_filesystem_audio_processor`.

## Routes & permissions

All routes require **`administer advanced_filesystem_audio_processor`** (`restrict access: true`).

| Route | Path | Notes |
|---|---|---|
| `.settings` | `/admin/config/media/advanced_filesystem/audio-processor` | `AudioSettingsForm` |
| `.dashboard` | `/admin/adfs/audio/dashboard` | coverage/disk/status |
| `.dashboard_clean` | `…/dashboard/clean` | `_csrf_token`; `cleanOld()` |
| `.dashboard_reprocess` | `…/dashboard/reprocess` | `_csrf_token`; `reprocessFailed()` |
| `.batch` | `…/audio-processor/batch` | `AudioBatchForm` |
| `.file_view` | `/admin/content/files/{file}/audio` | `AudioFileViewController::view` (waveform + metadata table) |
| `.file_process` | `…/{file}/audio/process` | `AudioFileProcessForm` |
| `.audio_edit` | `…/{file}/audio/edit` | `AudioEditForm` (derivative operations) |
| `.derivative_delete` | `/{file}/audio/derivative/{did}/delete` | `_csrf_token`; unlink + delete row |
| `.derivative_export` | `/{file}/audio/derivative/{did}/export` | copy output → new managed file |

The `process advanced_filesystem_audio_processor` permission is declared but the routes use the
administer permission.

## Config object `advanced_filesystem_audio_processor.settings`

| Key | Type | Meaning |
|---|---|---|
| `ffmpeg_bin` | string | Path to ffmpeg (default `/usr/bin/ffmpeg`). |
| `ffprobe_bin` | string | Path to ffprobe (default `/usr/bin/ffprobe`). |
| `auto_process` | boolean | Queue `audio/*` uploads for processing. |
| `waveform_width` / `waveform_height` | integer | Waveform PNG dimensions. |
| `waveform_color` | string | Waveform colour (hex). |
| `clean_after_days` | integer | Retention for `cleanOld()`. |

## DB tables (`hook_schema`)

- `adfs_audio_jobs` — PK `fid`; `status`, `duration`, `bitrate`, `sample_rate`, `channels`,
  `codec`, `title`, `artist`, `album`, `year`, `genre`, `waveform_uri`, `loudness_lufs`,
  `metadata_json`, `error_message`, `created`, `processed` (indexed on `status`, `created`).
- `adfs_audio_derivatives` — `id`, `fid`, `operation`, `params_json`, `output_uri`, `file_size`,
  `status`, `error_message`, `created` (indexed on `fid`, `operation`).

Config is deleted on uninstall.

## Media source

`Plugin\media\Source\AudioProcessorSource` (id `audio_processor`) registers an audio Media
source type so audio can be managed through the core Media library.
