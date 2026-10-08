# Video Embed HTML5 — manual setup guide

**Video Embed HTML5** (`video_embed_html5`) adds an **HTML5** provider to the
popular [Video Embed Field](https://www.drupal.org/project/video_embed_field)
module. With it, editors can embed self‑hosted or direct‑link videos — any URL
ending in `.mp4`, `.ogg`, or `.webm` — and have them play in a native HTML5
`<video>` player, no YouTube or Vimeo required.

Because it is just a new provider, you use it exactly like any other Video Embed
Field provider: add a **Video Embed** field to a content type and paste a direct
link to a video file. The module recognises the file extension and renders a
`<video controls>` element, honouring the field's autoplay setting. This is handy
for privacy‑friendly sites (no third‑party tracking), videos served from your own
CDN or file storage, product demos, or short looping clips.

Thumbnails are handled in one of two ways. If you also install the optional
**php_ffmpeg** module, the provider grabs a poster frame from the video on the
server. Without FFmpeg, it falls back to generating a thumbnail in the browser
from the video's first frame, and can show a placeholder image while that happens.
That placeholder is the module's only setting.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and add the Video Embed Field dependency.

## Where it lives in the admin menu

The one settings form sits at **Configuration → Media → Video Embed HTML5**
(`/admin/config/media/video-embed-html5`), gated by the **Administer
video_embed_html5** permission. You configure video *fields* themselves through
the normal field UI (Manage fields / Manage display), the same as any Video Embed
Field.

## How to use it

### Embed a video

1. Add a **Video Embed** field to a content type (**Structure → Content types →
   Manage fields**), or reuse an existing one.
2. When editing content, paste a direct link to a video file, for example
   `https://example.com/media/clip.mp4`.
3. The video renders in a native HTML5 player. To turn on muted autoplay, use the
   Video Embed Field autoplay setting on the field's display.

To limit a field to *only* HTML5 videos (rejecting YouTube/Vimeo links), set the
field's **allowed providers** to just **HTML5** in the field settings. You can
also mix HTML5 and remote videos in the same field by leaving all providers
enabled.

### The placeholder setting

At **Configuration → Media → Video Embed HTML5** you can:

- **Add placeholder** *(on by default)* — show a placeholder image while the
  browser generates a thumbnail (only relevant when FFmpeg is not installed). Turn
  this off if you'd rather show nothing until the real thumbnail appears.
- **Placeholder image** — upload your own placeholder (jpg/png). If you leave it
  blank, the module's bundled placeholder image is used.

### Better thumbnails with FFmpeg

For consistent server‑side poster images, install the optional
[php_ffmpeg](https://www.drupal.org/project/php_ffmpeg) module. When present, the
provider extracts a frame one second into each video and uses it as the thumbnail,
and the placeholder logic is skipped entirely.
