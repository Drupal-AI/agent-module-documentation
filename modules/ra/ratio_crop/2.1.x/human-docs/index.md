# Ratio Crop — manual setup guide

**Ratio Crop** (`ratio_crop`) adds a new image effect called **Ratio crop** that
crops any image to a fixed aspect ratio — `16:9`, `1:1`, `4:3`, or whatever you
choose. Unlike core's "Scale and crop" effect, which needs exact pixel
dimensions, you give Ratio Crop a *ratio* and it works out the largest possible
area of each source image that matches. It only trims the longer dimension and
never upscales, so one image style produces tidy, consistent derivatives from
uploads of any size.

You use it exactly like any other image effect: add it to an **image style**
under *Configuration → Media → Image styles*. The effect has two settings — the
aspect ratio (as `W:H`) and an anchor that decides which part of the image to
keep (for example, keep the top so faces aren't cut off in a square crop). Once
the style is set up, apply it anywhere image styles are used: field formatters,
Views, responsive image mappings, and media library thumbnails.

Because the effect reports its output dimensions before the derivative is even
generated, the browser gets correct `width`/`height` in the markup and
responsive `srcset` sources stay accurate — which helps avoid layout shift. It
depends only on core's Image module and uses the standard GD toolkit, so it works
on a plain Drupal install with no extra libraries.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add the Ratio crop effect to an
   image style and set its aspect ratio and anchor.

## Where it lives in the admin menu

Ratio Crop has no admin page of its own. You use it from **Configuration → Media
→ Image styles** (`/admin/config/media/image-styles`), where **Ratio crop**
appears in the list of effects you can add to any image style.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Create or edit an image style and add the **Ratio crop** effect (see
   [Configuration](configuration/index.md)).
3. Set the style's **Aspect ratio** and **Anchor**, then save.
4. Use that image style anywhere — an image field's display formatter, a View, a
   responsive image style — and every rendered image is cropped to your ratio.
