<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Thumbnails Video — agent index

Adds a **Media Thumbnails** plugin that generates an image thumbnail from a video file using
**FFmpeg**, plus a video field formatter that uses it as the `<video>` poster. Depends on the
`media_thumbnails` framework and the FFmpeg binaries + `php-ffmpeg` lib + GD. No permissions,
no Drush, defines no plugin *types* of its own.

- **Settings (FFmpeg/FFprobe paths, timeout, threads), the plugin & formatter** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Config object: `media_thumbnails_video.settings` — `ffmpeg` (path, nullable), `ffprobe`
  (path, nullable), `timeout` (default `"3600"`), `threads` (default `"12"`).
- Settings form route `media_thumbnails_video.media_thumbnails_video_settings` at
  `/admin/config/media/media-thumbnails-video-settings` (permission `administer site
  configuration`).
- `MediaThumbnail` plugin id **`media_thumbnail_video`** (annotation `@MediaThumbnail`,
  `mime = {"video/mp4"}`), class `MediaThumbnailVideo extends MediaThumbnailBase`; its
  `createThumbnail($sourceUri)` grabs a frame via `php-ffmpeg` and writes a PNG (GD).
- Field formatter id **`file_video_extended`** ("Video extended"), `field_types = {file}`,
  extends core `FileVideoFormatter`, sets the generated thumbnail as the `poster` attribute.
- Requires a working FFmpeg install; with none, no thumbnails are generated.
