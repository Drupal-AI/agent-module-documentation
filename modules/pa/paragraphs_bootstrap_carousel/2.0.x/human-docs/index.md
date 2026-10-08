# Paragraphs Bootstrap Carousel — manual setup guide

**Paragraphs Bootstrap Carousel** (`paragraphs_bootstrap_carousel`) adds a carousel
**paragraph type** built on Bootstrap's own carousel component. It suits a site
whose pages are assembled from Paragraphs and whose theme is already
Bootstrap‑based: the markup and behaviour come straight from Bootstrap's carousel,
so nothing extra is loaded and the slider matches the rest of your theme. The
`2.0.x` series targets **Bootstrap 5** (it will also work with Bootstrap 4, though
you may need a little CSS to fix the left/right controls).

After you install it, a new **Bootstrap carousel** paragraph type appears. You use
it like any other paragraph: add a Paragraphs field that allows the carousel type,
then add slides. On the field's **Manage display** you choose the *Paragraph
Bootstrap Carousel* formatter and map which fields supply the slide content — an
**image field is required**; a caption field is optional (leave it out and each
slide is rendered through its display mode instead). You can also pick an image
style (use *Original Image* to render the source image), and combine it with the
Responsive Image module to serve different images per breakpoint on mobile.

Two things are worth checking, and they apply to every carousel rather than this
one specifically. First, **Bootstrap's JavaScript must actually be present** — this
module does not bundle the library, so on a non‑Bootstrap theme the markup renders
but nothing rotates. Second, carousels have a poor accessibility record:
auto‑advancing content that moves on its own is a WCAG problem unless it can be
paused, and the controls need accessible names and keyboard operation. Verify both
rather than assuming the framework handles them.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no central configuration page** for this module — it has no settings
form. You configure each carousel on your Paragraphs field's *Manage display*, as
described in "How to use it" below.

## Where it lives in the admin menu

The module adds no admin settings page. You work with it entirely from **Structure
→ Paragraph types** (where the new *Bootstrap carousel* type lives) and from your
host entity's field configuration and **Manage display**.

## How to use it

1. Enable the module (see [Installation](installation/index.md)). A new **Bootstrap
   carousel** paragraph type is added automatically.
2. Add an Entity Reference Revisions (Paragraphs) field to the entity where you
   want a carousel, and allow the *Bootstrap carousel* paragraph type on it.
3. On that field's **Manage display**, choose the **Paragraph Bootstrap Carousel**
   formatter. Map the **image** field (required); optionally map a **caption**
   field, and set an **image style** (choose *Original Image* to use the source
   image, or a responsive image style for mobile carousels).
4. Add content: create carousel paragraphs, add slides (each with its image and
   optional caption), and reorder them by dragging in the widget.

> **Reminder:** make sure your theme loads Bootstrap's JavaScript, and confirm the
> carousel can be paused and operated by keyboard before relying on it for
> important content.
