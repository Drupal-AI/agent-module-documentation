# Image Optimize (ImageAPI Optimize) — manual setup guide

**Image Optimize** (`imageapi_optimize`) — historically called *ImageAPI
Optimize* — lets you compress the images Drupal generates, automatically, without
changing anything about how content is authored. It introduces the idea of an
**optimization pipeline**: an ordered list of processor plugins that each transform
a generated image file — stripping metadata, recompressing a JPEG or PNG,
converting to WebP, and so on. You attach a pipeline to your core image styles, and
from then on every derived image runs through it.

You build and manage pipelines at **Configuration → Media → Image Optimize
pipelines**. There you create a pipeline, add processors to it, order them by
weight (so lossless steps run before lossy ones, for example), and configure each
processor's settings. You can set one pipeline as the site‑wide default, and assign
a specific pipeline to an individual image style to override that default — handy
for compressing thumbnails harder than hero images. Because a pipeline is a
configuration entity, it exports and deploys cleanly between environments.

It is important to know that this base module provides the *framework*, not the
optimizers themselves. It ships the pipeline config entity, the
`ImageAPIOptimizeProcessor` plugin type, base classes, and the admin UI — but the
actual optimizers (reSmush.it, local binaries such as jpegoptim/optipng, and
others) arrive as **separate processor plugins** from companion projects. Install
one or more of those to have real processors to add to your pipelines. Developers
can write their own processor plugins or alter the available list with
`hook_imageapi_optimize_processor_info_alter()`. Flushing a pipeline regenerates
the affected derivatives. It is a straightforward performance and SEO win: lighter
images, better Core Web Vitals, no editorial changes. It needs nothing beyond
Drupal core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — creating pipelines, adding
   processors, setting a default, and assigning a pipeline to an image style.

## Where it lives in the admin menu

Pipelines are managed at **Configuration → Media → Image Optimize pipelines**
(`/admin/config/media/imageapi-optimize-pipelines`, route
`entity.imageapi_optimize_pipeline.collection`). You need the **Administer imageapi
optimize pipelines** permission to reach it.

## How to use it

1. Enable this module and at least one processor module (see
   [Installation](installation/index.md)).
2. Go to **Configuration → Media → Image Optimize pipelines** and create a
   pipeline.
3. Add and order the processors you want, and configure each one — see
   [Configuration](configuration/index.md).
4. Set the pipeline as the site default, or assign it to a specific image style.
5. **Flush** the pipeline (or the affected image styles) to regenerate derivatives
   with the new optimization applied.
