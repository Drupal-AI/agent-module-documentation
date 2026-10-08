# Generate Social Media Image — manual setup guide

**Generate Social Media Image** (`gsmi`) automatically produces per‑page share
images — the picture that appears when someone posts your page to a social
network — by overlaying a node's own data (its title, author, creation date, and
so on) onto a base image. The result is a tailored, meaningful Open Graph /
Twitter‑card image for every page, generated for you instead of designed by hand.

The 2.0.x release is a ground‑up rebuild that leans on Drupal's own tooling rather
than custom drawing code. You create a normal **image style** that includes the
**Text overlay** effect from the **Image Effects** module, and you put tokens
like `[node:title]` in that overlay text. When the module generates an image for a
node, it swaps those tokens for the node's real values. There is no upgrade path
from the old 1.x series — 2.0.x is a fresh setup.

Once configured, the module hands you tokens you can drop into your meta‑tag
configuration to output the finished image's URL — for example `[node:generate-style]`
uses the image style and field you chose on the settings page, and there are
variants for targeting a specific style or field.

Performance is handled for you: each image is generated once, written to the
public file system, and then served directly by the web server without booting
Drupal again. Images are re‑generated automatically when a node changes or when
the module's settings change, every translation of a node gets its own image, and
a `drush gsmi:flush` command clears them all. If an external cache (a CDN or a
social‑media crawler) requests an old image URL, the module redirects to the
current image instead of returning a 404.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, satisfy the
   image‑toolkit and font requirements, and enable the module.
2. [Configuration](configuration/index.md) — build the image style, pick the field
   and style on the settings page, and use the generated tokens.

## Where it lives in the admin menu

The settings page is at **Configuration → Media → Generate Social Media Image**
(`/admin/config/media/gsmi`).
