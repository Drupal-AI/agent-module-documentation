# Batch Resize Image — manual setup guide

**Batch Resize Image** (`batch_resize_image`) gives you an easy way to bulk‑resize
the image files already sitting in your site's files folder. It runs a batch that
resizes the stored image files — for example to cap their dimensions or reduce
their size — which is handy for cleaning up oversized uploads across a site in one
pass.

It is an administrative/media tool, meant to be run by an administrator. It has no
content or access‑control role of its own.

**One important warning:** it **modifies the files in place** — it resizes the
actual stored images, so the original dimensions are lost and cannot be recovered
from the resized files. **Back up your files directory before you run it.**

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## Where it lives in the admin menu

Once enabled, the module adds its resize operation to the admin UI (under the
**Images** package), for administrators to run.

## How to use it

1. **Back up your files directory first** — the resize overwrites the original
   images and the original dimensions are lost.
2. Enable the module (see [Installation](installation/index.md)).
3. As an administrator, run the batch resize. It processes the image files in the
   files folder, resizing them (e.g. capping dimensions / reducing size) in
   place, working through them in batches so large libraries don't time out.
