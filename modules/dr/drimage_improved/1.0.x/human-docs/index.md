# Drimage — manual setup guide

**Drimage** (`drimage_improved`) is a "Dynamic Responsive Image" field
formatter. Instead of asking you to define breakpoints and hand‑build a set of
responsive image styles, it measures how much space each image actually takes up
in the visitor's browser and then generates an image style sized to fit — on the
fly, the first time that size is requested. In other words, every image is served
at (close to) the exact pixel dimensions it occupies on the page, and you never
have to touch the Responsive Image module.

Here's how it works in practice. When you pick the **Dynamic Responsive Image**
formatter on an image field, Drimage renders a lightweight placeholder. A small
piece of JavaScript measures that placeholder, rounds the size to a sensible grid
(so it doesn't create a thousand near‑identical styles), and requests the image at
that width and height. A controller then finds or **creates** an image style named
`drimage_improved_<width>_<height>`, produces the derivative — optionally as a
modern WebP — and delivers it. Later requests for the same size reuse the style
that already exists.

Drimage is a maintained fork and successor of the original `drimage` module. It
depends only on core's **Image** module, and it plays nicely with popular add‑ons:
**Focal Point** for focus‑aware crops, **Image Widget Crop** for named crop types,
**Automated Crop**, and **ImageAPI Optimize WebP**. A `drimage_s3fs` submodule
adapts delivery for images stored on Amazon S3.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and note the optional S3 submodule.
2. [Configuration](configuration/index.md) — the global settings form and the
   per‑field formatter options, field by field.

## Where it lives in the admin menu

The global settings form sits at **Configuration → Media → Drimage**
(`/admin/config/media/drimage_improved`). The per‑field options live on each
image field's **Manage display** tab, where you choose the *Dynamic Responsive
Image* formatter.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to the display settings of a content type — **Structure → Content types →
   *(your type)* → Manage display** — and find an image field.
3. In the **Format** column, choose **Dynamic Responsive Image**.
4. Click the gear icon to pick an image‑handling mode (scale, fixed aspect‑ratio
   crop, background image, container size, or an Image Widget Crop type) and save.
5. View a page with that field. Drimage serves the image at the size it renders,
   creating the matching image style the first time it is needed.

Because styles are created on demand, you don't have to pre‑build anything. If you
ever change the grid settings and want to clear out the accumulated styles, run
`drush drimage_improved:delete-styles` — they regenerate on the next page view.
