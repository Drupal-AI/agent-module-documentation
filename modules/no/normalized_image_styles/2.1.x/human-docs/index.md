# Normalized Image Styles — manual setup guide

**Normalized Image Styles** (`normalized_image_styles`) generates large, consistent
sets of **aspect‑ratio‑based image styles** with normalized pixel dimensions, ready
to plug into Drupal core's **Responsive Image** module as part of a site
performance strategy. Instead of hand‑creating dozens of image styles, you enable
the aspect ratios you want and let the module materialise a full ladder of sizes
for each.

It ships around **40 sub‑modules** — one per aspect ratio (16:9, 21:9, 32:9,
anamorphic, DCI, widescreen, golden, 3:2, 4:3, 5:4, square 1:1, the portrait
variants, and a "scaled‑max" set), plus a matching **WebP** twin of each. Every
sub‑module is a config‑only migration that emits a ladder of image styles at 17
normalized base widths (from 128px up to 3840px). Each set (except "Scaled") uses a
**Focal Point** scale‑and‑crop effect so the important region survives every crop,
and an **Image Style Quality** effect that tapers JPEG quality as dimensions grow.
Enabling every ratio produces a very large number of image styles (all 40 sets
would create 680), so enable only the ratios you actually need.

Because it's built on migrations, the module has **no settings form** and adds no
routes or permissions of its own. You operate it through the standard **Extend**
page (to enable ratios), the core **Migrate UI** or Drush (to import the styles),
and finally the core **Image styles** page and Responsive Image, where the
generated styles behave like any other image style. It depends on the core
**Image** and **Migrate** modules plus **Image Style Generate**, **Migrate Plus**,
**Migrate Tools**, **Focal Point** and **Image Style Quality**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   ratios you need, import the styles with Migrate, and (optionally) uninstall the
   modules afterwards.

There is **no configuration form** — the module is operated through the Extend and
Migrate pages, described in Installation. The generated image styles are then
managed like any other at **Configuration → Media → Image styles**.

## Where it lives in the admin menu

- Enable the ratio sub‑modules on the **Extend** page (`/admin/modules`).
- Import the styles through the Migrations UI at
  `/admin/structure/migrate/manage/normalized_image_styles/migrations`, or with
  Drush (see Installation).
- The generated image styles appear at **Configuration → Media → Image styles**
  (`/admin/config/media/image-styles`), where you wire them into a Responsive
  Image style set and configure your image fields to use it.

## Set the focal point widget

Because the generated styles crop around a focal point, set the media Image form
to use the **Image (Focal Point)** widget at
`/admin/structure/media/manage/image/form-display`. Editors can then choose the
focal point on each image's edit page, and every Normalized Image Styles set will
respect that choice when cropping to its aspect ratio.
