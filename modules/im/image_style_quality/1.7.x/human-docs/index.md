# Image Style Quality — manual setup guide

**Image Style Quality** (`image_style_quality`) lets you set the output quality
(compression level) of generated images on a per‑image‑style basis. Out of the
box, Drupal applies a single global JPEG quality value from your image toolkit's
settings to every derivative it creates. That's a blunt instrument: the same
quality gets used for a tiny list thumbnail and a full‑width hero image alike.
This module adds an **image effect** you drop into any image style, with a single
setting — a quality value from 0 to 100 — so each style can compress its
derivatives independently.

The practical payoff is smaller pages without a service or external tooling. You
might serve list thumbnails at quality 60 to shave kilobytes, keep hero images at
90 so they stay crisp, and leave a "download" or print style at 100. Because the
quality is baked into the image style, it exports and deploys with your
configuration like any other effect, and editors never see extra UI — they just
use the styles you've set up.

Under the hood the effect doesn't re‑compress pixels itself. When a derivative is
generated it temporarily overrides the active image toolkit's quality setting for
just that one image, so the toolkit encodes it at your chosen quality and the
global setting is left untouched. It works with the three common toolkits — GD,
ImageMagick, and Imagick — and affects the formats that toolkit's quality setting
governs (typically JPEG, and WebP where the toolkit maps quality to it).
Developers can add support for other toolkits through a small plugin type the
module defines.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Image Style Quality has no settings page of its own. Everything happens inside
the core **Image styles** admin screen at **Configuration → Media → Image styles**
(`/admin/config/media/image-styles`), where you add the effect to individual
styles.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Configuration → Media → Image styles** and click **Edit** on the style
   you want to compress (for example, *Thumbnail*).
3. In the **Effect** dropdown choose **Image Style Quality** and click **Add**.
4. On the effect's form, set the **Quality** value — an integer from **0**
   (smallest file, lowest quality) to **100** (largest file, highest quality).
   The default is **75**.
5. Drag the effect so it runs **after** your resize, scale, and crop effects, then
   save the style.

That's the whole workflow. Repeat for each style you want to tune — give
thumbnails a low value, heroes a high one, and downloads 100. To A/B different
quality levels, clone a style and change only the quality effect. The change
takes effect for newly generated derivatives; flush the style (or clear caches)
to regenerate existing ones at the new quality.
