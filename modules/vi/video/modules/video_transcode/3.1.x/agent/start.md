# video_transcode — agent start

Submodule of **video** (`part_of: video`, depends on `video`). Converts uploaded videos into
web formats via a pluggable **transcoder** plugin type; ships the `ffmpeg` plugin (local). Adds
a `video_transcode_preset` **config entity** (codec/bitrate/resolution/watermark/…) and a
`video_transcode_job` **content entity** to track conversions, plus a `video_upload_transcode`
("Video Upload & Convert") widget. Admin under `/admin/config/media/transcode-preset` and
`/admin/config/media/transcode-jobs`. No `configure` route in info.yml. Provides permissions.
Note: the bundled FFmpeg plugin's transcode methods return placeholder/stub output.

- Presets, transcode jobs, routes, permissions, the widget → [configure/video_transcode.md](configure/video_transcode.md)
- The `@Transcoder` plugin type (add a backend) → [plugins/video_transcode.md](plugins/video_transcode.md)
