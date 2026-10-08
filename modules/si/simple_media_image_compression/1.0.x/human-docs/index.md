# Simple Media Image Compression — manual setup guide

**Simple Media Image Compression** (`simple_media_image_compression`) automatically
re‑compresses JPEG images when you save content. Whenever a **node** or **paragraph**
is saved, the module looks at the media images that content references — including
media used as a background — and, for JPEG files only, re‑encodes them at a quality
you choose, using PHP's built‑in **GD** library. The result is smaller image files,
lower bandwidth on image‑heavy pages, and no dependence on any external optimisation
service or third‑party API.

The behaviour is driven by a small settings form with two values: an **Enable
Compression** switch and a **JPEG quality** number (between 10 and 100, defaulting to
70). When compression is enabled, saving content walks its fields, finds
entity‑reference fields pointing at the media **image** bundle, resolves each media
item's image file, and re‑compresses it in place — but only when the file is a JPEG.
Non‑JPEG images such as PNGs are left completely untouched.

**One caveat matters a great deal:** compression is **lossy and destructive to the
original file**. The module rewrites the original image on disk at its real path, and
there is **no backup** of the pre‑compression version. Re‑saving the same content
repeatedly recompresses and degrades the image further each time. Keep untouched
source originals somewhere else if you might need them. On the security side there is
little to worry about: the settings form is gated by the core **administer site
configuration** permission, there are no anonymous endpoints, no external calls, and
no secrets — the module only ever operates on images that have already been uploaded,
and the quality value is validated as a number in range.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — turn compression on, choose a quality,
   and understand how and when it runs.

## Where it lives in the admin menu

The settings form (`image_compression.settings`) sits under **Configuration → System
→ Simple Media Image Compression**
(`/admin/config/system/simple_media_image_compression/config`), behind the core
*administer site configuration* permission.
