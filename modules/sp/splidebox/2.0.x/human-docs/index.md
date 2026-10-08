# Splidebox — manual setup guide

**Splidebox** (`splidebox`) is a lightbox for Drupal built on the modern
**Splide** slider. Click an image in a gallery and it opens full‑size in an
overlay, with the rest of the set navigable in place — swipe, arrow keys, or
thumbnail strip. It supports zoomable responsive/picture images, local and remote
video, AJAX‑loaded content, a fullscreen window, and wheel‑zoom, and it works with
product variations and Views‑based galleries.

What sets Splidebox apart from older lightboxes like Colorbox or Fancybox is the
library underneath: Splide is dependency‑free with **no jQuery**, which makes it a
natural choice on a site that has already moved past jQuery — and it means the
lightbox navigation is the very same component your theme may already use for
carousels. Since version 2.0.3 it also offers thumbnail navigation inside the
lightbox.

Splidebox is not standalone. It depends on the **Splide** module (for the library
integration) and on **Blazy** (which supplies the lazy‑loading and media‑handling
layer). Worth knowing before you commit: Blazy is a substantial module in its own
right, so pulling it in for a lightbox alone is a bigger addition than Splidebox's
own size suggests. The module runs on Drupal 10 and 11.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install Splidebox and its Splide and
   Blazy dependencies, then enable the module.

## How to use it

Splidebox has no settings page of its own — you turn it on where you configure how
images display. On a Blazy‑powered image or media field formatter, choose
**Splidebox** as the **Media switcher** option. For thumbnail navigation, also
fill in the **Thumbnail style** option on that formatter (a style with *Crop*
works best). The Splidebox behaviour itself can be adjusted in the **Blazy UI**
under its Splidebox section. For best results, use a lightbox image style that
uses *Scale* (width set, height empty) rather than a cropped one — or the original
image if it is already optimised.

A quick accessibility reminder, since it is what separates a good lightbox from a
bad one: test that keyboard focus moves into the overlay and stays there while it
is open, that **Escape** closes it, and that focus returns to the image you
clicked afterwards.
