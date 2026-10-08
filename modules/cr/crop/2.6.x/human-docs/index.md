# Crop API — manual setup guide

**Crop API** (`crop`) is the storage layer and API that Drupal modules use to
remember image crops. It defines reusable crop presets called **crop types** —
each one a named recipe such as "16:9 hero" with a fixed aspect ratio and
optional size limits — and it stores the actual crop selection an editor makes
for a given image as a `crop` entity (the crop's centre point, width and height).
A **Crop** image effect then re-applies that stored selection whenever an image
style generates a derivative, so a cropped photo stays cropped the same way at
every size.

Crop API is deliberately a **foundation module**: it has **no cropping widget of
its own**. On its own it lets you define crop types and nothing more — the
actual drag-a-box-over-the-image editing UI is provided by a *consuming* module
such as **Image Widget Crop** or **Focal Point**, which save their selections
through Crop's API. This guide is written for a **human** clicking through the
admin UI, and it focuses on the one thing you configure by hand in Crop itself:
managing crop types. For terse, token-cheap references aimed at an AI coding
agent, read the sibling [`agent/`](../agent/start.md) docs instead.

![The Crop types list page under Configuration → Media](images/types.png)

## Where it lives in the admin menu

Crop's only admin screen sits under **Configuration → Media → Crop types**
(`/admin/config/media/crop`). It lists every crop type on the site and gives you
an **+ Add crop type** button to create more. There are no global "settings"
form and no other menu items — Crop is intentionally small.

## Contents

1. [Installation](installation/index.md) — install Crop API with Composer and
   enable it.
2. [Configuration](configuration/index.md) — create and manage crop types, and
   understand how a crop type is put to work by an image style and a consuming
   UI module.
