# Configure transcoding: presets, jobs, widget

No global `configure` route in `video_transcode.info.yml`. Everything is driven from entity
admin routes plus the Field UI. Requires the parent **video** module.

## The "Video Upload & Convert" widget

On Manage form display for a `video` field, choose **Video Upload & Convert**
(widget id `video_upload_transcode`). It extends the core `video_upload` widget (same settings:
file extensions, directory, max size, uri scheme) and is meant to queue conversion on upload.

## Presets — `video_transcode_preset` (config entity)

A `ConfigEntityType` (`admin_permission: administer video transcode presets`). Routes under
`/admin/config/media/transcode-preset`:

| Route | Path |
|---|---|
| `entity.video_transcode_preset.list` | `/admin/config/media/transcode-preset` |
| `entity.video_transcode_preset.add_form` | `/admin/config/media/transcode-preset/add` |
| `entity.video_transcode_preset.edit_form` | `/admin/config/media/transcode-preset/manage/{video_transcode_preset}` |
| `entity.video_transcode_preset.delete_form` | `/admin/config/media/transcode-preset/manage/{video_transcode_preset}/delete` |

Preset properties (schema `video_transcode.video_transcode_preset.*`, exportable config):
`video_extension`, `video_codec`, `video_quality`, `video_speed`, `wxh` (WxH resolution),
`video_aspectmode`, `video_upscale`, `audio_codec`, `audio_quality`, `deinterlace`,
`max_frame_rate`, `frame_rate`, `keyframe_interval`, `video_bitrate`, `bitrate_cap`,
`buffer_size`, `one_pass`, `skip_video`, `reference_frames`, `h264_profile`, `codec_level`,
`audio_bitrate`, `audio_channels`, `audio_sample_rate`, `skip_audio`, watermark fields
(`video_watermark_enabled`, `_fid`, `_y`, `_width`, `_height`, `_origin`), `autolevels`,
`deblock`, `denoise`, `clip_start`, `clip_length`.

## Transcode jobs — `video_transcode_job` (content entity)

A `ContentEntityType` (base table `video_transcode_job`) tracking individual conversions.
Routes under `/admin/config/media/transcode-jobs`:

| Route | Path |
|---|---|
| `entity.video_transcode_job.collection` | `/admin/config/media/transcode-jobs/list` |
| `video_transcode.add_transcode_job` | `/admin/config/media/transcode-jobs/add` |
| `entity.video_transcode_job.canonical` | `/admin/config/media/transcode-jobs/{video_transcode_job}` |
| `entity.video_transcode_job.edit_form` | `/admin/config/media/transcode-jobs/{video_transcode_job}/edit` |
| `video_transcode.video_transcode_job_settings` | `/admin/config/media/transcode-jobs/settings` (also `field_ui_base_route`) |

## Permissions (`video_transcode.permissions.yml`)

- `administer video transcode presets` — create/edit presets.
- `add transcode job entity`, `view transcode job entity`, `edit transcode job entity`,
  `delete transcode job entity` — per-operation on transcode jobs.
- `administer transcode job entity` — the job settings form.

`provides_config_schema: true` (preset schema); presets export with `drush config:export`.
