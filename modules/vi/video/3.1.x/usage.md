Video adds a `video` field type that stores either an uploaded video file or an embedded remote video (YouTube, Vimeo, and others), with widgets and formatters to capture and play them.

---

Video provides a `video` field type (extending core's `FileItem`) so any content type or entity can hold uploaded videos or embed codes from remote providers. Two widgets drive input: `video_upload` accepts local file uploads (mp4/ogv/webm by default, with directory, extension, max-size and storage-scheme settings) and `video_embed` accepts a provider URL and validates it against a pluggable set of embed providers. Six formatters render the stored value: `video_player` and `video_player_list` output an HTML5 `<video>` element for uploaded files, while `video_embed_player`, `video_embed_thumbnail`, and `video_url` render remote embeds, an image-styled thumbnail, or the raw URL. Remote providers are a plugin type (`VideoEmbeddableProvider`, managed by `video.provider_manager`): each plugin declares matching regular expressions, a mimetype, and a stream-wrapper scheme, and knows how to render its embed iframe and fetch a remote thumbnail. The module ships providers for YouTube, Vimeo, Dailymotion, Facebook, Instagram, and Vine, plus a read-only stream wrapper per scheme so embedded videos are stored as managed `file` entities. A companion submodule, `video_transcode`, adds local (FFmpeg) transcoding of uploaded files into web-friendly formats via a transcoder plugin type and reusable presets. The module requires only core `file` and integrates with the field UI like any other field.

---

- Add a "Video" field to a content type to hold an uploaded or embedded video.
- Upload an MP4/WebM/OGV file with the `video_upload` widget and play it in an HTML5 player.
- Paste a YouTube or Vimeo URL with the `video_embed` widget and store it as a managed file.
- Restrict which embed providers editors may use, per field, via the widget settings.
- Cap the maximum upload size or restrict allowed video file extensions on a field.
- Choose the upload destination stream (public/private) for uploaded videos.
- Auto-generate and locally cache a video thumbnail from a remote provider.
- Render an embedded video's thumbnail through an image style with the `video_embed_thumbnail` formatter.
- Link a video thumbnail to the content or to the remote video.
- Autoplay, loop, mute, or hide controls on the HTML5 player via formatter settings.
- Set player width, height, and preload behavior for uploaded video playback.
- Show related videos and set autoplay on embedded YouTube/Vimeo players.
- Store multiple videos in one field by raising the field cardinality (HTML5 sources).
- Output just the video URL with the `video_url` formatter for custom theming.
- Add support for a new video host by writing a `VideoEmbeddableProvider` plugin.
- Match custom embed URLs by supplying provider regular expressions.
- Reference embedded videos through custom `youtube://`, `vimeo://`, etc. stream wrappers.
- List all available embed providers programmatically via `video.provider_manager`.
- Detect which provider handles a given URL with `loadApplicableDefinitionMatches()`.
- Migrate Drupal 7 `video` fields into Drupal 10/11 via the bundled migrate field plugin.
- Generate sample video field values for test content.
- Transcode uploaded videos to web formats with the `video_transcode` submodule (FFmpeg).
- Define reusable transcoding presets (codec, bitrate, resolution, watermark) with `video_transcode`.
- Use the "Video Upload & Convert" widget to upload and queue conversion in one step.
- Store videos on remote/cloud file systems by pairing with Flysystem.
