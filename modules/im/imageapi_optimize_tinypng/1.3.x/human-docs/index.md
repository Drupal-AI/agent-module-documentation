# Image Optimize - TinyPNG — manual setup guide

**Image Optimize - TinyPNG** (`imageapi_optimize_tinypng`) adds a **TinyPNG
processor** to Drupal's ImageAPI Optimize (a.k.a. Image Optimize) system, so the
JPEG and PNG image derivatives your site generates are automatically compressed
through the hosted [TinyPNG](https://tinypng.com/) / Tinify web service. The result is
noticeably smaller images — less bandwidth, faster pages, and better Core Web Vitals
(especially Largest Contentful Paint) — without you installing any command‑line
optimizer binaries on the server. That makes it a great fit for hosting where you
can't run tools like `jpegoptim` or `optipng`.

It works within the Image Optimize *pipeline* system. You build a pipeline, add
**TinyPNG** as a processing step (you can combine it with other steps like resizing or
WebP conversion), then assign that pipeline to one or more image styles. From then on,
every derivative those styles produce is sent to TinyPNG, compressed, and written back
— while your original source images stay untouched.

The processor has just one setting: your **TinyPNG API key**, which it validates live
against TinyPNG when you save. Because every optimized derivative is one metered API
call against your TinyPNG account, it's worth scoping the pipeline to the image styles
that benefit most (large hero images, for example) to control cost and quota. Failures
— like exceeding your monthly quota or a network hiccup — are caught and logged, and
the un‑optimized derivative is simply left in place.

Since the API key is a credential, keep production keys out of committed configuration
exports and provide them per‑environment instead — see
[Configuration](configuration/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (it pulls in the Tinify PHP library).
2. [Configuration](configuration/index.md) — add the TinyPNG processor to a pipeline,
   enter your API key, and assign the pipeline to image styles.

## Where it lives in the admin menu

There is no page of its own. You configure it as a processor under **Configuration →
Media → Image Optimize pipelines**
(`/admin/config/media/imageapi-optimize-pipelines`), and assign the resulting
pipeline on each image style's edit form.

## How to use it

1. Get a TinyPNG API key from <https://tinypng.com>.
2. Install and enable the module.
3. Create an Image Optimize pipeline and add the **TinyPNG** processor with your key.
4. Assign that pipeline to the image styles you want optimized.
5. Flush an image style to regenerate its derivatives through TinyPNG.

The full walkthrough is in [Configuration](configuration/index.md).
