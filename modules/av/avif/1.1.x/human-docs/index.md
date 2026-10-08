# Avif — manual setup guide

**Avif** (`avif`) makes your site's images smaller for the browsers that can take
advantage of it. Whenever Drupal creates an image‑style derivative (the resized
copies it produces for teasers, thumbnails, hero images and so on), Avif also
generates an **AVIF** copy of it. AVIF is a modern image format that typically
beats both JPEG and WebP at the same visual quality, often by a wide margin — so
browsers that support it download much smaller files, while everything else keeps
the original. That makes it one of the cheaper page‑weight wins available:
faster loads, lower bandwidth, better Core Web Vitals, and no change to your
existing image styles.

Under the hood Avif plugs into Drupal's image pipeline and defines a **converter
plugin type**, so the actual encoding can be done by whichever backend your host
provides — GD, Imagick, or a command‑line encoder. It depends only on core's
Image module. This release is **1.1.0‑rc1**, a release candidate, and it requires
Drupal 10.3 or 11.

Two practical points matter as much as the savings. First, **AVIF encoding is
expensive** — noticeably slower than JPEG. If derivatives are generated on the
first request for an image, an uncached large image can be slow enough to time
out, so it is worth planning a "warming" strategy that generates the AVIF copies
ahead of time. Second, AVIF browser support is broad but not universal, so the
**fallback path is what actually serves some visitors** — test it rather than
assuming it works.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Avif adds a settings form at **`/admin/config/media/avif`** (reachable by users
with the *Administer site configuration* permission). It controls how the module
behaves. Before relying on it in production, confirm which AVIF encoder your
server actually offers — GD's AVIF support depends on how PHP was built, and
Imagick's depends on the linked ImageMagick — and plan to warm your image
derivatives so first‑request encoding does not slow real page loads.

## How to use it

1. Enable the module and open **`/admin/config/media/avif`**.
2. Confirm your host has a working AVIF encoder (GD, Imagick, or a CLI encoder).
3. Warm your image derivatives (for example by requesting key pages, or with a
   crawler) so AVIF copies are generated before real visitors hit them.
4. Test the experience in a browser that does **not** support AVIF to make sure
   the fallback image is served correctly.
