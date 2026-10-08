# Colorbox Media Video — manual setup guide

**Colorbox Media Video** (`colorbox_media_video`) makes core **Remote Video**
media (YouTube, Vimeo, and other oEmbed sources) open in a **Colorbox**
lightbox. Instead of an inline video iframe sitting in your content, the field
renders as a clickable thumbnail (or a text link, or the media title) that pops
the clip into a modal overlay when someone clicks it — the same lightbox
experience Colorbox already gives your image galleries, now applied to video.

It works as a single **field formatter** called *Colorbox Media Remote Video*.
You don't visit a settings page: you turn it on per view display, on the Remote
Video media type's *Manage display*, and set its options there. Those options let
you pick the launcher (thumbnail, text link, or the media title), choose an image
style for the thumbnail, group several videos into one Colorbox **gallery** so
viewers can page next/previous, and add a **caption** to the modal drawn
automatically from the title or alt text — or written yourself with tokens.

Because it builds on Colorbox and core Media, it reuses whatever Colorbox skin and
settings your site already has, and it honors Colorbox's global caption-trimming.
It depends on core's **Media** module and the contributed **Colorbox** module, and
optionally on the **Token** module if you want token replacement in the custom
gallery-id and caption fields.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including
   Colorbox), enable the module, and optionally add Token.

## Where it lives in the admin menu

There is no settings page. You configure the formatter on a media type's display
settings — for the Remote Video type that's **Structure → Media types → Remote
Video → Manage display**
(`/admin/structure/media/manage/remote_video/display`).

## How to use it

The formatter applies to the field that holds the remote-video URL — on the core
Remote Video media type that's the **Video URL** field
(`field_media_oembed_video`). To switch it on:

1. Go to **Structure → Media types → Remote Video → Manage display**.
2. On the **Video URL** row, change the format to **Colorbox Media Remote Video**.
3. Click the cog to open its settings, choose your options, click **Update**, then
   **Save**.

The settings you can adjust:

- **Display (the launcher)** — how the clickable trigger looks:
  - **Thumbnail** — an image the viewer clicks to open the video.
  - **Text** — a plain link; set its wording in **Link text** (default "View
    Video").
  - **Media title** — the media entity's own label becomes the link.
- **Image style** — the image style applied to the thumbnail when the launcher is
  a thumbnail (for example a cropped 16:9 teaser). Leave empty for the original.
- **Colorbox gallery** — how videos are grouped into a next/previous gallery:
  - **Post** or **Page** — group all videos in a post, or on the whole page.
  - **Field per post / per page** — group per field instance instead.
  - **Custom** — supply your own gallery id in **Custom gallery** (supports tokens
    when the Token module is installed, e.g. one gallery per taxonomy term).
  - **None** — no grouping; each video opens on its own.
- **Colorbox caption** — the text shown in the lightbox:
  - **Auto** — falls back through title → alt → the content title.
  - **Title**, **Alt**, or **Entity title** — force a specific source.
  - **Custom** — write your own in **Custom caption** (tokens supported with the
    Token module, e.g. `[media:name] — [media:field_credit]`).
  - **None** — no caption.

You can set different launchers and galleries per **view mode** of the same media
type — for example a thumbnail launcher in a teaser and a text link in the full
view. The formatter expects the entity to expose a `thumbnail` field (as media
entities do), so use it on a media type that has one for correct rendering.
