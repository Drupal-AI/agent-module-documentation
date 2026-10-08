# Focal Point Focus — manual setup guide

**Focal Point Focus** (`focal_point_focus`) takes the focal point an editor sets
on an image and carries it through to the browser as a CSS `object-position`
value — so an image that fills a fixed-aspect container keeps its subject in
frame **without generating a separately cropped image derivative**.

The regular [Focal Point](https://www.drupal.org/project/focal_point) module
works by baking the focal point into cropped derivatives at generation time. That
is great when you know the output size in advance, but it does not help the modern
layout pattern where an image fills a flexible container with `object-fit: cover`:
there the browser crops from the centre regardless of what the editor marked, and
faces get cut off in exactly the way the focal point was meant to prevent. Focal
Point Focus fixes that by emitting `object-position` so the browser's own cropping
honours the chosen point. One derivative can then serve many container shapes
correctly — fewer image styles, less storage.

This is a **field formatter**, configured on an image field's *Manage display*.
It has no admin settings page of its own. The rendered output uses a `<figure>`
tag (with the image's *title* as a `<figcaption>` and the *alt* text supported),
and it ships a Twig template you can override. It depends on `focal_point` (and,
through it, the Crop API), and targets Drupal 10 and 11.

> **This is not an ImageCache/crop module.** The image you attach is output at its
> own dimensions; those dimensions are what the JavaScript uses to reposition the
> image. Because the crop target is lost once ImageCache generates a new size, the
> focus script cannot be applied on top of a cropped derivative.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Focal Point.

There is **no configuration page** for this module — it has no settings form. You
set it up on your image field's display, described in "How to use it" below.

## Where it lives in the admin menu

Focal Point Focus adds no admin page. You use it entirely from **Structure →
Content types → *(your type)* → Manage display**, where it appears as a format
option for image fields.

## How to use it

1. Make sure **Focal Point** is set up: your image field's **form display**
   (widget) should use the *crop thumbnail* preview image style, so editors can
   place the focal point.
2. Go to your content type's **Manage display** for the view mode you want.
3. Set the image field's format to the **Focal Point Focus** formatter.
4. Configure the formatter's options — most importantly the expected **display
   height** for this view mode. This height is key: the JavaScript uses it,
   together with the width of the space the image occupies, to reposition the
   image so the focal point stays visible. Other options include *mute title*,
   *first-only*, and (from 2.1.x) a *lazy load* attribute and breakpoint-based
   height selection using your theme's `@media` rules.
5. Make sure the element wrapping the rendered image is block-displayed
   (`display: block`) and has a width set (for example `width: 100%`); if it is
   used as a column, give it a relative width rather than only floating it.

Because this positions the image with CSS rather than cropping it, use a source
image with sensible real-pixel dimensions — large enough to look sharp at the
sizes it will render, but not so large that it slows the page down.
