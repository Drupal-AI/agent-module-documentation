# EPT Slideshow — manual setup guide

**EPT Slideshow** (`ept_slideshow`) adds a ready-made Slideshow Paragraph type to
your site, built on the [FlexSlider](http://flexslider.woothemes.com/) library.
An editor adds the paragraph, picks images through the **media library**, and gets
a slideshow. With FlexSlider's `slide` animation it can also behave as a carousel
showing several items at once.

EPT Slideshow is one module in the **Extra Paragraph Types (EPT)** family. Every
EPT module ships one ready-made Paragraph type and shares the
[`ept_core`](https://www.drupal.org/project/ept_core) base module for a common
set of per-instance *design options* (spacing, background, container width). So
there is **no site-wide settings page**: you configure each slideshow on the
paragraph where you place it.

A carousel deserves one question that rarely gets asked: usage data consistently
shows very low engagement with slides after the first, and an auto-advancing
slideshow is a recurring accessibility problem — content moves away while it is
being read, so it needs a pause control, keyboard operation, and correct
announcement, and on mobile it pushes real content below the fold. Where the
carousel has a genuine reason (an editorial rotation of featured stories, a
visitor-driven gallery) it's a fine choice; where it exists just because several
people wanted the top of the homepage, it's worth saying plainly that everything
after slide one is close to unseen.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and confirm the Paragraph type appears.

There is **no configuration page** for this module. Slideshows are configured per
instance, on the paragraph itself, using the shared EPT design options described
below.

## Where it lives in the admin menu

EPT Slideshow adds no admin settings page. Once enabled it registers a
**Slideshow** Paragraph type, listed under **Structure → Paragraphs types**
(`/admin/structure/paragraphs_type`).

## How to use it

Like every EPT component, Slideshow is used by placing it inside a **Paragraphs
field**:

1. On a content type that has an *Entity reference revisions* Paragraphs field,
   make sure the field's settings allow the **Slideshow** paragraph type.
2. Edit a piece of content, add a **Slideshow** paragraph, and pick the slide
   images from the media library.
3. Open the paragraph's **design options** (from `ept_core`) to set spacing,
   background, and width for that specific slideshow.
4. Save. The slideshow renders at the position of the paragraph in the field.
