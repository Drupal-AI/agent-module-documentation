# Image Zoom — manual setup guide

**Image Zoom** (`imagezoom`) adds the familiar e-commerce "magnifier lens"
effect to image fields: when a visitor hovers over an image, a magnified view of
the area under the cursor appears, following the mouse as it moves. It is the
standard way to let people inspect the fine detail of a product photo — fabric
texture, engraving, small print — without clicking through to a separate large
image.

You add it as a **field formatter**, so there is no global settings page. On an
image field's display you pick two image styles: one for the image shown at normal
size, and a second, larger one that supplies the magnified view. When the cursor
hovers over the displayed image, the zoomed image is revealed and positioned
relative to the mouse. A bundled submodule, **Image Zoom Gallery**
(`imagezoom_gallery`), extends the effect to galleries of images.

One thing determines whether the effect looks good: **the source resolution**.
Hover-zoom magnifies *into* the larger image, so if that image is not high enough
resolution, the zoom shows upscaled blur rather than real detail. Point the
"zoomed" image style at an image style large enough to reveal something worth
looking at. Beyond that the module is a pure display enhancement with no security
surface.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and optionally the gallery submodule).

There is **no configuration page** for this module — it has no settings form. You
set it up on an image field's display, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no admin page. You use it entirely from **Structure → Content
types → *(your type)* → Manage display**, where you set an image field's format to
**Image Zoom**.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Go to the **Manage display** tab of the content type (or other entity) that has
   the image field — e.g. **Structure → Content types → Article → Manage display**.
3. Change the image field's **Format** to **Image Zoom**.
4. In the formatter settings, choose the **image style for the displayed image**
   and the (larger) **image style used for the zoomed view**. Save.
5. View the content and hover over the image — a magnified view appears and
   tracks the cursor.

To apply the effect to a gallery rather than a single image, enable the **Image
Zoom Gallery** submodule (see [Installation](installation/index.md)).

> **Use a high-resolution source.** The zoom magnifies into the larger image
> style, so make sure that style is big enough to show genuine detail rather than
> a blurry upscale.
