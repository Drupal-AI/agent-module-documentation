# Slimbox2 — manual setup guide

**Slimbox2** (`slimbox2`) adds a lightbox effect to images on your site. When a
visitor clicks a link you have marked, the image opens in an overlay on top of
the current page — with next/previous navigation for browsing a series — instead
of navigating away to a plain image URL. It is a thin Drupal wrapper around the
tiny (about 4 KB) Slimbox2 jQuery plugin.

The whole point of the module is **simplicity**. Where richer lightbox modules
(Colorbox, Lightbox2, Fancybox) offer many styles and options, Slimbox2
deliberately does one thing: install it, mark your image links, and they pop up
in a clean overlay. It offers a single lightbox style and applies only to
images. Once the module and its library are in place, you enable the effect on a
link simply by adding a `rel="lightbox"` attribute (or `rel="lightbox-series"`
to group several links into one gallery).

It is a content-display/UI feature only — it changes how images are presented and
has no content or access-control role. It works across Drupal 8, 9, 10, and 11,
is covered by Drupal's security advisory policy, and relies on the external
Slimbox2 jQuery library (see Installation).

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module, add the Slimbox2
   library, and enable it.

## How to use it

There is no settings screen — you activate the lightbox per link with an HTML
`rel` attribute:

- **A single image.** Create a link to the image file and add `rel="lightbox"`.
  Clicking it opens the image in the Slimbox overlay. For example, a link to
  `/sites/default/files/images/big-image.jpg` with `rel="lightbox"` pops that
  image up.
- **A gallery / series.** Give several image links `rel="lightbox-series"`
  instead. They are grouped so the overlay shows next/previous controls to page
  through the whole set.

See the module's `README.txt` for further details.
