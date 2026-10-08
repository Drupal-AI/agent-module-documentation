# ElevateZoom Plus — manual setup guide

**ElevateZoom Plus** (`elevatezoomplus`) adds image zoom — a magnifier window,
a lens that follows the cursor, or an inner zoom that magnifies inside the image
frame — to galleries and carousels built with the Blazy module. It works with
Slick and Splide carousels as well as Blazy Grid and GridStack, so you can give
product photos or gallery images a detailed close-up on hover or click without
writing any custom code.

Rather than adding its own field formatter, ElevateZoom Plus plugs into Blazy as
a lightbox / media-switcher option. You turn it on where you already configure a
Blazy, Slick, or Splide display (under **Manage display**) by picking an
ElevateZoom Plus "optionset". An optionset is a reusable, named bundle of zoom
settings — zoom type, window size, lens shape, easing, tint, and so on — that you
can apply across many displays so the zoom behaves consistently site-wide. The
module ships three starter optionsets (`default`, `inner`, `responsive`), all
disabled until you choose one.

Two things are needed for it to run: the **Blazy** module (version 3.x) and the
third-party **ElevateZoom Plus** JavaScript library, self-hosted under your
site's `/libraries` folder. The list/add/edit UI for optionsets is not in this
base module — it ships in the optional `elevatezoomplus_ui` submodule.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, add the
   JavaScript library, and enable the module (plus the optional UI submodule).

## Where it lives in the admin menu

The base module adds no admin page of its own — its `configure` link is empty.
Once you enable the **elevatezoomplus_ui** submodule, the optionset admin list
appears at **Configuration → Media → ElevateZoom Plus**
(`/admin/config/media/elevatezoomplus`), gated by the *administer elevatezoomplus*
permission.

## How to use it

Because ElevateZoom Plus rides on top of Blazy, you never write a formatter. The
typical flow is:

1. Have a Blazy-powered display already — for example an image field using the
   Blazy, Slick, or Splide formatter, or a Blazy Grid / GridStack view.
2. In **Manage display**, open that formatter's settings and choose a lightbox /
   media switcher plus an **ElevateZoom Plus** optionset.
3. Two working patterns are supported:
   - **Slick/Splide with asNavFor** — a main preview image paired with a
     thumbnail navigation strip; this works with any lightbox.
   - **Without asNavFor, or Blazy Grid / GridStack** — use the **Image to
     ElevateZoomPlus** media switcher.

At render time the module computes the zoom options, writes them onto the element
as a `data-elevatezoomplus` JSON attribute, and its JavaScript reads that
attribute to start the zoom.

Common things people build with it:

- A magnifier zoom window on product images in a Slick or Splide carousel.
- Hover-to-zoom close-ups on an e-commerce product gallery.
- An inner-zoom effect that magnifies within the image bounds.
- A lens-style zoom that follows the cursor, with a configurable lens size,
  shape, border, colour, and opacity.
- Scroll-wheel zoom for finer magnification, plus fade and easing on the
  transition.
- Zoom combined with a full-screen lightbox, falling back to a video
  (blazybox) for non-image media.

Because settings live in reusable optionsets, you create one (say a `default`
and a screen-friendly `responsive` variant) and apply it across displays for a
consistent zoom experience everywhere.
