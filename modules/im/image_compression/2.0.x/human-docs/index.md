# Image Compression — manual setup guide

**Image Compression** (`image_compression`) reduces the file size of **JPEG and
PNG** images to save disk space and bandwidth and to speed up page loads. It works
in two ways: it can compress images **automatically as they are uploaded**, and it
can **bulk-compress the images already on your site** through a batch process.

All the work is done **in-process with PHP's built-in GD library** — the module
re-encodes JPEGs and PNGs locally. It does **not** send your images to any external
service, so there is no third-party API, no API key, and nothing leaves your server.
You control how aggressively it compresses through a simple table of rules: "images
at or above size X are compressed at rate Y".

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   check file-directory permissions.
2. [Configuration](configuration/index.md) — the size/rate rules, the
   compress-on-upload toggle, and the bulk "compress existing images" batch.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → Image compression**
(`/admin/config/user-interface/image_compression`), and the bulk tool is at
`/admin/config/user-interface/compress_existing_images`. Both require the
**Administer site configuration** permission.
