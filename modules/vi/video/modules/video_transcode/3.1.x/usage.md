Video Transcode is a submodule of Video that converts uploaded video files into web-compatible formats using a pluggable transcoder (FFmpeg), reusable presets, and a transcode-job entity.

---

Video Transcode extends the Video module with a transcoding pipeline for uploaded files. It defines a `transcoder` plugin type (annotation `@Transcoder`, managed by `video_transcode.provider_manager`) with a shipped `ffmpeg` plugin marked as a local (non-external) service, plus a base class that advertises the supported encode codecs (H.264, VP8, Theora, VP6, MPEG-4, WMV / AAC, MP3, Vorbis, WMA) and container formats (mp4, webm, ogv, mov, flv, and more). Output settings are captured in a `video_transcode_preset` config entity — a large mapping covering video codec, quality, resolution (`wxh`), frame rate, bitrate and buffer, H.264 profile/level, audio codec/bitrate/channels/sample rate, watermarking, denoise/deblock, and clip start/length — managed at `/admin/config/media/transcode-preset`. Individual conversions are tracked by a `video_transcode_job` content entity with its own list, add/edit/delete forms and settings form under `/admin/config/media/transcode-jobs`. A `video_upload_transcode` ("Video Upload & Convert") field widget extends the core video upload widget so editors can upload and queue conversion together. The module ships permissions for managing presets and transcode jobs and requires the parent `video` module. Note the bundled FFmpeg plugin's transcode methods are reference/stub implementations returning placeholder output.

---

- Convert uploaded videos into web-friendly formats (MP4/WebM/OGV) after upload.
- Offer editors a "Video Upload & Convert" widget that uploads and queues conversion in one step.
- Define a reusable transcode **preset** for a target format and quality.
- Set the output video codec (H.264, VP8, Theora, MPEG-4, …) on a preset.
- Set output resolution via the preset `wxh` (width x height) field.
- Control output bitrate, bitrate cap, and buffer size per preset.
- Choose an H.264 profile and codec level for compatibility.
- Configure audio codec, bitrate, channels, and sample rate for the output.
- Set frame rate, max frame rate, and keyframe interval.
- Enable one-pass encoding or skip video/audio streams on a preset.
- Apply a watermark (image, position, size) to transcoded output.
- Apply denoise, deblock, deinterlace, or autolevels filters.
- Clip the source to a start offset and length during transcoding.
- Track each conversion as a `video_transcode_job` entity with its own admin list.
- Add, edit, and delete transcode jobs at `/admin/config/media/transcode-jobs`.
- Manage transcode presets at `/admin/config/media/transcode-preset`.
- Gate preset management with the "administer video transcode presets" permission.
- Gate transcode-job actions with the add/view/edit/delete transcode job permissions.
- Add a new transcoding backend by writing a `@Transcoder` plugin (e.g. a cloud service).
- Query the supported codecs/formats a transcoder advertises via the transcoder plugin API.
