# Image Scale and Crop (Without Upscale) — manual setup guide

**Image Scale and Crop (Without Upscale)** (`image_scale_and_crop_without_upscale`)
adds an image effect that behaves like Drupal core's **Scale and Crop**, but with one
crucial difference: it **refuses to enlarge** an image that is already smaller than
the target dimensions. So a small upload stays small and sharp instead of being blown
up into a blurry, artefacted mess.

Core's Scale and Crop always produces an image at exactly the configured size,
scaling *up* when the source is smaller. That's right for a design that needs an exact
box, but on a site where editors upload whatever they have, it means a 400‑pixel logo
becomes a soft 1200‑pixel banner — and nobody notices until it's in production. The
core alternatives don't help: Scale alone won't crop to an aspect ratio, and Scale
and Crop can't be told to stop. This effect fills that gap. When the source is smaller
than the target, it scales the *target dimensions* down instead — keeping the target's
aspect ratio while never upscaling the image.

For example, a 200×200 source with a 300×200 (3:2) target yields **200×133** here,
where core would produce a stretched 300×200. The only dependency is core **Image**,
and it supports Drupal 9, 10 and 11.

The design consequence to plan for is that derivatives are **no longer guaranteed to
be a fixed size**. A layout that assumes exact dimensions needs CSS that tolerates a
smaller image (`max-width` / `object-fit` rather than a fixed `width`/`height`) —
generally the better outcome than a stretched image, but a decision rather than a free
win.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no settings page** for this module. It adds an image effect you choose
inside an image style, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no configuration page of its own. You use its effect from
**Configuration → Media → Image styles**
(`/admin/config/media/image-styles`), when adding an effect to an image style.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Configuration → Media → Image styles** and edit an existing style, or add
   a new one.
3. From the **Add effect** dropdown, choose **Scale and crop (without upscaling)**
   (the effect this module provides), and add it.
4. Set the target **width** and **height**, as you would for core's Scale and Crop.
5. Save the effect and the style.

Now that image style will crop to the target aspect ratio, scaling down when needed
but never enlarging a smaller source.

> **Tip — flush old derivatives.** If you swap this effect onto a style that already
> generated images, flush that style's derivatives (or the whole image‑style cache)
> so existing images are regenerated with the new behaviour rather than served from
> the old cached versions.
