# Field Slideshow j360 — manual setup guide

**Field Slideshow j360** (`field_slide_show_j360`) is an **image‑field display
formatter** that turns a multi‑value image field into a **360‑degree rotating
image slider**. You upload a sequence of frames photographed around an object, and
on the front end visitors can drag to spin it through all its angles — the kind of
interactive "spin view" that's popular on commerce and product pages. The rotation
is powered by the `drupal_threesixty_slider` jQuery library.

The formatter (called **Slideshow j360**) extends Drupal's core image formatter and
adds a few display settings: whether to show navigation controls, and the slider's
width and height. When rendered, it collects the field's images (respecting file
access), builds the slider markup, and initializes the jQuery plugin.

> **Important — bring your own library.** The third‑party slider JavaScript is
> **not bundled** with the module. You must place `drupal_threesixty_slider` at
> `/libraries/drupal_threesixty_slider/` yourself (see
> [Installation](installation/index.md)). Drupal's status report will tell you
> whether the library was found.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, add
   the jQuery library, and enable it.

There is **no central configuration page** for this module. You choose the
formatter and set its options on an image field's display, described in "How to
use it" below.

## How to use it

1. Create (or pick) a content type with an **Image** field set to allow an
   **unlimited** number of values — this holds the frame sequence.
2. On an entity, upload the frames **in order** so the object rotates smoothly.
   (If it spins the wrong way, edit the entity and reverse the upload order.)
3. Go to **Structure → Content types → *(your type)* → Manage display**, and in
   the image field's **Format** column choose **Slideshow j360**.
4. Open the formatter settings (the gear icon) and set the **width**, **height**,
   and whether to **display navigation**. Click **Update**, then **Save**.

View the entity and the images render as a draggable 360‑degree spin view.
