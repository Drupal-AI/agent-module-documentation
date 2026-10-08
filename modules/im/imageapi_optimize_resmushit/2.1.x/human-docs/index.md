# Image Optimize - reSmush.it — manual setup guide

**Image Optimize - reSmush.it** (`imageapi_optimize_resmushit`) adds a single
image‑optimize **processor** — `resmushit` — to the Image Optimize (ImageAPI
Optimize) pipeline system. Each image derivative your site generates is sent to
the free [reSmush.it](https://resmush.it) web service for compression, and the
smaller result is saved back in place. It is a handy way to shrink image weight
without installing local binaries like jpegoptim, optipng, or pngquant — useful
on hosts where you cannot run CLI tools.

The processor has no admin page or configuration entity of its own. Instead, you
use it *inside* an Image Optimize **pipeline**, then attach that pipeline to one or
more image styles so every generated derivative gets optimized. It exposes exactly
one setting — **JPEG image quality** (an integer 1–100). Leave it blank to let
reSmush.it use its own default optimization, or set a value to trade fidelity for
smaller files (for example, aggressive for thumbnails, gentle for hero images).

Because optimization is a **live call to the third‑party reSmush.it API**, an
actual run needs outbound network access and the remote service to be up. If the
service is unreachable, the failure is logged and your original image is left
untouched. Note this is a **beta** release (`2.1.0-beta1`).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and its
   `imageapi_optimize` dependency) with Composer and enable it.

## Where it lives in the admin menu

It has no page of its own. You work with it under the Image Optimize pipelines UI
at **Configuration → Media → Image Optimize pipelines**
(`/admin/config/media/imageapi-optimize-pipelines`), which is provided by the
required **Image Optimize** module. Managing pipelines needs the **Administer
ImageAPI Optimize pipelines** permission.

## How to use it

1. Enable this module (which pulls in **Image Optimize**).
2. Go to **Configuration → Media → Image Optimize pipelines** and click **Add
   pipeline** (or edit an existing one). Give it a label and machine name, and
   save.
3. On the pipeline, choose **Add a new processor → Resmush.it**.
4. Set **JPEG image quality** (1–100), or leave it blank to send no quality, and
   save.
5. Attach the pipeline to an image style so that style's derivatives are optimized
   through reSmush.it. You can chain the processor after a resize/crop step in a
   multi‑step pipeline, and reuse one pipeline across many image styles for a
   consistent, site‑wide compression policy.

Because the processor's setting is stored inside the pipeline's configuration, you
can export a reSmush.it pipeline as config and deploy it across environments.
