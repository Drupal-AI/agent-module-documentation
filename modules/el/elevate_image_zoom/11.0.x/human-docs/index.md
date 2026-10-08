# Elevate Image Zoom — manual setup guide

**Elevate Image Zoom** (`elevate_image_zoom`) adds a magnify‑on‑hover zoom effect
to images on your site using the Elevate Zoom JavaScript library. It provides a
**field formatter** you apply to an image field, so that when a visitor hovers
over (or interacts with) an image, they see a magnified view — ideal for product
photos, detailed artwork, or any picture where the detail matters. If a field
holds several images, the formatter renders them as an image gallery.

The library supports several zoom styles — basic zoom, tint zoom, inner zoom,
lens zoom, and mouse‑wheel zoom — which you pick in the field's display settings.

This module depends on the **Elevate Zoom JavaScript library**, which is *not*
bundled: you must download it yourself and place it in your site's `libraries`
directory before the zoom effect will work. See [Installation](installation/index.md)
for the details. This is a front‑end presentation feature only — it changes how
images are displayed and does not affect media handling or access control.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   download the Elevate Zoom library, and enable it.

This module has **no configuration page** of its own. You configure it entirely
on a field's display settings, described in "How to use it" below.

## Where it lives in the admin menu

Elevate Image Zoom adds no admin settings page. You use it from **Structure →
Content types → *(your type)* → Manage display**, where you set an image field's
format to the Elevate Image Zoom formatter.

## How to use it

1. Make sure you have downloaded the Elevate Zoom library into
   `/libraries/elevatezoom` (see [Installation](installation/index.md)).
2. Go to **Structure → Content types → *(your content type)* → Manage display**.
3. Find the image field you want to enhance and, in the **Format** column,
   choose the Elevate Image Zoom formatter.
4. Click the settings cog to pick the zoom style (basic, tint, inner, lens, or
   mouse‑wheel) and save.
5. To render multiple images as a **gallery**, set the image field to allow
   multiple values and upload several images to the same field — the formatter
   will render them in gallery format.
