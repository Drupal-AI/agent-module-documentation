# youtube — agent start

Defines a `youtube` field type: paste a YouTube URL, the widget validates it and stores the
raw `input` plus an extracted `video_id`. Three formatters render it — `youtube_video`
(embedded iframe player), `youtube_thumbnail` (locally-downloaded thumbnail image, image-style
capable), and `youtube_url` (plain text/link). Global defaults live in the `youtube.settings`
config object; many are overridable per field display. Depends on core `field`, `image`,
`file`. Release `3.0.x` is a **beta**. Not the same as core Media oEmbed video (which stores
media entities, not a scalar field).

Config UI: **Admin → Configuration → Media → YouTube Field** (`/admin/config/media/youtube`),
route `youtube.settings`, gated by the `administer youtube` permission.

- Add the field, choose the player vs thumbnail formatter, and tune player + thumbnail
  settings (size, autoplay, privacy, image style, download dir) → [configure/settings.md](configure/settings.md)
