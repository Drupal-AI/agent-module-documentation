# EPT Video — manual setup guide

**EPT Video** (`ept_video`) adds a single-video Paragraph type to your site — a
video chosen through a **Media** field, whether that's a remote video (YouTube or
Vimeo) or a locally hosted file. The video opens in a lightbox overlay powered by
**GLightbox**, which is the right default for a page whose layout shouldn't be
dictated by a video's aspect ratio, and it can be shown as a thumbnail that opens
the overlay on click.

EPT Video is one module in the **Extra Paragraph Types (EPT)** family. Every EPT
module ships one ready-made Paragraph type and shares the
[`ept_core`](https://www.drupal.org/project/ept_core) base module for a common
set of per-instance *design options* — spacing (margins, padding, borders), a
background (color, image with parallax or cover, or a YouTube video), edge-to-edge
or contained width. So there is **no site-wide settings page**: you configure each
video on the paragraph where you place it.

Three things belong in any conversation about adding video. A **remote video is a
third-party request** — the player sets cookies and reports the view to
YouTube/Vimeo before anyone presses play, so it belongs behind your consent
manager exactly as an analytics tag does (and a lightbox helps, since the embed
can be deferred until the overlay opens). **Video needs captions** — a WCAG
requirement for prerecorded content, and the only way the words become searchable.
And **autoplay with sound is blocked by every current browser** and disliked where
it isn't, so if a design calls for it, that's a conversation rather than a setting.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and confirm the Paragraph type appears.

There is **no configuration page** for this module. Video paragraphs are
configured per instance, on the paragraph itself, using the shared EPT design
options described below.

## Where it lives in the admin menu

EPT Video adds no admin settings page. Once enabled it registers a **Video**
Paragraph type, listed under **Structure → Paragraphs types**
(`/admin/structure/paragraphs_type`).

## How to use it

Like every EPT component, Video is used by placing it inside a **Paragraphs
field**:

1. On a content type that has an *Entity reference revisions* Paragraphs field,
   make sure the field's settings allow the **Video** paragraph type.
2. Edit a piece of content, add a **Video** paragraph, and select the video from
   the media library (a remote video or a local file).
3. Open the paragraph's **design options** (from `ept_core`) to set spacing,
   background, and width for that specific video.
4. Save. The video renders as a thumbnail and opens in the GLightbox overlay when
   clicked.
