# TinyPNG — manual setup guide

**TinyPNG** (`tinypng`) connects Drupal's image handling to the external
**TinyPNG / Tinify** compression service, which shrinks PNG and JPEG files with
smart lossy compression. Smaller images mean faster pages, better Core Web
Vitals scores, and lower bandwidth and storage costs — all without you manually
optimizing files. TinyPNG can either compress **every image on upload**, or
compress only the derivatives of the **image styles you flag** for it (leaving
the originals untouched).

Compression happens on TinyPNG's servers, so the module needs an **API key** from
tinypng.com. The free tier allows 500 compressions per month, which is why the
per-image-style option is handy — you can point compression only at your
high-traffic styles to stay within the limit. Without a valid key, nothing is
compressed.

Everything is controlled from one small settings form. You paste in your API key,
choose whether to compress on upload, pick how images reach TinyPNG (send the
bytes, or let TinyPNG fetch them by URL), and decide whether to enable the
per-image-style compression checkbox. Access to that form is gated by the
module's own permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer
   (including the required Tinify library) and enable it.
2. [Configuration](configuration/index.md) — set your API key, choose the
   compression mode, and flag image styles.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → Media → TinyPNG**
(`/admin/config/tinypng`). Per-image-style compression is turned on from each
image style's edit form under **Configuration → Media → Image styles**.
