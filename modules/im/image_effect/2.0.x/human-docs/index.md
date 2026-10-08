# Image Effect — manual setup guide

**Image Effect** (`image_effect`) adds an **"advance resize"** effect to Drupal's
image styles, giving you more control over resizing than core's built-in
resize/scale effects. In particular it can resize an image to an **exact set of
dimensions without cropping, stretching, or shrinking the content** — instead
padding the leftover space with a white or transparent background so the image fits
the target box precisely.

It plugs into Drupal's standard image system, so the effect is available wherever
image styles are: add it to a style, and it applies whenever a derivative image for
that style is generated. It provides toolkit operations for **both GD and
ImageMagick (imagick)**, so it works with whichever image toolkit your site is set
to use. All processing is local — nothing is sent to an external service.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — add the advance resize effect to an
   image style and set its dimensions.

## Where it lives in the admin menu

Image Effect has no settings page of its own. It surfaces as a new effect choice
inside the core **image styles** editor at **Configuration → Media → Image styles**
(`/admin/config/media/image-styles`), which requires the **Administer image styles**
permission.
