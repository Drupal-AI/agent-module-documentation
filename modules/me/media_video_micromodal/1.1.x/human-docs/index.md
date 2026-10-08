# Media Video Micromodal — manual setup guide

**Media Video Micromodal** (`media_video_micromodal`) makes core Media **remote
videos** (YouTube, Vimeo, and other oEmbed sources) open in a clean, accessible
popup instead of playing inline on the page. A visitor clicks a thumbnail — or a
text link — and the video appears in a modal dialog built with the lightweight,
vanilla‑JS **micromodal.js** library. Close the modal and playback stops
automatically.

It works as a **field formatter** you attach on the **Manage display** tab of a
remote‑video media type. Depending on which field you format, the clickable
trigger can be the auto‑generated oEmbed **thumbnail**, a **custom uploaded
thumbnail**, the media **Name**, a **caption**, or your own **custom link text**
(with token support when the Token module is installed). Whatever the trigger,
clicking it opens a modal containing the video. For accessibility and privacy the
modal loads the video through Drupal's own signed local oEmbed endpoint rather
than embedding the raw remote URL directly.

The module needs only Drupal core's **Media** module, and the media type must
have the core `field_media_oembed_video` field (which the core **Remote video**
type provides). It works inside CKEditor media embeds and in Views "Rendered
entity" rows too. There is **no global settings page** — all options are the
formatter settings you set per display.

One thing to note: the micromodal.js library is loaded from a public CDN
(unpkg.com). On an offline or locked‑down site you would override that library to
point at a self‑hosted copy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no settings page. You configure it on the **Manage display** tab of your
remote‑video media type, at **Structure → Media types → Remote video → Manage
display** (`/admin/structure/media/manage/remote_video/display`).

## How to use it

1. Make sure you have a media type with the core oEmbed video field — the core
   **Remote video** type, or a copy of it. Add some remote‑video media items
   (paste a YouTube/Vimeo URL) if you don't have any.
2. Go to that media type's **Manage display** tab and pick the field you want to
   turn into the modal trigger:
   - the **Thumbnail** (image) field, or a **custom thumbnail** (image / media
     reference) field → the trigger is a styled image;
   - the **Name** (or another text) field → the trigger is a text link.
3. In the **Format** column choose **Video Micromodal** (the
   `micromodal_field_formatter`).
4. Click the gear and set the options for that field:
   - **Image style** — the image style for image/media triggers. *If you leave
     this empty on an image trigger, nothing renders* — the settings summary warns
     you about this, so always pick a style for image triggers.
   - **Link text** — custom text for a text‑link trigger (for example "Watch
     video") instead of the media name. Supports tokens when the Token module is
     enabled.
   - **Caption swap** — for text triggers, swaps the link contents for the media's
     caption at runtime. Handy for CKEditor media embeds that carry a caption.
   - **CSS classes** — extra space‑separated classes added to the text link for
     styling.
5. Click **Update**, then **Save**. On the front end the trigger now opens the
   video in a modal.

Using it elsewhere:

- **CKEditor:** enable Media Library, tick the **Embed media** filter on the text
  format, and include the view mode(s) that use this formatter under "View modes
  selectable". Insert the video from the Media Library and choose that view mode
  (tick Caption to use Caption Swap).
- **Views:** add a **Rendered entity** field or row using a media view mode whose
  display is configured with this formatter — for example a gallery of thumbnails
  that each open their own modal.

To change the modal markup, override the `media-video-micromodal.html.twig`
template; theme suggestions are provided per bundle and view mode.
