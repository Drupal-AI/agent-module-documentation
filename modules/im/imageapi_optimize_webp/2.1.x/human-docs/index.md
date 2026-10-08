# ImageAPI Optimize WebP — manual setup guide

**ImageAPI Optimize WebP** (`imageapi_optimize_webp`) generates modern **WebP**
versions of your images so browsers can download smaller, faster-loading files.
WebP typically produces much smaller files than JPEG or PNG at the same visual
quality, which is one of the easiest wins for site performance.

It works as an add-on to the **ImageAPI Optimize** (Image Optimize) module. That
module lets you build *pipelines* — ordered lists of image processors that run
whenever Drupal creates a styled image derivative. This module contributes one
new processor, the **WebP Deriver**. Drop it into a pipeline and, for every image
your image styles produce, it writes a matching `.webp` copy right next to the
original. When a browser requests that `.webp` URL, the module serves the WebP
file with the correct content type.

The base module creates and serves the `.webp` files; it's up to your theme or
markup to reference them (typically via a `<picture>` element or `srcset`). If
you use core's **responsive image** fields, the bundled
`imageapi_optimize_webp_responsive` submodule wires the WebP `<source>` in for
you automatically.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer
   (alongside Image Optimize), enable it, and pick the submodule you need.
2. [Configuration](configuration/index.md) — create a pipeline with the WebP
   Deriver, set the quality, and assign it to your image styles.

## Where it lives in the admin menu

This module has no page of its own — you configure it through Image Optimize's
screens:

- **Image Optimize pipelines** at **Configuration → Media → Image Optimize
  pipelines** (`/admin/config/media/imageapi-optimize-pipelines`), where you add
  the WebP Deriver to a pipeline.
- **Image styles** at **Configuration → Media → Image styles**
  (`/admin/config/media/image-styles`), where you assign a pipeline to a style.

## How to use it

In short: create an Image Optimize pipeline that includes the **WebP Deriver**
processor, then either set that pipeline as the sitewide default or assign it to
the specific image styles you want WebP for. Once a pipeline with the WebP Deriver
is applied to a style, `.webp` copies are generated and served automatically. The
full step-by-step is in [Configuration](configuration/index.md).
