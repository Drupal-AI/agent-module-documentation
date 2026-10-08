# Simple Slideshow — manual setup guide

**Simple Slideshow** (`simple_slideshow`) adds a field formatter that turns a
multi-value image field into a **Splide.js** slideshow. Instead of rendering a
stack of images one under another, it displays them as a sliding carousel — handy
for image galleries, hero rotators, or product-photo carousels without writing any
custom theme code. It's a small, fast fork of Imagefield Slideshow that swaps
jQuery for Splide, a lightweight, accessible slider written in TypeScript with no
dependencies.

Because it's a formatter, there's no settings page and nothing to switch on
globally — you enable the module, then choose the "Simple Slideshow" formatter on
the **Manage display** of any entity that has an image field. Each display gets its
own set of options: image style, transition effect (slide, loop, or fade),
autoplay, rewind, speed, start index, slides per page, gap and padding, navigation
arrows, pagination dots, a custom arrow SVG, pause-on-hover, lazy loading,
direction (left-to-right, right-to-left, or top-to-bottom), and an optional "link
image to" mode. You can reuse the formatter on as many image fields and view modes
as you like, each configured independently.

The module depends only on core's **Image** module, but it needs the **Splide**
JavaScript library placed in your site's `libraries` folder — see
[Installation](installation/index.md) for that step, which is easy to miss. It adds
no routes, permissions, or configuration entities of its own. It works on Drupal 8,
9, and 10.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module, add the Splide
   library, and enable it.

## How to use it

A common recipe, straight from the module's own instructions, is to build a
reusable slideshow block:

1. Create a new block type at **Structure → Block types**
   (`/admin/structure/block/block-content/types`) — for example "Banner Block."
2. Add an **Image** field to it and set *Allowed number of values* to more than one
   (or Unlimited).
3. On the block type's **Manage display**, set the image field's *Format* to
   **Simple Slideshow** and choose your slideshow options.
4. Add a custom block of that type at `/block/add`, upload your images, and save.
5. Place the block into a region via **Block layout**.

The same formatter works on any entity with an image field, not just blocks — pick
"Simple Slideshow" on its Manage display and tune the per-display options there.
