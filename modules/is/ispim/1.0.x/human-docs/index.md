# Image Style Preview Image Manager — manual setup guide

**Image Style Preview Image Manager** (`ispim`) is a small site-building utility
that fixes a long-standing annoyance in Drupal: when you edit an image style, core
only ever previews the effect against a **single hard-coded sample image** (the
famous hot-air balloon over the vineyards). ISPIM lets you **curate your own list of
sample images** and preview any image style against a real, representative picture
instead.

Under the hood it defines its own content entity type, `ispim_preview_image`, so you
can **add, edit, and delete** as many sample images as you like. The entities are
revisionable and translatable, and they get their own management screen. A small
JavaScript behaviour then **swaps the previewed image live** on the image-style admin
pages, so you can judge how a crop or scale will actually look on your content.

It is most useful during the **initial configuration phase** of a project, while you
are tuning image styles; once the styles are settled you can disable it again. It
depends only on core's **File** and **Image** modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — upload and manage your preview images
   and control who may do so.

## Where it lives in the admin menu

Your curated preview images are managed at **Configuration → Media → Image Style
Preview Images** (`/admin/config/media/ispim-preview-image`). You then use them from
the standard image-style pages at **Configuration → Media → Image styles**
(`/admin/config/media/image-styles`).

## How to use it

1. Upload one or more preview images at
   `/admin/config/media/ispim-preview-image` (see [Configuration](configuration/index.md)).
2. Go to **Configuration → Media → Image styles** and click **Edit** on any image
   style.
3. The preview on that page now uses your chosen image, so you can see the real
   effect of the style's crops and scaling.
