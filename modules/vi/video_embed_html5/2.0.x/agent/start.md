# Video Embed HTML5 — agent index

Adds an **HTML5 provider** to Video Embed Field for self-hosted / direct-link videos
(`.mp4`, `.ogg`, `.webm`) rendered in a native `<video>` player.

- **The `html_5` provider plugin: URL matching, render output, thumbnails (FFmpeg vs canvas)** →
  [plugins/provider.md](plugins/provider.md)
- **The placeholder configuration (`add_placeholder`, `placeholder`) and permission** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Provider plugin id: `html_5` (`@VideoEmbedProvider`), matches URLs ending in mp4/ogg/webm.
- Theme `video_embed_html5` → `<video controls …><source src type="video/…"></video>`.
- Config: `video_embed_html5.config` → `add_placeholder` (bool, default true), `placeholder`
  (file id or null). Form route `video_embed_html5.config.form` at
  `/admin/config/media/video-embed-html5`, permission `administer video_embed_html5`.
- Depends on `video_embed_field`; optional `php_ffmpeg` for server-side thumbnails. PHP >= 8.
