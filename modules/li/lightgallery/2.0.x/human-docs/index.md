# lightGallery — manual setup guide

**lightGallery** (`lightgallery`) integrates the popular
[lightGallery](https://www.lightgalleryjs.com/) JavaScript library with Drupal's
image and media fields. When a visitor clicks a thumbnail, the images open in a
polished lightbox gallery with zoom, thumbnails, captions, fullscreen, and
touch/swipe navigation on mobile — turning an ordinary multi‑value image or media
field into a photo gallery.

This is the **2.x** branch, which is a complete rewrite built on **lightGallery
2.x**. It provides field formatters for both image and media fields. There is no
upgrade path from the older `8.x-1.x` branch to 2.x, and 2.x drops the Views
integration that the 1.x branch had — 2.x works through field formatters on
*Manage display*.

> **Licensing note.** The lightGallery **2.x** JavaScript library is a commercial
> library that **requires a license** for most uses. This Drupal module integrates
> the library but does not grant you a license to it — review lightGallery's own
> licensing terms and obtain a license where required before using it on a
> production site. (The Drupal module code itself is GPL‑2.0‑or‑later.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   provide the lightGallery library, and enable it.

This module has **no central settings page**. Each gallery is configured on the
field itself, described in "How to use it" below. It does provide a permission
that gates who may configure the lightGallery formatter options.

## How to use it

1. Go to **Structure → Content types → *(your type)* → Manage display**
   (or the Manage display of any bundle with a multi‑value image or media field).
2. In the **Format** column for your image/media field, choose the **lightGallery**
   formatter.
3. Open the formatter settings (the gear icon) to configure gallery options —
   thumbnails, captions, autoplay, fullscreen, and the other lightGallery
   behaviors offered.
4. Save the display. On the rendered page, the field now presents its images as a
   lightGallery lightbox.
