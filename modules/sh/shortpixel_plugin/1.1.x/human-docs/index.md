# ShortPixel ImageAPI Optimize processor — manual setup guide

**ShortPixel ImageAPI Optimize processor** (`shortpixel_plugin`) plugs the ShortPixel
image-optimization service into Drupal's **ImageAPI Optimize** module as an
optimization processor. In plain terms: when Drupal generates an image derivative
(the resized versions your image styles produce), this processor uploads that
generated file to ShortPixel, gets back a smaller optimized version, and swaps it in
— so your pages load faster without you touching a thing per image.

It is careful about *which* file it touches. Only the generated image-style file is
optimized and overwritten; your **original source image is left untouched**, which
keeps everything in line with how Drupal expects image handling to work. Behind the
scenes it uploads the derivative to ShortPixel's POST-Reducer API, polls until the
optimization is finished, and then replaces the style file with the optimized result.

You choose how aggressively to compress. ShortPixel's three standard modes are all
supported — **Lossy** (the best size-versus-quality balance, good for most sites),
**Glossy** (high quality with minimal visible loss, good for photography), and
**Lossless** (pixel-perfect, best for technical graphics) — and you pick the mode
right in the processor's configuration. There is also an optional **CDN delivery
mode**, where instead of uploading derivatives the module rewrites your public image
URLs to ShortPixel's Adaptive Images CDN and lets the CDN handle optimization and
format negotiation.

To use it you need a **ShortPixel API key**, which is free to get (the free tier
covers 100 optimizations a month). Treat that key as a secret — keep it in an
environment variable rather than hard-coding it. This module is a processor plugin for
ImageAPI Optimize, so it has no settings page of its own; you configure it from within
an ImageAPI Optimize pipeline.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it, along with its ImageAPI Optimize dependency.

## How to use it

There is no standalone settings form. You work inside **ImageAPI Optimize**:

1. Create or edit an ImageAPI Optimize pipeline and **add the ShortPixel processor**
   to it.
2. In the processor's configuration, enter your **ShortPixel API key** and pick a
   **compression mode** (Lossy, Glossy, or Lossless).
3. Optionally enable **CDN delivery** — turn on "Rewrite public image URLs to
   ShortPixel CDN" and set the CDN base URL (for example `https://cdn.shortpixel.ai`,
   `https://no-cdn.shortpixel.ai`, or your own CDN host). When CDN mode is on, local
   uploads are skipped and the CDN does the optimization.
4. Assign the pipeline to your image styles as usual.

From then on, whenever Drupal builds an image style derivative, the processor
optimizes it through ShortPixel automatically while leaving your originals alone.
