# Magnify Image Viewer — manual setup guide

**Magnify Image Viewer** (`magnify`) adds a **field formatter for image fields**
that overlays a magnifying‑glass (loupe) hover preview on displayed images. When
a visitor hovers over an image, a zoomed loupe follows the cursor so they can
inspect fine detail — fabric on a product photo, text on a scanned document,
brush strokes on artwork, streets on a map — without opening a separate lightbox.
You control the **loupe size** and the **zoom scale** per display, and it works on
any image field: on content types, media, or paragraphs.

It is a display‑only feature and needs no custom JavaScript from you: choose the
**Magnify Image Viewer** formatter on a field's **Manage display**, optionally
apply an image style to the base image, set the loupe size and zoom, and save. The
formatter is touch‑friendly and responsive, and can fall back to the original
image when no image style is chosen.

The module has **no routes, permissions, services, or writable configuration of
its own** — everything is set through Field UI. It depends on core **Image** and
the contrib **jQuery UI** module.

> **Supply‑chain note worth knowing.** Magnify loads its zoom JavaScript as an
> **external asset from a third‑party CDN**
> (`cdn.jsdelivr.net/gh/ninjadrupal/magnifyjs@1.0.0`). The reference **is pinned to
> `@1.0.0`**, which is safer than an unpinned branch, but it is still code fetched
> from an external host at page load. For production — especially under a strict
> Content Security Policy or where privacy/offline requirements apply — consider
> vendoring the asset locally and pointing the library at the local file.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Image / jQuery UI dependencies.

There is **no separate settings form** — all options live on the image field's
display settings, described in "How to use it" below.

## Where it lives in the admin menu

Magnify adds no admin page. You configure it entirely from **Manage display** on
whichever entity holds the image field — for example
`admin/structure/types/manage/page/display`.

## How to use it

1. Install and enable the module and its dependencies (see
   [Installation](installation/index.md)).
2. Go to the **Manage display** screen for a content type (or media / paragraph
   type) that has an **image** field.
3. For that image field, choose the **Magnify Image Viewer** formatter.
4. Open the formatter's settings (the gear icon) and configure:
   - **Image style** — apply any image style to the base image, or leave it as
     *None* to use the original file.
   - **Loupe size** — the size of the magnifying glass in pixels (choices range
     from 90 up to 300).
   - **Zoom level** — the zoom scale, from **1** to **5**.
5. Save the display. Hovering over the image now shows the zoom loupe. It works
   well alongside Views and other core image features, and with responsive image
   styles for the base render.
