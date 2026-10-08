# Image Slider Gallery — manual setup guide

**Image Slider Gallery** (`slider_gallery`) changes how image collections are
presented on your site. Instead of showing images in a plain, static grid, it
overrides the image output so a set of images displays as an interactive
sliding gallery — a carousel your visitors can page through — using a Fancybox
style pop-up/gallery presentation.

The point of the module is visual polish: if you have galleries of photos,
product shots, or portfolio images, this turns them into a slider/carousel that
feels more engaging than a wall of thumbnails. It is purely a display feature —
it does not create content of its own, and it does not change who can see or
edit anything. It works on Drupal 10 and 11 and has no other module
dependencies.

Note that this is a young, small module (first released in 2026) and it is
**not covered by Drupal's security advisory policy**, so weigh that before using
it on a high-stakes production site.

This guide is written for a **human** setting the module up through the admin
UI. If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Once enabled, the module changes the way images are output so they render as a
slider/carousel gallery rather than a static grid. Point it at the image content
you want to showcase, and visitors can slide through the collection as an
interactive gallery. There is no separate settings screen to work through — the
gallery presentation is the feature.
