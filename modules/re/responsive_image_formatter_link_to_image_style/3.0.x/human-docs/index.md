# Responsive Image formatter link to image style — manual setup guide

**Responsive Image formatter link to image style**
(`responsive_image_formatter_link_to_image_style`) is an image field formatter
that does two things core can't quite do together: it renders the image with a
**responsive image style** (art‑directed `<picture>` output) *and* wraps it in a
**link to a derivative created by a chosen image style** — for example, a
responsive thumbnail that clicks through to a large version, or straight to the
original file.

That combination makes it the natural fit for **thumbnail‑to‑large** patterns and
**lightbox galleries**: you get the performance and art‑direction benefits of
responsive images for the preview, plus a full‑size click‑through for zoom,
download, or a lightbox pop‑up. You can also attach custom **CSS classes** and
**`rel` attributes** to the link (handy for wiring up Colorbox, PhotoSwipe, and
similar front ends) and custom classes to the `<img>` element.

It renders with correct cache handling — cache tags from the responsive image
style, the linked image style, and the file are merged in — and if you leave the
link's image style empty, the link points to the **original** image. There is no
global settings page; everything is configured per field on *Manage display*.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. You configure it on an image
field's display, described in "How to use it" below.

## How to use it

1. Go to the **Manage display** of a bundle that has an image field (for example
   **Structure → Content types → *(your type)* → Manage display**).
2. For the image field, choose the **Responsive Image link to image style**
   formatter.
3. Click the gear/settings icon and set:
   - the **responsive image style** used to render the visible image,
   - the **image style** the link points to (leave empty to link to the original
     file),
   - optional **link classes** and **link `rel`** attributes (for example
     `rel="lightbox"`), and
   - optional **image classes** on the `<img>` element.
4. Save. Each image now renders responsively and links to the larger derivative
   (or original), ready for a lightbox or a full‑size view.

> **Tip:** To build a lightbox gallery, add the `rel`/class values your lightbox
> library expects here, and enable that library's own behavior on the field's
> container.
