# Retina Images — manual setup guide

**Retina Images** (`retina_images`) makes your images look crisp on high‑DPI
("retina") screens. On those displays a standard-resolution image can look soft,
because the screen packs more physical pixels into the same space than the image
provides. This module adds an option to Drupal core's image effects so that an
image style outputs a higher-resolution (2x) variant, sharpening the result on
high-DPI devices.

It has **no settings form of its own** — you use it entirely from an image
style's configuration in the Field UI. It depends only on core's **Image** module.

The trade-off to weigh is **bandwidth**: 2x images are larger files, so apply this
where crispness genuinely matters (hero images, product detail, photography) and
consider Drupal's responsive image styles for the broader case. For the best
balance you may also want to set a custom quality per image style, which the
separate *Image Style Quality* module makes easy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. The retina behavior is turned
on per image style, described in "How to use it" below.

## Where it lives in the admin menu

Retina Images adds no admin page of its own. You use it from **Configuration →
Media → Image styles** (`/admin/config/media/image-styles`), on the individual
image styles you edit.

## How to use it

1. Go to **Configuration → Media → Image styles** and edit (or create) an image
   style — for example a "Large" style used for detail images.
2. In that style's effects, Retina Images makes core's image effects able to
   output a high-resolution (2x) variant. Configure the effect as you normally
   would; the module returns the higher-resolution image for the style.
3. Use that image style wherever you display the images that should stay sharp on
   high-DPI screens (in a field's **Manage display**, for instance).

> **Tip:** Because 2x images are larger, reserve this for the images where
> sharpness matters most, and consider tuning the per-style image quality (via the
> Image Style Quality module) to keep file sizes reasonable.
