# Responsive Gallery — manual setup guide

**Responsive Gallery** (`responsive_gallery`) provides an image field formatter
that turns a **multi‑value image field** into a modern, responsive image gallery
with a built‑in lightbox. Each image becomes a thumbnail in a grid that reflows
by screen size, and clicking a thumbnail opens a touch‑friendly viewer
(powered by a bundled fancyBox‑style component) with swipe, drag, and
pinch‑to‑zoom gestures — no external JavaScript library to install.

You control how many images sit per row at four device sizes — **extra‑large**,
**large**, **medium**, and **small** — and which image style is used for the
thumbnails, all from the field's display settings. Images in the same field are
automatically grouped together in the lightbox, so paging through a set "just
works." You can also add a custom wrapper class for styling hooks.

If you want to change the markup or layout, the module ships a Twig template
(`templates/responsive-gallery.html.twig`) you can copy into your theme and
customize — it exposes the wrapper class, the thumbnail images, and the
thumbnail classes as variables. Responsive Gallery depends only on core's
**Field** module and has no settings page of its own; everything is configured on
a field's *Manage display*.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. You set it up on an image
field's display, described in "How to use it" below.

## How to use it

1. Make sure you have a **multi‑value image field** (cardinality greater than
   one) on a content type or other fieldable entity — this is what becomes the
   gallery.
2. Go to that bundle's **Manage display** (for example **Structure → Content
   types → *(your type)* → Manage display**), or the display of the View where
   the field appears.
3. For the image field, choose the **Responsive Gallery** formatter.
4. Click the gear/settings icon and configure:
   - the **image style** used for the thumbnails,
   - an optional **wrapper class**, and
   - the **number of images per row** for extra‑large, large, medium, and small
     devices.
5. Save. Front‑end visitors now see a responsive grid; clicking any image opens
   the gallery lightbox.

> **Tip:** For galleries with many images, consider pairing this with an
> image style sized appropriately for thumbnails, and confirm the grid looks
> right against your theme before going live.
