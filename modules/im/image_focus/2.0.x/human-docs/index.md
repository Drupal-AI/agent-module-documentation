# Image Focus — manual setup guide

**Image Focus** (`image_focus`) adds a smarter cropping option to Drupal's image
styles. It provides a **"Focus Scale and Crop"** image effect that automatically
works out where the interesting part of an image is and crops around *that*,
instead of blindly cropping the center the way core's "Scale and crop" does. The
result is better square thumbnails, teaser cards that don't slice off the subject,
and hero/banner derivatives that stay focused on the busiest region.

It figures out the focal point automatically using an **entropy** measure: the
image is split into square zones, the visual "busyness" of each zone is scored,
and the effect crops toward the entropy‑weighted center of interest. There's no
JavaScript focal‑point picker to install and no per‑image setup for editors — the
effect just runs when a derivative is generated. If the source can't be decoded
for some reason, it falls back gracefully to a plain center crop.

Because it reads pixels directly through PHP's GD extension on the source file, it
works whether your site uses the **GD** or **ImageMagick** image toolkit. It
depends only on core's **Image** module, and has no permissions or Drush commands
of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## Where it lives in the admin menu

You add the effect to image styles at **Configuration → Media → Image styles**
(`/admin/config/media/image-styles`). The module also has a small settings page at
**Configuration → Media → Image focus settings**
(`/admin/config/media/image-focus-settings`), which needs the **Administer site
configuration** permission.

## How to use it

**Add the effect to an image style.** Go to **Configuration → Media → Image
styles**, then create or edit a style and choose **Add effect → Focus Scale and
Crop**. Like any resize/crop effect it takes a target **width** and **height** —
enter those and save. From then on, every derivative that style produces is scaled
and cropped toward the image's automatically detected focal point. You can reuse
the same effect across several styles at different sizes, and combine it with other
effects (convert, desaturate, and so on) in the same style.

**Optional module setting.** The settings page at **Configuration → Media → Image
focus settings** has one field, **Max image size** (`image_focus_face_detection_maxsize`),
measured in **KB** and defaulting to **50**. It bounds the source size considered
for the heavier processing path. You can change it from the UI or with Drush:

```bash
drush config:set image_focus.settings image_focus_face_detection_maxsize 200 -y
```

(The effect's configuration schema also carries a `face_detect` flag, but the
2.0.x effect always uses the entropy method and does not act on that flag — smart
cropping works out of the box with no extra toggles.)
