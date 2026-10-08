# WebP — manual setup guide

**WebP** (`webp`) automatically generates **WebP copies of the images produced by
your image styles** and serves them to browsers that support the WebP format. WebP
is a modern image format that is substantially smaller than JPEG or PNG at
equivalent quality, so swapping it in shrinks the weight of every image on the page
and speeds up page loads. Whenever Drupal creates an image-style derivative, WebP
produces a matching `.webp` copy alongside it and, on responsive images, adds those
`.webp` sources to the `<picture>` element. Browsers that understand WebP pick it;
browsers that don't fall back gracefully to the original JPEG/PNG in the same
`<picture>` — so nothing breaks for anyone.

This guide is written for a **human** clicking through the admin UI. It walks you,
step by step and with a screenshot, from installing the module to setting the WebP
compression quality. If you are looking for terse, token-cheap references for an AI
coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

![The WebP settings page with the Image quality field](images/settings.png)

## Where it lives in the admin menu

WebP adds a single settings page at **Configuration → Media → WebP**
(`/admin/config/media/webp/settings`). That page holds the one global option the
module exposes — the WebP compression quality — and applies it to every WebP
derivative generated across all of your image styles.

## Contents

1. [Installation](installation/index.md) — install WebP with Composer, enable it,
   and confirm your image toolkit can write WebP files.
2. [Configuration](configuration/index.md) — set the WebP compression quality and
   understand how the module serves WebP with a fallback to the original format.
