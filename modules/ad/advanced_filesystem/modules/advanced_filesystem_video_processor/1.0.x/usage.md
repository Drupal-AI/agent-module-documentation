Process Drupal managed video files with FFmpeg — probe metadata, extract thumbnails, generate HLS renditions, and produce trim, resize, crop, watermark, GIF, subtitle and format-conversion derivatives.

---

Advanced Filesystem: Video Processor is an optional submodule of the Advanced FileSystem project. It wraps the system's `ffmpeg` and `ffprobe` binaries in a Drupal service (`VideoProcessorService`) over managed video files. On processing it probes metadata (width, height, fps, video/audio codecs, duration, bitrate) into the `adfs_video_jobs` table, extracts a thumbnail, and can generate HLS adaptive-streaming renditions and a thumbnail sprite sheet. On demand it produces a wide range of derivatives — trim, resize, focal-point crop, thumbnail-at-time, watermark overlay, audio extraction, hard/soft subtitle embedding, format conversion, speed change, animated GIF, audio normalization, scene contact sheet and subtitle-stream extraction — each recorded in `adfs_video_derivatives`. Processing runs automatically on upload via a cron queue or on demand from per-file admin tabs, a batch form, a JS-based edit/compare UI, and a dashboard with disk-usage, cleanup and reprocess actions. Generated files default to the `private://` scheme and are protected on download; a `media` source plugin is registered for video. Binary paths and generation options are configured at `/admin/config/media/advanced_filesystem/video-processor`, and all routes require the module's restricted administer permission.

---

- Extract technical metadata (resolution, fps, codecs, duration, bitrate) from uploaded videos.
- Auto-generate a poster thumbnail at a configurable second for every uploaded video.
- Generate HLS adaptive-streaming renditions at multiple configured resolutions.
- Build a thumbnail sprite sheet for scrubbing previews in the player.
- Auto-process every uploaded `video/*` file in the background via the cron queue.
- Skip processing of files above a configurable maximum size.
- Trim a video to a `[start, end]` range with stream copy (no re-encode).
- Resize a video to a target width while preserving aspect ratio.
- Crop a video around a focal point expressed as X/Y percentages.
- Capture a thumbnail at any specific timestamp on demand.
- Overlay a watermark image in a chosen corner or centre.
- Extract the audio track to mp3/aac/ogg/opus/flac.
- Burn in (hard) or mux (soft) SRT subtitles into a video.
- Convert a video to mp4/webm/mkv/mov/avi/ogv with sensible codec defaults.
- Change playback speed / create a timelapse, adjusting audio tempo to match.
- Produce an animated GIF from a segment with a generated colour palette.
- Normalize a video's audio loudness to a target LUFS.
- Generate a scene contact sheet (grid of frames) for quick review.
- Extract an embedded subtitle stream to an SRT file.
- Compare two derivative versions side by side in the admin UI.
- View a dashboard of processing coverage, disk usage and recent jobs.
- Clean up derivatives older than 30 days and requeue failed jobs.
- Serve generated renditions from the private filesystem, gated behind the admin permission.
- Use video files as a dedicated Media source type in the media library.
