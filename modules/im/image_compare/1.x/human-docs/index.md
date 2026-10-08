# Image Compare — manual setup guide

**Image Compare** (`image_compare`) adds a **before/after comparison slider**
formatter to image fields — the familiar interaction where you drag a handle across
one image to reveal another underneath. It is a natural fit for renovation
before/afters, photo edits, product configurations, and anything where two images
are best understood side by side.

Its standout feature is **accessibility**. The slider is built on a plain HTML
`range` input, which makes it one of the most accessible image-comparison sliders
available — it works with the keyboard out of the box. Because that is the module's
selling point, do confirm the keyboard operation meets your requirements on your own
site and that the two images are sized appropriately.

Three optional submodules extend it: **Image Compare Accessible Slider for Media**
(`image_compare_media`) makes it work with Media entities of type Image,
**Image Compare Responsive** (`image_compare_responsive`) adds responsive support,
and **Image Compare Media Responsive** (`image_compare_media_responsive`) combines
both.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, add the required
   JavaScript library, and enable the submodules you need.

There is **no separate configuration page** for this module — its options are set
per field on *Manage display*, described in "How to use it" below.

## Where it lives in the admin menu

Image Compare adds no admin settings page. You use it entirely from **Structure →
Content types → *(your type)* → Manage display**, where it appears as a formatter for
image fields.

## How to use it

1. Add a **multi-value image field** to your content type (the slider needs at least
   **two** images — the "before" and the "after").
2. On the entity's **Manage display**, set that field's format to **Image Compare
   Accessible Slider**.
3. Click the gear icon to configure the formatter. Available options include:
   - **starting_position** — where the slider handle sits initially, `0`–`100`
     (default `50`).
   - **show_captions** — turn captions on or off; captions can come from the image
     `alt`/`title` attributes or from a custom field.
   - **label_text** — the usage-explanation message read out to screen readers.
   - **keyboard_step** — how far each keypress moves the slider (a higher value can
     improve keyboard usability).
   - **step** — can be set below `1` (for example `0.01`) to smooth out mouse
     dragging; use together with `keyboard_step`.
4. Captions are optional — leave the caption field unset to disable them globally,
   or override options per instance using a custom options field for content-specific
   settings. **Update** and **Save**.
