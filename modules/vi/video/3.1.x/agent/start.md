# video — agent start

Adds a `video` field type (extends core `FileItem`) for **uploaded** or **embedded** videos.
Input via the `video_upload` (files) or `video_embed` (remote URL) widget; output via HTML5
(`video_player`, `video_player_list`) or embed (`video_embed_player`, `video_embed_thumbnail`,
`video_url`) formatters. Remote hosts are pluggable (`VideoEmbeddableProvider`): YouTube, Vimeo,
Dailymotion, Facebook, Instagram, Vine, each with a read-only stream wrapper. Requires core
`file`. No admin settings page (configure at the field/display level). Submodule
`video_transcode` adds FFmpeg transcoding.

- Add & configure the video field, widgets, and formatters → [configure/video.md](configure/video.md)
- Add support for a new embed provider (plugin type) → [plugins/video.md](plugins/video.md)
- Provider manager service + entity/embed APIs → [api/video.md](api/video.md)
- Submodule: local FFmpeg transcoding & presets → [../../modules/video_transcode/3.1.x/agent/start.md](../../modules/video_transcode/3.1.x/agent/start.md)
