# ImageAPI Optimize - LQIP — manual setup guide

**ImageAPI Optimize - LQIP** (`imageapi_optimize_lqip`) adds a *Low-Quality
Image Placeholder* processor to the [ImageAPI Optimize](https://www.drupal.org/project/imageapi_optimize)
(also known as Image Optimize) pipeline system. A LQIP is a tiny, deliberately
blurry version of an image that a browser can show almost instantly while the
full-resolution picture is still downloading. Swapping the blur for the real
image once it arrives makes a page *feel* faster, because visitors see
something in the image's place from the very first moment.

This module does not do anything on its own. It plugs a new processor into
ImageAPI Optimize, and you switch that processor on inside an *optimize
pipeline*. When an image style that uses the pipeline generates a derivative,
the processor creates a matching LQIP file (a PNG or JPG) alongside the original
in the same folder. The placeholder itself is produced by calling the external
**Dev Weapons** API, so the module needs outbound network access to reach that
service.

Because it is a pipeline processor, it has **no settings page of its own** — you
configure it on a pipeline at **Configuration → Media → Image Optimize
pipelines**. It depends on core's File module and on the ImageAPI Optimize
module, which must be installed first. A bundled companion, *ImageAPI Optimize
LQIP Responsive*, can wire the placeholders into your markup automatically; you
can also reference the generated LQIP by hand in a theme template.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and its ImageAPI Optimize dependency.

There is **no configuration page** for this module — it has no settings form of
its own. You add the LQIP processor to an Image Optimize pipeline, described in
"How to use it" below.

## Where it lives in the admin menu

The module adds no admin page of its own. You work with it entirely from the
ImageAPI Optimize pipelines screen at **Configuration → Media → Image Optimize
pipelines** (`/admin/config/media/imageapi-optimize-pipelines`).

## How to use it

1. Make sure the ImageAPI Optimize module is installed and enabled (see
   [Installation](installation/index.md)).
2. Go to **Configuration → Media → Image Optimize pipelines**.
3. Add a new pipeline, or edit an existing one.
4. Add an **LQIP** processor to the pipeline and save.
5. Point an image style at that pipeline. From then on, whenever a derivative is
   generated through the pipeline, a low-quality placeholder is created next to
   the original image.

To display the placeholders, either enable the bundled *ImageAPI Optimize LQIP
Responsive* module, which handles it for you, or reference the generated LQIP
file in your theme.
