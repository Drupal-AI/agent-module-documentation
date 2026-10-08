# Video Embed Wistia — manual setup guide

**Video Embed Wistia** (`video_embed_wistia`) adds **Wistia** as a provider for the
popular **Video Embed Field** module. With it enabled, an editor can paste a Wistia
video URL into a video embed field and Drupal renders it as a responsive,
full‑screen‑capable Wistia iframe — the same way Video Embed Field already handles
YouTube and Vimeo.

The whole module is a single provider plugin. It teaches Video Embed Field to
recognize Wistia links (from `wistia.com`, `wi.st`, and `wistia.net`, including the
`/medias/…` share links and the `/embed/iframe/…` embed URLs), pull out the video
id, build the embed markup, and fetch the poster thumbnail and title from Wistia's
oEmbed service. Autoplay follows the field's own autoplay setting (and mutes the
video when autoplaying, as browsers require).

There is **nothing to configure** — no settings page, no permissions, no new field
types. Once the module is on, "Wistia" is simply one more provider that works
everywhere Video Embed Field already works: the field widget, the WYSIWYG "Embed
video" dialog, and — if you use `video_embed_media` — as a Media source. You can
even mix Wistia, YouTube, and Vimeo videos in a single field; the right provider is
chosen automatically from the URL.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no settings page. Wistia support surfaces wherever a Video Embed Field is
used — the field's edit form, its **Manage display** formatter settings (width,
height, title, autoplay, and so on), and the WYSIWYG embed dialog.

## How to use it

1. Make sure **Video Embed Field** is installed, then enable this module (see
   [Installation](installation/index.md)).
2. Add or reuse a **Video Embed Field** on a content type (**Structure → Content
   types → *(your type)* → Manage fields**), or use the Video Embed Field WYSIWYG
   button.
3. When editing content, paste a Wistia URL — for example
   `https://yourname.wistia.com/medias/abc123` — into the field. Video Embed Field
   validates it and stores the video.
4. View the content. The video renders as a responsive Wistia iframe, and the
   poster thumbnail is pulled automatically for teaser displays.

All the display options — iframe width and height, autoplay, thumbnail‑to‑video
formatting, title handling — come from Video Embed Field's own formatter settings,
since this module just plugs Wistia into that existing pipeline.
