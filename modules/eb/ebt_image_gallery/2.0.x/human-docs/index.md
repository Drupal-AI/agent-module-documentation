# Extra Block Types (EBT): Image Gallery — manual setup guide

**Extra Block Types (EBT): Image Gallery** (`ebt_image_gallery`) adds a ready‑made
**Image Gallery** block: a grid of thumbnails that open full‑size in a **GLightbox**
viewer. Because it is a *block* type (not a paragraph), you can place it wherever a
block goes — in a region through Block layout, in a Layout Builder section, or
referenced from a field — which makes it the right shape for a gallery that should
appear on many pages or in a sidebar rather than inside one page's body.

It is part of the **Extra Block Types (EBT)** family, sharing the **EBT Core**
(`ebt_core`) base for common design options — spacing, background, borders, and
container width. Beyond EBT Core it depends on core **Media** and the **GLightbox**
module for the viewer. GLightbox is a modern, vanilla‑JavaScript lightbox with no
jQuery. Because the gallery is built on Paragraphs and ordinary Drupal fields, you
can adjust the image size or swap the lightbox using the Fields UI.

One install prerequisite worth knowing: like its EBT siblings, the block's field
configuration references an **image media type**. If none exists on your site yet,
create the image media type before enabling, or the install can fail on an unmet
configuration dependency.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, Composer install, and
   enabling the module.

## Where it lives in the admin menu

EBT Image Gallery adds no configuration page of its own. You use it by placing an
**Image Gallery** block: in **Layout Builder**, at **Structure → Block layout**, or
as a reusable block under **Content → Blocks → Add content block**.

## How to use it

1. Add an Image Gallery block through Layout Builder or Block layout.
2. Add your images (each gallery item is a Paragraph, so you add as many as you
   need).
3. Set spacing, background, and container width using the shared **EBT Core** design
   options, then save and place the block.

When you enable the lightbox, verify the usual accessibility behaviours: focus is
trapped inside the viewer while open, returns to the thumbnail on close, Escape
dismisses it, and the viewer is announced as a dialog.
