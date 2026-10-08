# Auto Image Style — manual setup guide

**Auto Image Style** (`auto_image_style`) applies a different image style
depending on the **orientation** of the original image — portrait, landscape, or
square. It detects the shape of the uploaded image and picks the matching style
automatically at render time.

A single image style rarely suits every image: a crop tuned for landscape photos
mangles portraits, and vice versa. The usual fix is manual — pick a style per
image — which does not scale. This module removes that step: editors upload
whatever they have, and the right crop is applied for each shape without
per-image intervention. It is built on core's **Responsive Image** module.

This is display-layer logic with no security surface. Its whole value depends on
the orientation-to-style mapping being correct, so the one thing to get right is
confirming that each orientation is mapped to a style that produces the crop you
want. The packaged release is a **dev** version, and it supports Drupal 9.3, 10,
and 11.

This guide is written for a **human** working through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Auto Image Style has no central settings page of its own; it works through
Drupal's image-style and Responsive Image machinery:

1. Make sure the **image styles** you want to use for each orientation exist at
   **Configuration → Media → Image styles**
   (`/admin/config/media/image-styles`) — create a portrait, a landscape, and (if
   needed) a square style.
2. Map each orientation to its style so portrait images get the portrait style,
   landscape images the landscape one, and so on.
3. On mixed-orientation content — galleries, listings — the module then applies
   the matching style automatically at render.

Because the whole benefit is in that mapping being right, check the output on a
few real portrait and landscape images and confirm the crops are what you
expect.
