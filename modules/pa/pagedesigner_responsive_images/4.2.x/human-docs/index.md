# Pagedesigner Responsive Images — manual setup guide

**Pagedesigner Responsive Images** (`pagedesigner_responsive_images`) is an add‑on for
the [Pagedesigner](../../../pagedesigner/4.x/human-docs/index.md) drag‑and‑drop page
builder that improves how images placed in built pages are delivered. It adds
**responsive image** handling — producing the `srcset`/`<picture>`‑style markup that
serves multiple sizes of an image for different viewport widths, plus multiple
resolutions of each — and it integrates with **WebP optimization** so images are also
served in the modern, lighter WebP format. The result is smaller image payloads,
better performance, and healthier Core Web Vitals.

It layers on top of Pagedesigner's image component, so it governs how images
*render*, not who can see them — it has no access‑control role. The module provides its
own permission tied to the Pagedesigner image feature. A related submodule,
`pagedesigner_focal_point`, adds focal‑point‑based cropping if you want editors to
control the crop centre.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Pagedesigner, the Pagedesigner image submodule, and the WebP optimize
   pipeline.

This add‑on has **no separate configuration page** (its configure route is empty). Once
enabled it works within Pagedesigner's image handling; responsive/WebP behaviour builds
on your site's image styles and the WebP optimize pipeline. Set up the base
[Pagedesigner](../../../pagedesigner/4.x/human-docs/index.md) module first.

## How to use it

1. Install and enable Pagedesigner, its image submodule, and this module (see
   [Installation](installation/index.md)).
2. Place images in Pagedesigner content as usual — they are now delivered as responsive,
   WebP‑optimized images.
3. If you enable the optional `pagedesigner_focal_point` submodule, editors can set a
   focal point so crops keep the important part of each image in frame.
