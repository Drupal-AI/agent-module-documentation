<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Media Thumbnails Video

## Settings form

Route `media_thumbnails_video.media_thumbnails_video_settings` →
`/admin/config/media/media-thumbnails-video-settings` (under *Configuration → Media*).
Permission: `administer site configuration`. Form
`MediaThumbnailsVideoSettingsForm` edits config object `media_thumbnails_video.settings`.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `ffmpeg` | string (nullable) | `null` | path to the `ffmpeg` binary (empty → auto-detect) |
| `ffprobe` | string (nullable) | `null` | path to the `ffprobe` binary (empty → auto-detect) |
| `timeout` | string (nullable) | `"3600"` | FFmpeg timeout in seconds |
| `threads` | string (nullable) | `"12"` | FFmpeg thread count |

Read/write:

```bash
drush cget media_thumbnails_video.settings
```

```php
\Drupal::configFactory()->getEditable('media_thumbnails_video.settings')
  ->set('ffmpeg', '/usr/bin/ffmpeg')
  ->set('ffprobe', '/usr/bin/ffprobe')
  ->set('threads', '6')
  ->set('timeout', '3600')
  ->save();
```

## The thumbnail plugin

`media_thumbnail_video` (`@MediaThumbnail`, class `MediaThumbnailVideo extends
MediaThumbnailBase`) is registered with the **Media Thumbnails** framework
(`media_thumbnails` module's `MediaThumbnailManager`). It declares `mime = {"video/mp4"}`, so
the framework routes MP4 video files to it. Its `createThumbnail($sourceUri)`:

1. reads `media_thumbnails_video.settings` (binary paths, timeout, threads),
2. opens the video with `php-ffmpeg/php-ffmpeg`,
3. extracts a frame (`FFMpeg\Coordinate\TimeCode`) and writes a PNG via GD (`imagepng`),
4. returns it to the framework, which stores it as the media entity's thumbnail.

You do not call this directly — it runs when Media Thumbnails (re)generates a video media
entity's thumbnail. A real FFmpeg install must be present or `ExecutableNotFoundException` is
thrown and no thumbnail is produced.

## The video formatter

Field formatter `file_video_extended` ("Video extended"), `field_types = {file}`, extends core
`FileVideoFormatter`. Select it on a file field's *Manage display*; it renders the HTML5
`<video>` tag and sets the generated thumbnail as the `poster` attribute
(`$attributes->setAttribute('poster', $poster)`).

## Requirements

`media_thumbnails` (dependency), the `php-ffmpeg/php-ffmpeg` library, the GD extension, and the
`ffmpeg`/`ffprobe` binaries on the server. No permissions, Drush commands, or plugin types are
added by this module.
