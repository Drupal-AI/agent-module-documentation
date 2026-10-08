# Product Gallery — manual setup guide

**Product Gallery** (`product_gallery`) provides field formatters that turn an
ordinary image field — or a media reference field — into an **interactive,
e-commerce-style product gallery**: a large main image with a thumbnail strip
below it, mouse-wheel zoom, and a hover magnifier lens for inspecting product
photos up close. It's the kind of image viewer you expect on a product detail
page, built entirely from a field's display settings with no custom theming
required.

It ships two formatters. **Product Gallery** works on core `image` fields.
**Media Product Gallery** works on `entity_reference` fields pointing at media; it
resolves each media item's source file and renders only the ones that are images.
Both are highly configurable from the formatter settings: responsive image styles
per breakpoint, thumbnail shape/size/colour, optional overlapping thumbnails,
mouse-wheel zoom and default zoom scale, the magnifier lens, custom CSS classes,
and the container width.

Product Gallery is a pure **display/formatter** module — it adds no admin pages,
routes, permissions, or config entities of its own, and it doesn't fetch any
remote URLs. All of its settings live on your field's *Manage display*, exactly
where you'd configure any other field formatter.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form. You
set everything up on your image or media field's display, described in "How to use
it" below.

## Where it lives in the admin menu

Product Gallery adds no admin page. You use it entirely from **Structure →
Content types →** *(your type)* **→ Manage display**, on the image or media field
you want to present as a gallery.

## How to use it

1. Add a (typically multi-value) **image** field, or an **entity reference** field
   targeting media, to the content type that holds your products.
2. Go to that content type's **Manage display**.
3. Set the field's format to **Product Gallery** (for an image field) or **Media
   Product Gallery** (for a media reference field).
4. Click the formatter's gear/settings icon and configure the options:
   - **Image styles** — pick responsive styles for large, medium, and small
     screens, plus a dedicated thumbnail style. (The image-style selectors only
     appear for users with the *administer image styles* permission.)
   - **Thumbnails** — choose round or square borders, set the thumbnail width
     (20–140px), pick a border colour, and optionally let thumbnails overlap once
     their count passes a threshold.
   - **Zoom & magnifier** — enable mouse-wheel zoom, set the default zoom scale,
     and toggle the hover magnifier lens.
   - **Layout** — add custom CSS classes to the image and its wrapper, and set the
     container's maximum width with a unit (px, em, rem, or %).
5. Save the display, then view a product to see the main-image-plus-thumbnails
   gallery with zoom and magnifier in action.
