# Image Effects — manual setup guide

**Image Effects** (`image_effects`) adds a large suite of extra image-style
effects to Drupal, going well beyond the handful that core provides (scale, crop,
resize, desaturate, rotate). Once the module is installed you gain roughly two
dozen additional effects that you apply on **image styles** — including
brightness/contrast, saturation and color-shift filters, watermark/overlay,
text overlay, rounded corners and set-canvas, background compositing, auto-orient
from EXIF, Gaussian blur, pixelate, mirror, smart crop, and more. Because the
effects live on image styles, every derivative image generated with that style
picks them up automatically, wherever the style is used on your site.

To keep the effect forms consistent, Image Effects defines three reusable
"selector" pickers — a **color selector**, an **image selector**, and a **font
selector** — that you choose once on the module's own settings page. The effects
themselves are then added and configured on Drupal's Image styles screen.

This guide is written for a **human** clicking through the admin UI. It walks you,
step by step and with screenshots, from installing the module to choosing the
selector plugins and applying your first effect on an image style. If you are
looking for terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

![The Image Effects settings page showing the color, image, and font selector options](images/settings.png)

## Where it lives in the admin menu

The module's own options sit under **Configuration → Media → Image Effects
settings** (`/admin/config/media/image_effects`). This page is where you pick the
color, image, and font selector plugins that the effects reuse.

The effects themselves are not applied here — they are applied on **image
styles**, under **Configuration → Media → Image styles**
(`/admin/config/media/image-styles`). You edit or add a style, then choose one of
the new Image Effects effects from that style's **Add effect** list.

## Contents

1. [Installation](installation/index.md) — install Image Effects with Composer,
   enable it and its dependencies, and note the ImageMagick toolkit.
2. [Configuration](configuration/index.md) — choose the color, image, and font
   selector plugins on the settings page, then apply an effect on an image style.
