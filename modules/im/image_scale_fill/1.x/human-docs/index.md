# Image Scale and Fill — manual setup guide

**Image Scale and Fill** (`image_scale_fill`) adds a new image‑style *effect* to
Drupal. When you need to fit varied images into a fixed slot — a card, a
thumbnail, a hero — without letterboxing or distorting them, this effect scales
the image to fit the target dimensions and then fills the leftover space with a
background of your choosing.

You can fill that background four ways: a **tiled** copy of the image, a
**blurred** version of the image, the image's **dominant color** as a solid
fill, or a **gradient** built from that dominant color. Options let you tune the
blur intensity, gradient direction, resize ratio, and overlay transparency, so
the same source image can be displayed at different aspect ratios while keeping a
consistent, polished frame. The module uses PHP's **GD** toolkit that ships with
Drupal, and depends only on core's Image module.

Because it is an image‑style effect, there is no separate settings page. You add
and configure it from the core **Image styles** UI, exactly like the crop,
scale, and convert effects that come with Drupal.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no dedicated settings page** for this module. You configure the effect
inside an image style, described in "How to use it" below.

## Where it lives in the admin menu

Image Scale and Fill adds no admin page of its own. You use it from the core
**Image styles** screen at **Configuration → Media → Image styles**
(`/admin/config/media/image-styles`).

## How to use it

1. Go to **Configuration → Media → Image styles** and either add a new style or
   edit an existing one.
2. From the **Effect** select list, choose **Scale and Fill** (the effect this
   module provides) and click **Add**.
3. On the effect's settings form, set the options that fit your design:
   - **Width and Height** — the target area the image should scale to fit.
   - **Background Type** — tiled, blurred, dominant color, or gradient.
   - **Background Style** — how the chosen background type is rendered.
   - **Blur Radius and Sigma** — the intensity and spread of the blur (only when
     the blurred background type is selected).
   - **Resize Ratio** — the scale percentage applied before the effect runs, to
     balance performance against the look you want.
   - **Gradient Direction** — vertical or horizontal (only for the gradient
     background type).
   - **Overlay Transparency** — the transparency level of the overlay (only when
     a transparent overlay background style is selected).
4. Save the effect, then **Save** the image style.
5. Use that image style wherever you display images — on a field's *Manage
   display*, in a Views field, or in a responsive image style mapping.

> **Tip:** Preview the result on a few images with very different aspect ratios
> (a tall portrait and a wide landscape) to confirm the fill behaviour suits your
> content before you use the style in production.
