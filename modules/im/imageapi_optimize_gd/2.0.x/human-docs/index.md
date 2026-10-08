# ImageAPI Optimize GD — manual setup guide

**ImageAPI Optimize GD** (`imageapi_optimize_gd`) adds a **GD** processor to the
ImageAPI Optimize (Image Optimize) module. It re-compresses your JPEG and WebP
image-style derivatives at a quality percentage you choose, using PHP's built-in
GD library — so you get lighter images with **no external binaries** to install.

That last part is the point: most image optimizers shell out to command-line
tools like jpegoptim or optipng, which you can't always install on managed
hosting. This processor stays entirely in-process (pure PHP), which makes it a
great fit for security-restricted or shared hosts, or as a fallback when
binary-based optimizers aren't available. Smaller derivatives mean lower page
weight, better Core Web Vitals, and reduced storage and CDN costs.

It works by plugging into an Image Optimize **pipeline**. When an image style
generates a derivative, the pipeline runs its processors in order; the GD
processor re-opens JPEG/WebP derivatives and re-saves them at your chosen quality.
It only touches the file types you enable (JPEG and/or WebP) and silently skips
everything else. It never modifies the original uploaded image — only the
generated derivatives. (If PHP happens to be built without GD, the processor logs
a notice and simply does nothing.)

The recommended pattern is to leave Drupal's sitewide GD toolkit at 100% quality
and let your Image Optimize pipelines own per-style quality — that keeps
compression cleanly separate from crop/scale/overlay effects. You can build, for
example, a high-quality pipeline for hero images and a lower-quality one for
thumbnails.

There is no admin settings page of its own, no permission, and no Drush command —
all its configuration lives on the pipeline you add it to.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and its ImageAPI
   Optimize dependency) with Composer and enable it.
2. [Configuration](configuration/index.md) — add the GD processor to a pipeline,
   set its quality and file types, and apply the pipeline to image styles.

## Where it lives in the admin menu

The GD processor is configured within ImageAPI Optimize's own admin area:
**Configuration → Media → Image Optimize pipelines**
(`/admin/config/media/imageapi-optimize-pipelines`), and applied to image styles
at **Configuration → Media → Image styles**.
