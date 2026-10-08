# Blazy PhotoSwipe — manual setup guide

**Blazy PhotoSwipe** (`blazy_photoswipe`) registers the PhotoSwipe JavaScript
lightbox as an option for Blazy-powered image displays. Once enabled, editors get
an **"Image to PhotoSwipe"** choice in the **Media switch** select of any Blazy
formatter — so images (and swipeable local videos) open in a zoomable, swipeable
PhotoSwipe gallery with pinch-to-zoom, swipe navigation and keyboard controls, and
no custom JavaScript on your part.

It is a thin integration layer, not a standalone gallery: it ships no field type,
no formatter and no settings page of its own. Instead it hooks into the **Blazy**
module (3.x) and adds PhotoSwipe to Blazy's list of lightboxes. That makes the
option appear on the Blazy image formatter, `blazy_media`, `blazy_oembed`,
`blazy_file`, `blazy_entity`, and on Slick / Splide / GridStack formatters and
Blazy Views fields. It supports both PhotoSwipe **4** (the default) and PhotoSwipe
**5**, which you switch on from Blazy's own settings form.

Two things must be in place besides this module: the **Blazy** module (>= 3.x),
which is a hard dependency, and the **PhotoSwipe JavaScript library** itself,
placed under `/libraries/photoswipe`. For PhotoSwipe 4 you may also want the
optional `drupal/photoswipe` contrib module, which supplies extra library plumbing
and a settings source; for PhotoSwipe 5 it is not required.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and place the PhotoSwipe library.

## Where it lives in the admin menu

Blazy PhotoSwipe adds no menu items and no form of its own. You turn it on **per
display** on a bundle's *Manage display* page, and choose the PhotoSwipe major
version (4 vs 5) on **Blazy's** settings form at **Configuration → Media → Blazy UI**
(`/admin/config/media/blazy`).

## How to use it

**Turn on the lightbox for a field (per display):**

1. Open a bundle's **Manage display** (for example an Article's image field at
   `/admin/structure/types/manage/article/display`).
2. On the image or media field, pick a **Blazy** (or Slick / Splide) formatter and
   click its cog.
3. Set **Media switch → Image to PhotoSwipe**.
4. Choose a **Thumbnail style** (the initial, small image) and a **Lightbox image
   style** (the full-resolution image shown in the overlay). Save.

Visitors clicking the image now open it in a PhotoSwipe overlay; multi-value image
fields become a swipeable gallery automatically.

**Choose PhotoSwipe 4 or 5 (site-wide):** PhotoSwipe 4 is the default. To use
PhotoSwipe 5, go to `/admin/config/media/blazy`, open **Extra settings**, set
**PhotoSwipe → PhotoSwipe 5**, save, and clear caches. (Leaving it empty keeps
PhotoSwipe 4.)

**Customising the lightbox:** developers can override the options passed to the
PhotoSwipe library (background opacity, animations, zoom, loop, …) with a small
alter hook — see [`agent/hooks/js-options.md`](../agent/hooks/js-options.md).

> **The library must be present.** If the PhotoSwipe JS files are missing from
> `/libraries/photoswipe`, the Media switch option is still selectable but the
> lightbox will not open. See [Installation](installation/index.md).
