# EPT Video and Image Gallery — manual setup guide

**EPT Video and Image Gallery** (`ept_video_and_image_gallery`) adds a gallery
Paragraph type that combines images and video in a single grid, with every item
opening in a **GLightbox** lightbox. Mixed galleries are common and awkward —
most gallery components handle either photos or video, not both — so this one is
useful when a project page wants photographs and a video clip side by side.

EPT Video and Image Gallery is one module in the **Extra Paragraph Types (EPT)**
family. Every EPT module ships one ready-made Paragraph type and shares the
[`ept_core`](https://www.drupal.org/project/ept_core) base module for a common
set of per-instance *design options* (spacing, background, container width). It
uses `glightbox` for the lightbox and `glightbox_media_video` for video handling.
There is **no site-wide settings page**: you configure each gallery on the
paragraph where you place it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Compatibility note worth reading before you adopt it.** Release **2.0.0** of
> this module has a defect against `ept_core` 2.0.0: its settings widget was not
> updated when `ept_core`'s widget base class gained two constructor arguments, so
> enabling it produces an `ArgumentCountError` — and enabling it has been observed
> to fail mid-install, leaving other modules from the same batch half-installed.
> This is the same family-wide "widget constructor" issue that also affects
> `ept_cta`. Check the resolved `ept_core` version before you rely on this
> component, pin the EPT modules together, and test the enable on a non-production
> environment first. See the [`agent/`](../agent/start.md) notes for the exact
> error.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and confirm the Paragraph type appears.

There is **no configuration page** for this module. Galleries are configured per
instance, on the paragraph itself, using the shared EPT design options described
below.

## Where it lives in the admin menu

EPT Video and Image Gallery adds no admin settings page. Once enabled it registers
a gallery Paragraph type, listed under **Structure → Paragraphs types**
(`/admin/structure/paragraphs_type`).

## How to use it

Like every EPT component, the gallery is used by placing it inside a **Paragraphs
field**:

1. On a content type that has an *Entity reference revisions* Paragraphs field,
   make sure the field's settings allow the gallery paragraph type.
2. Edit a piece of content, add the gallery paragraph, and add the images and
   video items from the media library.
3. Open the paragraph's **design options** (from `ept_core`) to set spacing,
   background, and width for that specific gallery.
4. Save. The grid renders on the page and each item opens in the GLightbox
   lightbox.
