# Image Sizes Extras — manual setup guide

**Image Sizes Extras** (`image_sizes_extras`) is an add‑on for the
[Image Sizes](https://www.drupal.org/project/image_sizes) module. Where Image
Sizes swaps the whole image URL to match the container, this add‑on takes a
different, browser‑native approach: it renders a single `<img>` with a full
**`srcset`**, and a small JavaScript **ResizeObserver** sets the **`sizes`**
attribute dynamically from the element's real rendered width. The browser then
picks the best candidate itself — including on high‑DPI (2×/"retina") screens,
as long as your preset goes large enough.

It ships one field formatter, `image_sizes_extras_formatter`, which extends the
Image Sizes preset formatter. There is no configuration page, no routes, and no
permissions — you apply it entirely on a field's *Manage display*, reusing the
presets you already created in Image Sizes.

Two things are worth knowing up front. First, for crisp retina images, size your
preset up to roughly **2× the maximum display width** — for example, allow up to
1200px if the image is shown at most 600px wide. Second, the preload image
style's width and height set the aspect ratio, so presets without a fixed aspect
ratio can cause a slight layout shift as images load.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Image Sizes.

There is **no configuration page** for this module — it has no settings form.
Setup happens on your image field's display, described in "How to use it" below.

## Where it lives in the admin menu

Image Sizes Extras adds no admin page. You use it from **Structure → Content
types (or the relevant entity) → *(bundle)* → Manage display**, on any image or
image entity‑reference (media) field.

## How to use it

1. Make sure you already have an **Image Sizes** preset (Image Sizes Extras
   consumes the same presets). Create one with `drush isg …` if you haven't — see
   the Image Sizes guide.
2. Go to the image field's **Manage display** (**Structure → Content types →
   *(bundle)* → Manage display**).
3. Set the field's format to the **Image Sizes Extras** formatter and choose your
   preset.
4. Save. The field now renders a native `srcset`, and the browser chooses the
   right source as the layout and screen density dictate.

> **Tip:** Because the browser makes the final choice, make sure your preset's
> largest candidate is big enough for 2× screens — otherwise high‑DPI displays
> won't have a sharp option to pick.
