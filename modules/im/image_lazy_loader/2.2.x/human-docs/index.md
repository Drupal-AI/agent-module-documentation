# Image Lazy Loader — manual setup guide

**Image Lazy Loader** (`image_lazy_loader`) speeds up image‑heavy pages by
**deferring image loading** until each image approaches the viewport, instead of
loading everything at once. It uses the [lozad.js](https://apoorv.pro/lozad.js/)
library to do the lazy loading and can play an animation (via
[animate.css](https://animate.css/)) as images appear on scroll.

You decide per display whether an image field is loaded normally or lazy‑loaded,
choose the appearance animation, and set its duration — so below‑the‑fold images no
longer add to the initial page weight. The result is a lighter first load and better
Core Web Vitals on pages with lots of imagery. It depends only on core's **Image**
module.

Modern browsers also support native `loading="lazy"`; this module uses lozad for
finer control over the animation and for broader/older‑browser coverage. It is a
front‑end performance feature — it affects *how* images load, not content or access.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the module settings, plus how to turn
   lazy loading on for a field's display.

## Where it lives in the admin menu

The module's settings form is at **Configuration → Media → Image Lazy Loader**
(`/admin/config/media/image-lazy-loader`). The lazy‑loading behaviour itself is
switched on per field at **Structure → *(bundle)* → Manage display**, in the image
field's formatter settings.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to the **Manage display** page for the content type whose image field you want
   to defer.
3. In the image field's formatter settings, choose to **lazy‑load** the image and
   pick the appearance animation and duration you want.
4. Save the display and load a page with images below the fold — they should now
   load as you scroll toward them, animating in.

See [Configuration](configuration/index.md) for the module‑wide setting that lets
you avoid loading animate.css twice if your theme already includes it.
