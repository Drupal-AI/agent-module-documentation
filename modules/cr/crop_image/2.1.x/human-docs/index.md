# Crop Image — manual setup guide

**Crop Image** (`crop_image`) improves the image-cropping workflow when you select
images from the media library, and it works around a specific limitation of the
[Image Widget Crop](https://www.drupal.org/project/image_widget_crop) module: with
Image Widget Crop alone you can't reuse the *same* image and give it *different*
crops of the same crop type in different places.

Crop Image solves this by quietly duplicating an image when it's used for cropping,
and deleting the duplicate again once it's no longer needed. All of this happens
internally, so editors don't notice any change to how they work — they just gain the
ability to crop the same source image differently in different places. On top of
that, the module provides a field widget, **ImageWidget crop (with browser)**, which
lets editors browse and pick images already on the site rather than uploading a new
file every time.

It depends on **Image Widget Crop** (`image_widget_crop`) and **Entity Browser**
(`entity_browser`, version 2.10 or later), and it works on Drupal 9.3, 10, and 11.
It has no settings form of its own — you set it up by choosing its field widget on a
field's *Manage form display*, and by configuring your crop types and image styles
in the usual Crop / Image Widget Crop places.

> **Worth weighing before you adopt it.** Entity Browser is a heavier, older
> selection architecture than it looks — one that core's Media Library has largely
> displaced. If your site is already on the core Media Library, this module asks you
> to add a parallel selection system. Also consider
> [Focal Point](https://www.drupal.org/project/focal_point), which addresses much of
> the same "different framing in different places" need by storing a focal *point*
> rather than a crop rectangle.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module along with its Image Widget Crop and Entity Browser dependencies.

There is no configuration page for this module — you use it on your image field's
form display, described under "How to use it" below.

## How to use it

1. Make sure your crop types and image styles are set up as usual for the Crop /
   Image Widget Crop workflow.
2. On the entity bundle that has your image field, go to **Manage form display**
   and set that field's widget to **ImageWidget crop (with browser)**. This lets
   editors browse existing images (via Entity Browser) and crop them at selection
   time.
3. Editors can now select an image and crop it for this use without altering the
   crop used by other places that reference the same image — the module handles the
   behind-the-scenes duplication and cleanup.
