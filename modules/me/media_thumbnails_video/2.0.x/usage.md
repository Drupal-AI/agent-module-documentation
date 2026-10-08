<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Thumbnails Video plugs into the Media Thumbnails framework to automatically generate an image thumbnail from a video file (via FFmpeg) for video media entities, and adds a video field formatter that uses that thumbnail as the HTML5 `<video>` poster.

---

The module contributes a `MediaThumbnail` plugin (`media_thumbnail_video`) to the contrib **Media Thumbnails** framework; whenever a media entity backed by a matching video file (MIME `video/mp4`) is created or its thumbnail is (re)generated, the framework calls this plugin's `createThumbnail()`, which uses the `php-ffmpeg/php-ffmpeg` library and GD to grab a frame from the video and save it as a PNG thumbnail on the media entity. It exposes one settings form at *Configuration → Media → Media thumbnails video settings* (`/admin/config/media/media-thumbnails-video-settings`, permission `administer site configuration`) writing the `media_thumbnails_video.settings` config: the paths to the `ffmpeg` and `ffprobe` binaries (leave empty to auto-detect), a `timeout` (default 3600s) and a `threads` count (default 12) for FFmpeg. It also provides a field formatter `file_video_extended` ("Video extended") that extends core's File Video formatter to render an HTML5 `<video>` tag with the generated thumbnail set as the `poster` attribute. The module depends on `media_thumbnails` and requires the FFmpeg binaries plus the `php-ffmpeg` library and the GD extension to be present; without a working FFmpeg install no thumbnails are produced. It defines no permissions, Drush commands, or plugin types of its own.

---

- Automatically create a thumbnail image for uploaded MP4 video media entities.
- Show a representative video frame as the poster of an HTML5 `<video>` player.
- Give a media library visually meaningful thumbnails for videos instead of a generic icon.
- Generate posters for hero/background videos on a site.
- Point the module at a custom FFmpeg binary path on servers where it is not on PATH.
- Configure the FFprobe binary path used to inspect video files.
- Increase or decrease FFmpeg thread usage to balance speed vs server load.
- Raise the thumbnail-generation timeout for large or long videos.
- Use the `file_video_extended` formatter to render a file video field with a poster image.
- Replace the default core file-video display with one that shows a generated poster.
- Provide consistent video thumbnails across a content catalog.
- Improve perceived load time by showing a poster before a video plays.
- Regenerate video thumbnails through the Media Thumbnails framework after changing settings.
- Support video-heavy editorial workflows with automatic preview images.
- Present course/lesson videos with auto-generated preview frames.
- Give product demo videos a still preview in a commerce listing.
- Populate the media entity thumbnail field so views/teasers can show a video preview.
- Standardize video poster images without editors uploading them manually.
- Feed generated thumbnails into responsive image styles for video previews.
- Reduce editor effort by removing the manual "upload a poster" step for videos.
- Tune FFmpeg concurrency (threads) for a shared hosting environment.
- Auto-detect FFmpeg/FFprobe by leaving the binary path fields empty.
- Ensure GD-based PNG thumbnails are produced for the media entity.
- Integrate video thumbnailing into an existing Media Thumbnails setup for other file types.
