# Crop or Fill — manual setup guide

**Crop or Fill** (`crop_or_fill`) is an image-style effect that intelligently
handles the mismatch between an image's orientation and the shape you're asking it
to fit. Ordinarily, forcing a portrait photo into a landscape (16:9) slot crops away
most of the picture. Crop or Fill looks at the orientations and decides what to do:

- **Same orientation** (e.g. a portrait image in a portrait ratio) — it crops
  normally, using the Crop API.
- **Opposite orientation** (e.g. a portrait image in a landscape ratio) — instead of
  cropping, it builds a canvas matching the target aspect ratio, fills it with a
  background color you choose, and centers the original image on it. Nothing is cut
  off — you get colored bars on the sides, like letterboxing or pillarboxing.
- **Square crop** — treated as "same orientation", so it always crops normally.

The classic use case is a "Hero" image style with a landscape crop type where
editors sometimes upload portrait photos: with a standard crop effect those images
would be gutted, but with Crop or Fill the whole photo is preserved on a colored
canvas. It's equally handy for normalizing mixed-orientation galleries, teasers, and
thumbnails to consistent output dimensions without losing content.

Crop or Fill extends the **Crop API** module (`crop`) and reuses your existing crop
types. It supports both the GD and ImageMagick image toolkits (the ImageMagick
module is optional). It works on Drupal 10.3 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and the Crop API dependency).
2. [Configuration](configuration/index.md) — add the effect to an image style and
   set its crop type and background color.

## Where it lives in the admin menu

Crop or Fill doesn't add a page of its own — you add its effect to an image style at
**Configuration → Media → Image styles** (`/admin/config/media/image-styles`).
