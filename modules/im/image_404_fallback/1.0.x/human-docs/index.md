# Image 404 Fallback — manual setup guide

**Image 404 Fallback** (`image_404_fallback`) catches requests for image files
that no longer exist and serves a placeholder image instead of returning a 404
error. The result is that broken image links show a clean fallback rather than the
browser's broken-image icon, so your layouts stay intact even when a file is
missing.

This is a common problem after a content migration, or when an image derivative
has been purged and its source file is gone. Rather than leaving gaps and broken
icons across the site, the module quietly substitutes a fallback whenever an image
URL would otherwise 404. It supports the usual image formats (JPG, PNG, GIF, WebP,
SVG, BMP, ICO, AVIF) and ships with a built-in default placeholder, and it sets
proper HTTP headers and caching on the response.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — point it at your own fallback image
   (optional; it works with a built-in default out of the box).

## Where it lives in the admin menu

Once enabled, its settings sit at **Configuration → Media → Image 404 Fallback
Settings** (`/admin/config/media/image-404-fallback`). The module has no content or
access-control role — it simply responds to image 404s with the configured
fallback.
